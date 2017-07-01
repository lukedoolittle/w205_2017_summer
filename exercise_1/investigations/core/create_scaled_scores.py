from pyspark import SparkConf, SparkContext
from pyspark.sql.types import *
from pyspark.sql import HiveContext
import decimal

sqlContext = HiveContext(SparkContext(conf=SparkConf().setAppName("investigations")))
high = decimal.Decimal('1.0')
medium = decimal.Decimal('0.5')
low = decimal.Decimal('0.1')

# Create a dictionary that contains the user defined weights for each applicable measure	
# a -1 as a weight multiplier indicates the metric is inverted: a higher score is worse		
weights = dict([('READM_30_HOSP_WIDE', -1 * high), 
				('READM_30_AMI', -1 * high),
				('READM_30_STK', -1 * high),
				('READM_30_STK', -1 * high),
				('READM_30_PN', -1 * high), 
				('READM_30_COPD', -1 * high), 
				('READM_30_HF', -1 * high), 
				('READM_30_HIP_KNEE', -1 * high),
				('MORT_30_PN', -1 * high), 
				('MORT_30_HF', -1 * high), 
				('MORT_30_COPD', -1 * high), 
				('MORT_30_STK', -1 * high),
				('MORT_30_AMI', -1 * high),
				('MORT_30_PN_HVBP_Performance', high),
				('MORT_30_HF_HVBP_Performance', high),
				('MORT_30_AMI_HVBP_Performance', high),
				('IMM_2', high),
				('IMM_2_HVBP_Performance', high),
				('IMM_3_OP_27_FAC_ADHPCT', high),
				('ED_1b', -1 * high), 
				('ED_2b', -1 * high), 
				('OP_22', -1 * high),
				('OP_18b', -1 * high),
				('OP_20', -1 * high), 
				('OP_21', -1 * high),
				('OP_14', -1 * medium),
				('OP_5', -1 * medium),
				('OP_29', medium),
				('OP_30', medium),
				('OP_4', low),
				('COMP_HIP_KNEE', -1 * medium),
				('PSI_90_SAFETY', -1 * high),
				('PSI_12_POSTOP_PULMEMB_DVT', -1 * high),
				('PSI_6_IAT_PTX', -1 * high),
				('PSI_15_ACC_LAC', -1 * medium),
				('PSI_7_CVCBI', -1 * high),
				('PSI_3_ULCER', -1 * low),
				('PSI_14_POSTOP_DEHIS', -1 * low),
				('PSI_13_POST_SEPSIS', -1 * high),
				('OP_25', low), 
				('OP_17', medium), 
				('OP_12', medium), 
				('OP_10', -1 * low), 
				('OP_11', -1 * low), 
				('OP_9', -1 * low), 
				('OP_13', -1 * low),
				('SM_SS_CHECK', low),
				('SM_PART_NURSE', low),
				('SM_PART_GEN_SURG', low)])

# Get the range of scores for each applicable metric and convert into a dictionary
rangesSql = 'select metric_id, max(score) maximum, min(score) minimum from scores group by metric_id'
ranges = dict((range['metric_id'], range) 
			   for range 
			   in map(lambda row: row.asDict(), 
								  sqlContext.sql(rangesSql).collect()))
								  
# An adjustment to the score: first we normalize the score over [0,1] and then
# we apply the pre-chosen weight for each metric
adjust = lambda score, metric: ((score - ranges[metric]['minimum'])
							    / (ranges[metric]['maximum'] - ranges[metric]['minimum'])
							    * weights[metric])

# Perform a map-reduce over all pre-selected scores to get the average of available
# scores. If the provider has scores for less than half of the selected metrics then
# do not include them in the ratings

# Generate a temp table with a map over the provider and scaled score, all the rows from the scores table where the metric is one of the chosen measures
scaledScoresSql = ('select * from scores where score is not null and metric_id in ({0})'
				   .format(','.join(['\'' + member + '\'' 
									for member 
									in weights.keys()])))
(sqlContext.sql(scaledScoresSql)
		   .map(lambda row: (row.provider_id, 
							 adjust(row.score, row.metric_id)))
		   .toDF()
		   .selectExpr("_1 as provider_id", 
					   "_2 as scaled_score")
		   .registerTempTable('scaled_scores'))
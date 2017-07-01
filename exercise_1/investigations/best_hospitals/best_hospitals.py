from pyspark.sql.types import *
import os 

# Generate the scaled scores table
execfile(os.path.join(os.path.dirname(os.path.realpath(__file__)), 
			          '../core/create_scaled_scores.py'))

# Utilize the scaled_scores table to create the average and variance of each scaled score
resultSql = 'select hospital_name, overall_score, mean_scaled_score from (select provider_id, avg(scaled_score) mean_scaled_score, sum(scaled_score) sum_scaled_score, var_samp(scaled_score) variance_scaled_score, count(*) score_count from scaled_scores group by provider_id) a join providers on a.provider_id = providers.provider_id where score_count > {0} order by mean_scaled_score desc'.format(.5 * len(weights))
result = sqlContext.sql(resultSql)
result.show(20, False)
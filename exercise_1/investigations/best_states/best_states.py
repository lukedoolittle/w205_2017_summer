from pyspark.sql.types import *
import os 

# Generate the scaled scores table
execfile(os.path.join(os.path.dirname(os.path.realpath(__file__)), 
			          '../core/create_scaled_scores.py'))

nonStates = ['PR', 
			 'VI', 
			 'SD', 
			 'AS', 
			 'GU', 
			 'MP']

# Utilize the temporary table to create the average and variance of each scaled score by state
# In addition filter out non-states such as Guam
resultSql = ('select state, avg(scaled_score) mean_scaled_score, sum(scaled_score) sum_scaled_score, var_samp(scaled_score) variance_scaled_score, count(*) score_count from scaled_scores join providers on scaled_scores.provider_id = providers.provider_id where state not in ({0}) group by state order by mean_scaled_score desc'
			.format(','.join(['\'' + member + '\'' 
							 for member 
							 in nonStates])))
result = sqlContext.sql(resultSql)
result.show(10, False)
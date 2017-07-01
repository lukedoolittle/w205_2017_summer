from pyspark.sql.types import *
import os 

# Generate the scaled scores table
execfile(os.path.join(os.path.dirname(os.path.realpath(__file__)), 
			          '../core/create_scaled_scores.py'))
					  
surveyMetrics = ['nurse_communication', 
				 'doctor_communication', 
				 'staff_responsiveness', 
				 'pain_management',
				 'medicine_communication',
				 'hospital_enviroment', 
				 'discharge_information', 
				 'overall_rating']

# Get the range of scores for each applicable survey metric and convert into a dictionary
rangesSql = ('select {0} from surveys'
			.format(', '.join(['max({0}) max_{0}, min({0}) min_{0}'.format(item) 
							  for item 
							  in surveyMetrics])))
ranges = (sqlContext.sql(rangesSql)
				    .first()
				    .asDict())

# Normalize the score UNLESS the score does not exist and then use the minimum
adjust = lambda score, metric: ((score - ranges['min_' + metric])
								/ (ranges['max_' + metric] - ranges['min_' + metric]) 
								if score is not None 
								else ranges['min_' + metric])

# An adjustment to the score: normalize the score over [0,1]
surveys = (sqlContext.sql('select * from surveys')
				  .map(lambda row: (row.provider_id, 
									sum([adjust(getattr(row, metric), metric) 
										for metric 
										in surveyMetrics])))
				  .toDF()
				  .selectExpr("_1 as provider_id", 
							  "_2 as scaled_survey_score"))

scores = sqlContext.sql('select provider_id, avg(scaled_score) mean_scaled_score from scaled_scores group by provider_id')

# Join the two tables and get the correlation between survey score and rating
result = (scores.join(surveys, scores.provider_id == surveys.provider_id)
				.select(scores.provider_id, 
						scores.mean_scaled_score, 
						surveys.scaled_survey_score)
				.stat
				.corr("mean_scaled_score", 
					  "scaled_survey_score"))
print "Survey score correlation: {0}".format(result)
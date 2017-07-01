from pyspark import SparkConf, SparkContext
from pyspark.sql.types import *
from pyspark.sql import HiveContext

sqlContext = HiveContext(SparkContext(conf=SparkConf().setAppName("investigations")))

# Get the total count of providers scored
providerCount = sqlContext.sql('select count(*) from providers').first()[0]

# Get the variance relative to the mean for only those scores that have ratings 
# for more than 1/4 of the providers. Also filter out any of the HAI scores 
# since they (appear to) represent an irrelevant relevant parameter
resultSql = 'select description, score_variance_mean_relative from (select metric_id, count(*) score_count, var_samp(score) / avg(score) score_variance_mean_relative from scores group by metric_id) a left outer join metrics on a.metric_id = metrics.metric_id where score_count > {0} and a.metric_id not like \'HAI%\' order by score_variance_mean_relative desc'.format(providerCount / 20)
result = sqlContext.sql(resultSql)
result.show(10, False)
** Steps to Run Exercise 1 **

su - w205
mkdir doolittle_luke
cd doolittle_luke
git clone https://lukedoolittle@github.com/lukedoolittle/w205_2017_summer.git
w205exercise1/exercise_1/loading_and_modeling/load_data_lake.sh

hive
source w205exercise1/exercise_1/loading_and_modeling/hive_base_ddl.sql;
exit;
 
spark-sql
source w205exercise1/exercise_1/transforming/create_providers.sql;
source w205exercise1/exercise_1/transforming/create_surveys.sql;
source w205exercise1/exercise_1/transforming/create_scores.sql;
source w205exercise1/exercise_1/transforming/create_metrics.sql;
exit;
 
spark-submit w205exercise1/exercise_1/investigations/best_hospitals/best_hospitals.py
spark-submit w205exercise1/exercise_1/investigations/best_states/best_states.py
spark-submit w205exercise1/exercise_1/investigations/hospital_variability/hospital_variability.py
spark-submit w205exercise1/exercise_1/investigations/hospitals_and_patients/hospitals_and_patients.py
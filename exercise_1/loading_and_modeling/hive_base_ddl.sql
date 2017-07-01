DROP TABLE hospitals;
CREATE EXTERNAL TABLE IF NOT EXISTS hospitals 
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
hospital_type string,
hospital_ownership string,
emergency_services string,
meets_criteria_for_ehr string,
hospital_overall_rating string,
hospital_overall_rating_footnote string,
mortality_national_comparison string,
mortality_national_comparison_footnote string,
saftey_of_care_national_comparison string,
saftey_of_care_national_comparison_footnote string,
readmission_national_comparison string,
readmission_national_comparison_footnote string,
patient_experience_national_comparison string,
patient_experience_national_comparison_footnote string,
effectiveness_of_care_national_comparison string,
effectiveness_of_care_national_comparison_footnote string,
timeliness_of_care_national_comparison string,
timeliness_of_care_national_comparison_footnote string,
efficient_use_of_medical_imaging_national_comparison string,
efficient_use_of_medical_imaging_national_comparison_footnote string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\' ) 
STORED AS TEXTFILE 
LOCATION '/user/w205/hospital_compare/hospitals';

DROP TABLE readmissions;
CREATE EXTERNAL TABLE IF NOT EXISTS readmissions
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
measure_name string,
measure_id string,
compared_to_national string,
denominator string,
score string,
lower_estimate string,
higher_estimate string,
footnote string,
measure_start_date string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

DROP TABLE effective_care;
CREATE EXTERNAL TABLE IF NOT EXISTS effective_care
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
condition string,
measure_id string,
measure_name string,
score string,
sample string,
footnote string,
measure_start_date string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

DROP TABLE structural_measures;
CREATE EXTERNAL TABLE IF NOT EXISTS structural_measures
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
measure_name string,
measure_id string,
measure_response string,
footnote string,
measure_start_date string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/structural_measures';

DROP TABLE complications;
CREATE EXTERNAL TABLE IF NOT EXISTS complications
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
measure_name string,
measure_id string,
compared_to_national string,
denominator string,
score string,
lower_estimate string,
higher_estimate string,
footnote string,
measure_start_date string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/complications';

DROP TABLE infections;
CREATE EXTERNAL TABLE IF NOT EXISTS infections
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
measure_name string,
measure_id string,
compared_to_national string,
score string,
footnote string,
measure_start_date string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/infections';

DROP TABLE imaging;
CREATE EXTERNAL TABLE IF NOT EXISTS imaging
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
phone_number string,
measure_id string,
measure_name string,
score string,
footnote string,
measure_start_date string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/imaging';

DROP TABLE heart_attack_scores;
CREATE EXTERNAL TABLE IF NOT EXISTS heart_attack_scores
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
ami7a_achievement_threshold string,
ami7a_benchmark string,
ami7a_baseline_rate string,
ami7a_performance_rate string,
ami7a_achievement_points string,
ami7a_improvement_points string,
ami7a_measure_score string,
ami7a_procedure_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/heart_attack_scores';

DROP TABLE preventative_scores;
CREATE EXTERNAL TABLE IF NOT EXISTS preventative_scores
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
pc01_achievement_threshold string,
pc01_benchmark string,
pc01_baseline_rate string,
pc01_performance_rate string,
pc01_achievement_points string,
pc01_improvement_points string,
pc01_measure_score string,
pc01_procedure_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/preventative_scores';

DROP TABLE efficiency_scores;
CREATE EXTERNAL TABLE IF NOT EXISTS efficiency_scores
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
mspb1_achievement_threshold string,
mspb1_benchmark string,
mspb1_baseline_rate string,
mspb1_performance_rate string,
mspb1_achievement_points string,
mspb1_improvement_points string,
mspb1_measure_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/efficiency_scores';

DROP TABLE immunization_scores;
CREATE EXTERNAL TABLE IF NOT EXISTS immunization_scores
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
imm2_achievement_threshold string,
imm2_benchmark string,
imm2_baseline_rate string,
imm2_performance_rate string,
imm2_achievement_points string,
imm2_improvement_points string,
imm2_measure_score string,
imm2_procedure_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/immunization_scores';

DROP TABLE outcome_scores;
CREATE EXTERNAL TABLE IF NOT EXISTS outcome_scores
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
mort30ami_achievement_threshold string,
mort30ami_benchmark string,
mort30ami_baseline_rate string,
mort30ami_performance_rate string,
mort30ami_achievement_points string,
mort30ami_improvement_points string,
mort30ami_measure_score string,
mort30hf_achievement_threshold string,
mort30hf_benchmark string,
mort30hf_baseline_rate string,
mort30hf_performance_rate string,
mort30hf_achievement_points string,
mort30hf_improvement_points string,
mort30hf_measure_score string,
mort30pn_achievement_threshold string,
mort30pn_benchmark string,
mort30pn_baseline_rate string,
mort30pn_performance_rate string,
mort30pn_achievement_points string,
mort30pn_improvement_points string,
mort30pn_measure_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/outcome_scores';

DROP TABLE saftey_scores;
CREATE EXTERNAL TABLE IF NOT EXISTS saftey_scores
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
psi90_achievement_threshold string,
psi90_benchmark string,
psi90_baseline_rate string,
psi90_performance_rate string,
psi90_achievement_points string,
psi90_improvement_points string,
psi90_measure_score string,
hai1_achievement_threshold string,
hai1_benchmark string,
hai1_baseline_rate string,
hai1_performance_rate string,
hai1_achievement_points string,
hai1_improvement_points string,
hai1_measure_score string,
hai2_achievement_threshold string,
hai2_benchmark string,
hai2_baseline_rate string,
hai2_performance_rate string,
hai2_achievement_points string,
hai2_improvement_points string,
hai2_measure_score string,
combines_ssi_measure_score string,
hai3_achievement_threshold string,
hai3_benchmark string,
hai3_baseline_rate string,
hai3_performance_rate string,
hai3_achievement_points string,
hai3_improvement_points string,
hai3_measure_score string,
hai4_achievement_threshold string,
hai4_benchmark string,
hai4_baseline_rate string,
hai4_performance_rate string,
hai4_achievement_points string,
hai4_improvement_points string,
hai4_measure_score string,
hai5_achievement_threshold string,
hai5_benchmark string,
hai5_baseline_rate string,
hai5_performance_rate string,
hai5_achievement_points string,
hai5_improvement_points string,
hai5_measure_score string,
hai6_achievement_threshold string,
hai6_benchmark string,
hai6_baseline_rate string,
hai6_performance_rate string,
hai6_achievement_points string,
hai6_improvement_points string,
hai6_measure_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/saftey_scores';

DROP TABLE total_scores;
CREATE EXTERNAL TABLE IF NOT EXISTS total_scores
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
unweighted_normalized_clinical_care_process_domain_score string,
weighted_clinical_care_process_domain_score string,
unweighted_normalized_clinical_care_outcomes_domain_score string,
weighted_normalized_clinical_care_outcomes_domain_score string,
unweighted_patient_and_caregiver_centered_experience_of_care_care_coordination_domain_score string,
weighted_patient_and_caregiver_centered_experience_of_care_care_coordination_domain_score string,
unweighted_normalized_safety_domain_score string,
weighted_safety_domain_score string,
unweighted_normalized_efficiency_and_cost_reduction_domain_score string,
weighted_efficiency_and_cost_reduction_domain_score string,
total_performance_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/total_scores';

DROP TABLE Measures;
CREATE EXTERNAL TABLE IF NOT EXISTS measures
(
measure_name string,
measure_id string,
measure_start_quarter string,
measure_start_date string,
measure_end_quarter string,
measure_end_date string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures';

DROP TABLE survey_responses;
CREATE EXTERNAL TABLE survey_responses
(
provider_id string,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county_name string,
communication_with_nurses_floor string,
communication_with_nurses_achievement_threshold string,
communication_with_nurses_benchmark string,
communication_with_nurses_baseline_rate string,
communication_with_nurses_performance_rate string,
communication_with_nurses_achievement_points string,
communication_with_nurses_improvement_points string,
communication_with_nurses_dimension_score string,
communication_with_doctors_floor string,
communication_with_doctors_achievement_threshold string,
communication_with_doctors_benchmark string,
communication_with_doctors_baseline_rate string,
communication_with_doctors_performance_rate string,
communication_with_doctors_achievement_points string,
communication_with_doctors_improvement_points string,
communication_with_doctors_dimension_score string,
responsiveness_of_hospital_staff_floor string,
responsiveness_of_hospital_staff_achievement_threshold string,
responsiveness_of_hospital_staff_benchmark string,
responsiveness_of_hospital_staff_baseline_rate string,
responsiveness_of_hospital_staff_performance_rate string,
responsiveness_of_hospital_staff_achievement_points string,
responsiveness_of_hospital_staff_improvement_points string,
responsiveness_of_hospital_staff_dimension_score string,
pain_management_floor string,
pain_management_achievement_threshold string,
pain_management_benchmark string,
pain_management_baseline_rate string,
pain_management_performance_rate string,
pain_management_achievement_points string,
pain_management_improvement_points string,
pain_management_dimension_score string,
communication_about_medicines_floor string,
communication_about_medicines_achievement_threshold string,
communication_about_medicines_benchmark string,
communication_about_medicines_baseline_rate string,
communication_about_medicines_performance_rate string,
communication_about_medicines_achievement_points string,
communication_about_medicines_improvement_points string,
communication_about_medicines_dimension_score string,
cleanliness_and_quietness_of_hospital_environment_floor string,
cleanliness_and_quietness_of_hospital_environment_achievement_threshold string,
cleanliness_and_quietness_of_hospital_environment_benchmark string,
cleanliness_and_quietness_of_hospital_environment_baseline_rate string,
cleanliness_and_quietness_of_hospital_environment_performance_rate string,
cleanliness_and_quietness_of_hospital_environment_achievement_points string,
cleanliness_and_quietness_of_hospital_environment_improvement_points string,
cleanliness_and_quietness_of_hospital_environment_dimension_score string,
discharge_information_floor string,
discharge_information_achievement_threshold string,
discharge_information_benchmark string,
discharge_information_baseline_rate string,
discharge_information_performance_rate string,
discharge_information_achievement_points string,
discharge_information_improvement_points string,
discharge_information_dimension_score string,
overall_rating_of_hospital_floor string,
overall_rating_of_hospital_achievement_threshold string,
overall_rating_of_hospital_benchmark string,
overall_rating_of_hospital_baseline_rate string,
overall_rating_of_hospital_performance_rate string,
overall_rating_of_hospital_achievement_points string,
overall_rating_of_hospital_improvement_points string,
overall_rating_of_hospital_dimension_score string,
hcahps_base_score string,
hcahps_consistency_score string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' WITH SERDEPROPERTIES
(
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses';

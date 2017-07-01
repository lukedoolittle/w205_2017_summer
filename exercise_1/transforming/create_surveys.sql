DROP TABLE surveys;
CREATE TABLE surveys AS SELECT  
provider_id,
CAST(communication_with_nurses_performance_rate AS DECIMAL(4,2)) nurse_communication,
CAST(communication_with_doctors_performance_rate AS DECIMAL(4,2)) doctor_communication,
CAST(responsiveness_of_hospital_staff_performance_rate AS DECIMAL(4,2)) staff_responsiveness,
CAST(pain_management_performance_rate AS DECIMAL(4,2)) pain_management,
CAST(communication_about_medicines_performance_rate AS DECIMAL(4,2)) medicine_communication,
CAST(cleanliness_and_quietness_of_hospital_environment_performance_rate AS DECIMAL(4,2)) hospital_enviroment,
CAST(discharge_information_performance_rate AS DECIMAL(4,2)) discharge_information,
CAST(overall_rating_of_hospital_performance_rate AS DECIMAL(4,2)) overall_rating,
CAST(hcahps_base_score AS DECIMAL(2,0)) base_score,
CAST(hcahps_consistency_score AS DECIMAL(2,0)) consistency_score
FROM survey_responses;
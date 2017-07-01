DROP TABLE providers;
CREATE TABLE providers AS SELECT 
provider_id,
hospital_name,
state,
CAST(hospital_overall_rating AS DECIMAL(1,0)) overall_score
FROM hospitals;
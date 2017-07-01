DROP TABLE scores;
CREATE TABLE scores AS SELECT 
provider_id,
measure_id metric_id,
cast(score as decimal(13,6)) score,
cast(denominator as decimal(7,0)) sample_size
FROM readmissions

UNION
SELECT 
provider_id,
measure_id metric_id,
CASE 
WHEN score like 'Very High%' THEN 4
WHEN score like 'High%' THEN 3
WHEN score like 'Medium%' THEN 2
WHEN score like 'Low%' THEN 1
WHEN score like 'Not Available' THEN null
ELSE cast(score as decimal(13,6)) END score,
cast(sample as decimal(7,0)) sample_size
FROM effective_care

UNION
SELECT 
provider_id,
measure_id metric_id,
cast(score as decimal(13,6)) score,
cast(denominator as decimal(7,0)) sample_size
FROM complications

UNION
SELECT 
provider_id,
measure_id metric_id,
cast(score as decimal(13,6)) score,
null sample_size
FROM imaging

UNION
SELECT 
provider_id,
measure_id metric_id,
CASE 
WHEN measure_response = 'Yes' THEN 1
WHEN measure_response = 'Y' THEN 1
WHEN measure_response = 'No' THEN 0
WHEN measure_response like 'N' THEN 0
ELSE null END score,
null sample_size
FROM structural_measures

UNION
SELECT 
provider_id,
measure_id metric_id,
cast(score as decimal(13,6)) score,
null sample_size
FROM infections

UNION
SELECT 
provider_id,
measure_id metric_id,
cast(score as decimal(13,6)) score,
null sample_size
FROM imaging

UNION
SELECT 
provider_id,
"AMI_7a_HVBP_Baseline" metric_id,
cast(ami7a_performance_rate as decimal(13,6)) score,
null sample_size
FROM heart_attack_scores

UNION
SELECT 
provider_id,
"IMM_2_HVBP_Performance" metric_id,
cast(imm2_performance_rate as decimal(13,6)) score,
null sample_size
FROM immunization_scores

UNION
SELECT 
provider_id,
"PC_01_HVBP_Performance" metric_id,
cast(pc01_performance_rate as decimal(13,6)) score,,
null sample_size
FROM preventative_scores

UNION
SELECT 
provider_id,
"MSPB_1_HVBP_Performance" metric_id,
cast(mspb1_performance_rate as decimal(13,6)) score,
null sample_size
FROM efficiency_scores

UNION
SELECT 
provider_id,
"MORT_30_AMI_HVBP_Performance" metric_id,
cast(mort30ami_performance_rate as decimal(13,6)) score,
null sample_size
FROM outcome_scores

UNION
SELECT 
provider_id,
"MORT_30_HF_HVBP_Performance" metric_id,
cast(mort30hf_performance_rate as decimal(13,6)) score,
null sample_size
FROM outcome_scores

UNION
SELECT 
provider_id,
"MORT_30_PN_HVBP_Performance" metric_id,
cast(mort30pn_performance_rate as decimal(13,6)) score,
null sample_size
FROM outcome_scores

UNION
SELECT 
provider_id,
"PSI_90_HVBP_Performance" metric_id,
cast(psi90_performance_rate as decimal(13,6)) score,
null sample_size
FROM saftey_scores

UNION
SELECT 
provider_id,
"HAI_1_HVBP_Performance" metric_id,
cast(hai1_performance_rate as decimal(13,6)) score,
null sample_size
FROM saftey_scores

UNION
SELECT 
provider_id,
"HAI_2_HVBP_Performance" metric_id,
cast(hai2_performance_rate as decimal(13,6)) score,
null sample_size
FROM saftey_scores

UNION
SELECT 
provider_id,
"HAI_3_HVBP_Performance" metric_id,
cast(hai3_performance_rate as decimal(13,6)) score,
null sample_size
FROM saftey_scores

UNION
SELECT 
provider_id,
"HAI_4_HVBP_Performance" metric_id,
cast(hai4_performance_rate as decimal(13,6)) score,
null sample_size
FROM saftey_scores

UNION
SELECT 
provider_id,
"HAI_5_HVBP_Performance" metric_id,
cast(hai5_performance_rate as decimal(13,6)) score,
null sample_size
FROM saftey_scores

UNION
SELECT 
provider_id,
"HAI_6_HVBP_Performance" metric_id,
cast(hai6_performance_rate as decimal(13,6)) score,
null sample_size
FROM saftey_scores

UNION
SELECT 
provider_id,
"Total Performance" metric_id,
cast(total_performance_score as decimal(13,6)) score,
null sample_size
FROM total_scores
;
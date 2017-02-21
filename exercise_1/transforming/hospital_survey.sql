CREATE TABLE IF NOT EXISTS hospital_survey AS 
SELECT 
  provider_number AS hospital_id,
  hcahps_base_score AS base_score,
  hcahps_consistency_score AS consistency_score
FROM src_surveys;

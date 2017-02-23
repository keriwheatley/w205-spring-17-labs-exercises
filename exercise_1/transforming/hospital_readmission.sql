CREATE TABLE IF NOT EXISTS hospital_readmission AS 
SELECT 
  CAST(provider_id AS INT) AS hospital_id,
  measure_id AS readmission_id,
  denominator AS denominator,
  score AS score,
  lower_estimate AS lower_estimate,
  higher_estimate AS higher_estimate,
  footnote AS footnote
FROM src_readmissions;

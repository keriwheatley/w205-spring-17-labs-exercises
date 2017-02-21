CREATE TABLE IF NOT EXISTS hospital_complication AS 
SELECT 
  provider_id AS hospital_id,
  measure_id AS complication_id,
  denominator AS denominator,
  score AS score,
  lower_estimate AS lower_estimate,
  higher_estimate AS higher_estimate,
  footnote AS footnote
FROM src_complications;

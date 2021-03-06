CREATE TABLE IF NOT EXISTS hospital_procedure AS 
SELECT 
  CAST(provider_id AS INT) AS hospital_id,
  measure_id AS procedure_id,
  score AS score,
  sample AS sample,
  footnote AS footnote
FROM src_procedures;

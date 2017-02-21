CREATE TABLE IF NOT EXISTS procedure AS 
SELECT DISTINCT
  src_procedures.measure_id AS procedure_id,
  COALESCE(src_measure_desc.measure_name, src_procedures.measure_name) AS procedure_desc
FROM src_procedures
LEFT JOIN src_measure_desc
ON src_procedures.measure_id = src_measure_desc.measure_id;

CREATE TABLE IF NOT EXISTS readmission AS 
SELECT DISTINCT
  src_readmissions.measure_id AS readmission_id,
  COALESCE(src_measure_desc.measure_name, src_readmissions.measure_name) AS readmission_desc
FROM src_readmissions
LEFT JOIN src_measure_desc
ON src_readmissions.measure_id = src_measure_desc.measure_id;

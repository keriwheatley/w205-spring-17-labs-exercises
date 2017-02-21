CREATE TABLE IF NOT EXISTS complication AS 
SELECT DISTINCT
  src_complications.measure_id AS complication_id,
  COALESCE(src_measure_desc.measure_name, src_complications.measure_name) AS complication_desc
FROM src_complications
LEFT JOIN src_measure_desc
ON src_complications.measure_id = src_measure_desc.measure_id;

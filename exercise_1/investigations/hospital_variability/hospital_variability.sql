-- Which procedures have the greatest variability between hospitals?

SET hive.cli.print.header=TRUE;

SELECT
  procedure.procedure_id
  , procedure.procedure_desc
  , MIN(CAST(hospital_procedure.score AS DECIMAL(10,2))) AS min_score
  , MAX(CAST(hospital_procedure.score AS DECIMAL(10,2))) AS max_score
  , (MAX(CAST(hospital_procedure.score AS DECIMAL(10,2))) - MIN(CAST(hospital_procedure.score AS DECIMAL(10,2))))/
        MAX(CAST(hospital_procedure.score AS DECIMAL(10,2))) AS norm_distance
FROM procedure
LEFT JOIN hospital_procedure
  ON procedure.procedure_id = hospital_procedure.procedure_id
  AND hospital_procedure.score <> 'Not Available'
GROUP BY procedure.procedure_id, procedure.procedure_desc
ORDER BY norm_distance DESC, max_score DESC;

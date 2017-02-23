SET hive.cli.print.header=TRUE;

SELECT
  procedure.procedure_id
  , procedure.procedure_desc
  , MIN(CAST(hospital_procedure.score AS DECIMAL(10,2))) AS min_score
  , MAX(CAST(hospital_procedure.score AS DECIMAL(10,2))) AS max_score
  , ROUND(AVG(CAST(hospital_procedure.score AS DECIMAL(10,2))),2) AS mean
  , ROUND(VARIANCE(CAST(hospital_procedure.score AS DECIMAL(10,2))),2) AS variance
FROM procedure
LEFT JOIN hospital_procedure
  ON procedure.procedure_id = hospital_procedure.procedure_id
  AND hospital_procedure.score <> 'Not Available'
GROUP BY procedure.procedure_id, procedure.procedure_desc
ORDER BY variance DESC;

SET hive.cli.print.header=TRUE;

WITH procedure_range AS
  (SELECT procedure_id
    , MIN(CAST(score AS DECIMAL(10,2))) AS min_score
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
    , MAX(CAST(score AS DECIMAL(10,2)))-MIN(CAST(score AS DECIMAL(10,2))) AS score_range
    , ROUND(AVG(CAST(hospital_procedure.score AS DECIMAL(10,2))),6) AS mean
    , ROUND(VARIANCE(CAST(hospital_procedure.score AS DECIMAL(10,2))),6) AS variance
  FROM hospital_procedure
  WHERE score <> 'Not Available'
  AND footnote = ''
  GROUP BY procedure_id
  )

SELECT
  procedure.procedure_id
  , procedure.procedure_desc
  , procedure_range.min_score
  , procedure_range.max_score
  , procedure_range.mean
  , procedure_range.variance
  , ROUND(
      AVG(
        (CAST(hospital_procedure.score AS DECIMAL(10,2)) - procedure_range.min_score)/
              procedure_range.score_range),6) AS norm_mean
  , ROUND(
      VARIANCE(
        (CAST(hospital_procedure.score AS DECIMAL(10,2)) - procedure_range.min_score)/
              procedure_range.score_range),6) AS norm_variance
FROM procedure
LEFT JOIN hospital_procedure
  ON procedure.procedure_id = hospital_procedure.procedure_id
  AND hospital_procedure.score <> 'Not Available'
  AND hospital_procedure.footnote = ''
INNER JOIN procedure_range 
  ON procedure.procedure_id = procedure_range.procedure_id
GROUP BY 
  procedure.procedure_id
  , procedure.procedure_desc
  , procedure_range.min_score
  , procedure_range.max_score
  , procedure_range.mean
  , procedure_range.variance
ORDER BY norm_variance DESC;

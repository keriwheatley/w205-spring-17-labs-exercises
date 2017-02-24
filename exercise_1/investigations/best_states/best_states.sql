SET hive.cli.print.header=TRUE;

WITH procedure_range AS
  (SELECT procedure_id
    , MIN(CAST(score AS DECIMAL(10,2))) AS min_score
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
    , MAX(CAST(score AS DECIMAL(10,2)))-MIN(CAST(score AS DECIMAL(10,2))) AS score_range
  FROM hospital_procedure
  WHERE procedure_id IN ('OP_18b','OP_20','OP_21')
    AND score <> 'Not Available'
    AND footnote = ''
  GROUP BY procedure_id
  ), 
procedure_score AS
  (SELECT hospital.state
    , COUNT(*) AS num_procedures
    , AVG((CAST(hospital_procedure.score AS DECIMAL(10,2))-procedure_range.min_score)/
        procedure_range.score_range) AS avg_norm_score
  FROM hospital
  INNER JOIN hospital_procedure
    ON hospital.hospital_id = hospital_procedure.hospital_id
    AND hospital_procedure.score <> 'Not Available'
    AND hospital_procedure.footnote = ''
  INNER JOIN procedure_range
    ON hospital_procedure.procedure_id = procedure_range.procedure_id
  GROUP BY hospital.state
  ), 
complication_range AS
  (SELECT complication_id
    , MIN(CAST(score AS DECIMAL(10,2))) AS min_score
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
    , MAX(CAST(score AS DECIMAL(10,2)))-MIN(CAST(score AS DECIMAL(10,2))) AS score_range
  FROM hospital_complication
  WHERE complication_id IN ('PSI_90_SAFETY','PSI_7_CVCBI','PSI_13_POST_SEPSIS')
    AND score <> 'Not Available'
    AND footnote = ''
  GROUP BY complication_id
  ),
complication_score AS
  (SELECT hospital.state
    , COUNT(*) AS num_complications
    , AVG((CAST(hospital_complication.score AS DECIMAL(10,2))-complication_range.min_score)/
        complication_range.score_range) AS avg_norm_score
  FROM hospital
  INNER JOIN hospital_complication
    ON hospital.hospital_id = hospital_complication.hospital_id
    AND hospital_complication.score <> 'Not Available'
    AND hospital_complication.footnote = ''
  INNER JOIN complication_range
    ON hospital_complication.complication_id = complication_range.complication_id
  GROUP BY hospital.state
  ), 
readmission_range AS
  (SELECT readmission_id
    , MIN(CAST(score AS DECIMAL(10,2))) AS min_score
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
    , MAX(CAST(score AS DECIMAL(10,2)))-MIN(CAST(score AS DECIMAL(10,2))) AS score_range
  FROM hospital_readmission
  WHERE readmission_id IN ('MORT_30_AMI','MORT_30_HF','MORT_30_PN')
    AND score <> 'Not Available'
    AND footnote = ''
  GROUP BY readmission_id
  ),
readmission_score AS
  (SELECT hospital.state
    , COUNT(*) AS num_readmissions
    , AVG((CAST(hospital_readmission.score AS DECIMAL(10,2))-readmission_range.min_score)/
        readmission_range.score_range) AS avg_norm_score
  FROM hospital
  INNER JOIN hospital_readmission
    ON hospital.hospital_id = hospital_readmission.hospital_id
    AND hospital_readmission.score <> 'Not Available'
    AND hospital_readmission.footnote = ''
  INNER JOIN readmission_range
    ON hospital_readmission.readmission_id = readmission_range.readmission_id
  GROUP BY hospital.state
)
SELECT DISTINCT
  hospital.state
  , procedure_score.num_procedures
  , procedure_score.avg_norm_score AS procedures_norm_score
  , complication_score.num_complications
  , complication_score.avg_norm_score AS complications_norm_score
  , readmission_score.num_readmissions
  , readmission_score.avg_norm_score AS readmissions_norm_score
  , procedure_score.avg_norm_score+
    complication_score.avg_norm_score+
    readmission_score.avg_norm_score AS overall_score
  -- , 3 AS worst_overall_score
  -- , 0 AS best_overall_score
FROM hospital
INNER JOIN procedure_score
  ON hospital.state = procedure_score.state
INNER JOIN complication_score
  ON hospital.state = complication_score.state
INNER JOIN readmission_score
  ON hospital.state = readmission_score.state
ORDER BY overall_score ASC
LIMIT 10;

SET hive.cli.print.header=TRUE;

WITH procedure_range AS
  (SELECT procedure_id
    , MIN(CAST(score AS DECIMAL(10,2))) AS min_score
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
  FROM hospital_procedure
  WHERE procedure_id IN ('OP_18b','OP_20','OP_21')
    AND score <> 'Not Available'
  GROUP BY procedure_id
  ), 
procedure_score AS
  (SELECT hospital_procedure.hospital_id
    , COUNT(*) AS num_procedures
    , SUM(hospital_procedure.score) AS score
    , SUM(procedure_range.min_score) AS min_score
    , SUM(procedure_range.max_score) AS max_score
    , AVG(CAST(hospital_procedure.score AS DECIMAL(10,2))/procedure_range.max_score) AS norm_score
  FROM hospital_procedure
  INNER JOIN procedure_range
    ON hospital_procedure.procedure_id = procedure_range.procedure_id
  WHERE hospital_procedure.score <> 'Not Available'
    AND hospital_procedure.footnote = ''
  GROUP BY hospital_procedure.hospital_id
  ), 
complication_range AS
  (SELECT complication_id
    , MIN(CAST(score AS DECIMAL(10,2))) AS min_score
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
  FROM hospital_complication
  WHERE complication_id IN ('PSI_90_SAFETY','PSI_7_CVCBI','PSI_13_POST_SEPSIS')
    AND score <> 'Not Available'
  GROUP BY complication_id
  ),
complication_score AS
  (SELECT hospital_complication.hospital_id
    , COUNT(*) AS num_complications
    , SUM(hospital_complication.score) AS score
    , SUM(complication_range.min_score) AS min_score
    , SUM(complication_range.max_score) AS max_score
    , AVG(CAST(hospital_complication.score AS DECIMAL(10,2))/complication_range.max_score) AS norm_score
  FROM hospital_complication
  INNER JOIN complication_range
    ON hospital_complication.complication_id = complication_range.complication_id
  WHERE hospital_complication.score <> 'Not Available'
    AND hospital_complication.footnote = ''
  GROUP BY hospital_complication.hospital_id
  ), 
readmission_range AS
  (SELECT readmission_id
    , MIN(CAST(score AS DECIMAL(10,2))) AS min_score
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
  FROM hospital_readmission
  WHERE readmission_id IN ('MORT_30_AMI','MORT_30_HF','MORT_30_PN')
    AND score <> 'Not Available'
  GROUP BY readmission_id
  ),
readmission_score AS
  (SELECT hospital_readmission.hospital_id
    , COUNT(*) AS num_readmissions
    , SUM(hospital_readmission.score) AS score
    , SUM(readmission_range.min_score) AS min_score
    , SUM(readmission_range.max_score) AS max_score
    , AVG(CAST(hospital_readmission.score AS DECIMAL(10,2))/readmission_range.max_score) AS norm_score
  FROM hospital_readmission
  INNER JOIN readmission_range
    ON hospital_readmission.readmission_id = readmission_range.readmission_id
  WHERE hospital_readmission.score <> 'Not Available'
    AND hospital_readmission.footnote = ''
  GROUP BY hospital_readmission.hospital_id
)
SELECT 
  hospital.hospital_id
  , hospital.hospital_name
  , procedure_score.num_procedures
  , procedure_score.score AS procedures_score
  , procedure_score.min_score AS procedures_min_score
  , procedure_score.max_score AS procedures_max_score
  , procedure_score.norm_score AS procedures_norm_score
  , complication_score.num_complications
  , complication_score.score AS complications_score
  , complication_score.min_score AS complications_min_score
  , complication_score.max_score AS complications_max_score
  , complication_score.norm_score AS complications_norm_score
  , readmission_score.num_readmissions
  , readmission_score.score AS readmissions_score
  , readmission_score.min_score AS readmissions_min_score
  , readmission_score.max_score AS readmissions_max_score
  , readmission_score.norm_score AS readmissions_norm_score
  , procedure_score.norm_score+
    complication_score.norm_score+
    readmission_score.norm_score AS overall_score
  , 3 AS worst_overall_score
  , 0 AS best_overall_score
FROM hospital
INNER JOIN procedure_score
  ON hospital.hospital_id = procedure_score.hospital_id
  AND procedure_score.num_procedures >=2
INNER JOIN complication_score
  ON hospital.hospital_id = complication_score.hospital_id
  AND complication_score.num_complications >=2
INNER JOIN readmission_score
  ON hospital.hospital_id = readmission_score.hospital_id
  AND readmission_score.num_readmissions >=2
ORDER BY overall_score ASC
LIMIT 10;

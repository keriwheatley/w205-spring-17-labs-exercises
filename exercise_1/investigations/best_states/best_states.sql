SET hive.cli.print.header=TRUE;

WITH procedure_range AS
  (SELECT procedure_id
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
  FROM hospital_procedure
  WHERE procedure_id IN ('OP_18b','OP_20','OP_21')
    AND score <> 'Not Available'
  GROUP BY procedure_id
  ), 
procedure_score AS
  (SELECT hospital_procedure.hospital_id
    , CAST(hospital_procedure.score AS DECIMAL(10,2))/procedure_range.max_score AS norm_score
  FROM hospital_procedure
  INNER JOIN procedure_range
    ON hospital_procedure.procedure_id = procedure_range.procedure_id
  WHERE hospital_procedure.score <> 'Not Available'
    AND hospital_procedure.footnote = ''
  ), 
complication_range AS
  (SELECT complication_id
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
  FROM hospital_complication
  WHERE complication_id IN ('PSI_90_SAFETY','PSI_7_CVCBI','PSI_13_POST_SEPSIS')
    AND score <> 'Not Available'
  GROUP BY complication_id
  ),
complication_score AS
  (SELECT hospital_complication.hospital_id
    , CAST(hospital_complication.score AS DECIMAL(10,2))/complication_range.max_score AS norm_score
  FROM hospital_complication
  INNER JOIN complication_range
    ON hospital_complication.complication_id = complication_range.complication_id
  WHERE hospital_complication.score <> 'Not Available'
    AND hospital_complication.footnote = ''
  ), 
readmission_range AS
  (SELECT readmission_id
    , MAX(CAST(score AS DECIMAL(10,2))) AS max_score
  FROM hospital_readmission
  WHERE readmission_id IN ('MORT_30_AMI','MORT_30_HF','MORT_30_PN')
    AND score <> 'Not Available'
  GROUP BY readmission_id
  ),
readmission_score AS
  (SELECT hospital_readmission.hospital_id
    , CAST(hospital_readmission.score AS DECIMAL(10,2))/readmission_range.max_score AS norm_score
  FROM hospital_readmission
  INNER JOIN readmission_range
    ON hospital_readmission.readmission_id = readmission_range.readmission_id
  WHERE hospital_readmission.score <> 'Not Available'
    AND hospital_readmission.footnote = ''
)
SELECT 
  hospital.state
  , AVG(procedure_score.norm_score) AS procedures_norm_score
  , AVG(complication_score.norm_score) AS complications_norm_score
  , AVG(readmission_score.norm_score) AS readmissions_norm_score
  , AVG(procedure_score.norm_score)+
    AVG(complication_score.norm_score)+
    AVG(readmission_score.norm_score) AS overall_score
  -- , 3 AS worst_overall_score
  -- , 0 AS best_overall_score
FROM hospital
INNER JOIN procedure_score
  ON hospital.hospital_id = procedure_score.hospital_id
INNER JOIN complication_score
  ON hospital.hospital_id = complication_score.hospital_id
INNER JOIN readmission_score
  ON hospital.hospital_id = readmission_score.hospital_id
GROUP BY hospital.state
ORDER BY overall_score ASC
LIMIT 10;

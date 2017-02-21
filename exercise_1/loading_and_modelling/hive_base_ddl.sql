#Statement to run this script
#hive –f /path/to/hive_base_ddl.sql

CREATE EXTERNAL TABLE IF NOT EXISTS src_procedures
  (provider_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county STRING,
    phone_number STRING,
    condition STRING,
    measure_id STRING,
    measure_name STRING,
    score STRING,
    sample STRING,
    footnote STRING,
    measure_start_date STRING,
    measure_end_date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = '"',
    "escapeChar" = '\\')
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/src_procedures';

CREATE EXTERNAL TABLE IF NOT EXISTS src_readmissions
  (provider_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county STRING,
    phone_number STRING,
    measure_name STRING,
    measure_id STRING,
    compared_to_national STRING,
    denominator STRING,
    score STRING,
    lower_estimate STRING,
    higher_estimate STRING,
    footnote STRING,
    measure_start_date STRING,
    measure_end_date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = '"',
    "escapeChar" = '\\')
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/src_readmissions';

CREATE EXTERNAL TABLE IF NOT EXISTS src_surveys
  (provider_number STRING,
hospital_name STRING,
address STRING,
city STRING,
state STRING,
zip_code STRING,
county_name STRING,
communication_with_nurses_floor STRING,
communication_with_nurses_achievement_threshold STRING,
communication_with_nurses_benchmark STRING,
communication_with_nurses_baseline_rate STRING,
communication_with_nurses_performance_rate STRING,
communication_with_nurses_achievement_points STRING,
communication_with_nurses_improvement_points STRING,
communication_with_nurses_dimension_score STRING,
communication_with_doctors_floor STRING,
communication_with_doctors_achievement_threshold STRING,
communication_with_doctors_benchmark STRING,
communication_with_doctors_baseline_rate STRING,
communication_with_doctors_performance_rate STRING,
communication_with_doctors_achievement_points STRING,
communication_with_doctors_improvement_points STRING,
communication_with_doctors_dimension_score STRING,
responsiveness_of_hospital_staff_floor STRING,
responsiveness_of_hospital_staff_achievement_threshold STRING,
responsiveness_of_hospital_staff_benchmark STRING,
responsiveness_of_hospital_staff_baseline_rate STRING,
responsiveness_of_hospital_staff_performance_rate STRING,
responsiveness_of_hospital_staff_achievement_points STRING,
responsiveness_of_hospital_staff_improvement_points STRING,
responsiveness_of_hospital_staff_dimension_score STRING,
pain_management_floor STRING,
pain_management_achievement_threshold STRING,
pain_management_benchmark STRING,
pain_management_baseline_rate STRING,
pain_management_performance_rate STRING,
pain_management_achievement_points STRING,
pain_management_improvement_points STRING,
pain_management_dimension_score STRING,
communication_about_medicines_floor STRING,
communication_about_medicines_achievement_threshold STRING,
communication_about_medicines_benchmark STRING,
communication_about_medicines_baseline_rate STRING,
communication_about_medicines_performance_rate STRING,
communication_about_medicines_achievement_points STRING,
communication_about_medicines_improvement_points STRING,
communication_about_medicines_dimension_score STRING,
cleanliness_and_quietness_of_hospital_environment_floor STRING,
cleanliness_and_quietness_of_hospital_environment_achievement_threshold STRING,
cleanliness_and_quietness_of_hospital_environment_benchmark STRING,
cleanliness_and_quietness_of_hospital_environment_baseline_rate STRING,
cleanliness_and_quietness_of_hospital_environment_performance_rate STRING,
cleanliness_and_quietness_of_hospital_environment_achievement_points STRING,
cleanliness_and_quietness_of_hospital_environment_improvement_points STRING,
cleanliness_and_quietness_of_hospital_environment_dimension_score STRING,
discharge_information_floor STRING,
discharge_information_achievement_threshold STRING,
discharge_information_benchmark STRING,
discharge_information_baseline_rate STRING,
discharge_information_performance_rate STRING,
discharge_information_achievement_points STRING,
discharge_information_improvement_points STRING,
discharge_information_dimension_score STRING,
overall_rating_of_hospital_floor STRING,
overall_rating_of_hospital_achievement_threshold STRING,
overall_rating_of_hospital_benchmark STRING,
overall_rating_of_hospital_baseline_rate STRING,
overall_rating_of_hospital_performance_rate STRING,
overall_rating_of_hospital_achievement_points STRING,
overall_rating_of_hospital_improvement_points STRING,
overall_rating_of_hospital_dimension_score STRING,
hcahps_base_score STRING,
hcahps_consistency_score STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = '"',
    "escapeChar" = '\\')
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/src_surveys';

CREATE EXTERNAL TABLE IF NOT EXISTS src_hospitals
  (provider_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county_name STRING,
    phone_number STRING,
    hospital_type STRING,
    hospital_ownership STRING,
    emergency_services STRING,
    meets_criteria_for_meaningful_use_of_ehrs STRING,
    hospital_overall_rating STRING,
    hospital_overall_rating_footnote STRING,
    mortality_national_comparison STRING,
    mortality_national_comparison_footnote STRING,
    safety_of_care_national_comparison STRING,
    safety_of_care_national_comparison_footnote STRING,
    readmission_national_comparison STRING,
    readmission_national_comparison_footnote STRING,
    patient_experience_national_comparison STRING,
    patient_experience_national_comparison_footnote STRING,
    effectiveness_of_care_national_comparison STRING,
    effectiveness_of_care_national_comparison_footnote STRING,
    timeliness_of_care_national_comparison STRING,
    timeliness_of_care_national_comparison_footnote STRING,
    efficient_use_of_medical_imaging_national_comparison STRING,
    efficient_use_of_medical_imaging_national_comparison_footnote STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = '"',
    "escapeChar" = '\\')
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/src_hospitals';

CREATE EXTERNAL TABLE IF NOT EXISTS src_complications
  (provider_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county STRING,
    phone_number STRING,
    measure_name STRING,
    measure_id STRING,
    compared_to_national STRING,
    denominator STRING,
    score STRING,
    lower_estimate STRING,
    higher_estimate STRING,
    footnote STRING,
    measure_start_date STRING,
    measure_end_date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = '"',
    "escapeChar" = '\\')
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/src_complications';

CREATE EXTERNAL TABLE IF NOT EXISTS src_measure_desc
  (measure_name STRING,
    measure_id STRING,
    measure_start_quarter STRING,
    measure_start_date STRING,
    measure_end_quarter STRING,
    measure_end_date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = '"',
    "escapeChar" = '\\')
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/src_measure_desc';



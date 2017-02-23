su - w205

mkdir uploads
cd uploads

wget -O files.zip https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

unzip files.zip

tail -n +2 "Timely and Effective Care - Hospital.csv" > src_procedures.csv
tail -n +2 "Readmissions and Deaths - Hospital.csv" > src_readmissions.csv
tail -n +2 "hvbp_hcahps_11_10_2016.csv" > src_surveys.csv
tail -n +2 "Hospital General Information.csv" > src_hospitals.csv
tail -n +2 "Complications - Hospital.csv" > src_complications.csv
tail -n +2 "Measure Dates.csv" > src_measure_desc.csv

hdfs dfs -mkdir /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare/src_procedures
hdfs dfs -mkdir /user/w205/hospital_compare/src_readmissions
hdfs dfs -mkdir /user/w205/hospital_compare/src_surveys
hdfs dfs -mkdir /user/w205/hospital_compare/src_hospitals
hdfs dfs -mkdir /user/w205/hospital_compare/src_complications
hdfs dfs -mkdir /user/w205/hospital_compare/src_measure_desc

hdfs dfs -put ~/uploads/src_procedures.csv /user/w205/hospital_compare/src_procedures/src_procedures.csv
hdfs dfs -put ~/uploads/src_readmissions.csv /user/w205/hospital_compare/src_readmissions/src_readmissions.csv
hdfs dfs -put ~/uploads/src_surveys.csv /user/w205/hospital_compare/src_surveys/src_surveys.csv
hdfs dfs -put ~/uploads/src_hospitals.csv /user/w205/hospital_compare/src_hospitals/src_hospitals.csv
hdfs dfs -put ~/uploads/src_complications.csv /user/w205/hospital_compare/src_complications/src_complications.csv
hdfs dfs -put ~/uploads/src_measure_desc.csv /user/w205/hospital_compare/src_measure_desc/src_measure_desc.csv

cd ~

-- rm -r uploads

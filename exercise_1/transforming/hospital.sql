CREATE TABLE IF NOT EXISTS hospital AS 
SELECT DISTINCT
  provider_id AS hospital_id,
  hospital_name AS hospital_name,
  address AS street_address,
  city,
  state,
  zip_code,
  county_name,
  phone_number
FROM src_hospitals;

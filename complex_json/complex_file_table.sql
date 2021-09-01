DROP TABLE IF EXISTS complex_file;
CREATE external TABLE IF NOT EXISTS complex_file (
  organization struct<address:string,
 company:string,
 email:string,
 gender:string,
 guid:string,
 id:string,
 latitude:double,
 longitude:double,
 name:string,
 phone:string,
 picture:string,
 registered:string,
 registration:array<struct<details:struct<registeredaddress:string,
 registrationcompanyname:string,
 registrationnumber:string>,
 id:int,
 name:string>>>)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
Location 's3://altis-demo-mwaa-s3-bucket-1/complex_file/';
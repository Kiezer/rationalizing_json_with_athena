
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


-- Explore the data in the table
select * from complex_file;


-- Explore individual attributes.
select
organization.id,
organization.guid,
organization.latitude,
organization.longitude,
organization.name,
organization.phone,
organization.address,
organization.company,
organization.email,
organization.picture,
organization.registered,
organization.gender,
organization.registration
from complex_file;



-- UNNESTING the array field
select
organization.id,
organization.guid,
organization.latitude,
organization.longitude,
organization.name,
organization.phone,
organization.address,
organization.company,
organization.email,
organization.picture,
organization.registered,
organization.gender,
registrations.id,
registrations.name,
registrations.details.registrationnumber,
registrations.details.registrationcompanyname,
registrations.details.registeredaddress
from complex_file,
UNNEST(organization.registration) as t(registrations);


-- Create a view 

CREATE OR REPLACE VIEW vw_complex_file
AS 
select
organization.id as organization_id,
organization.guid,
organization.latitude,
organization.longitude,
organization.name as organization_representative_name,
organization.phone,
organization.address,
organization.company,
organization.email,
organization.picture,
organization.registered,
organization.gender,
registrations.id as organization_registration_id,
registrations.name as organization_owner_name,
registrations.details.registrationnumber,
registrations.details.registrationcompanyname,
registrations.details.registeredaddress
from complex_file,
UNNEST(organization.registration) as t(registrations);


-- Select from the view

select * from vw_complex_file;


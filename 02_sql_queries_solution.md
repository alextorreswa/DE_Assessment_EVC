# SQL Queries - Solution

## Overview

We are working with **Vendor X**, and need to ingest their data into our data
warehouse. They send us a daily file, `data/vendor_x_data.csv` and also send
completed registration data to a **QC Vendor** we have an existing data sync
with in order to quality check the registrations. _Even though you uploaded
Vendor X's data as part of the data wrangling task, use the
`public.vendor_x_registrations_raw` table for this task_.

We need our Data Engineer to:

1. Create a deduped version of the Vendor X table,
   `public.vendor_x_registrations_raw`, by removing duplicate rows that appear
   for each registration status
   1. Schema name (the result of this query using your username):
      `select 's_<hash>');`
   2. Table name: `vendor_x_registrations_deduped`

```sql
-- This query leaves only one record per vendor_id (no duplicates) and leaves the last state.
DROP TABLE IF EXISTS s_173f722a36d72a4e353ee93dacf4872c.vendor_x_registrations_deduped;
CREATE TABLE s_173f722a36d72a4e353ee93dacf4872c.vendor_x_registrations_deduped AS (
  WITH
      -- first change the status complete by Zcomplete to sort in the rigth order (step 1, step 2... ZComplete)
      change_status AS (
      SELECT vendor_id, CASE WHEN status ='Complete' THEN 'zComplete' ELSE status END 
      FROM public.vendor_x_registrations_raw AS new_status), 
      -- second group by MAX(status) or last status
      last_status AS (
      SELECT vendor_id, MAX(status) AS status
      FROM change_status
      GROUP BY vendor_id
      ORDER BY vendor_id)
      -- third reverts the state zComplete to original value and only display the last status (join by status and vendor)
  SELECT pv.*
  FROM public.vendor_x_registrations_raw pv
  JOIN last_status ON pv.vendor_id = last_status.vendor_id AND pv.status = (CASE WHEN last_status.status= 'zComplete' THEN 'Complete' ELSE last_status.status END)
  ORDER BY pv.vendor_id);
```


2. Create a table, `all_records`. Format and add the deduped set of Vendor X
   records to that table by editing `all_records_generation_TO_EDIT.sql`.
   Because completed registrations appear in the QC Vendor table
   `qc_vendor_data` that feeds into `all_records`, you'll need to ensure that
   you've removed the duplicate _complete_ records that appear in both tables.
   1. Schema name (the result of this query using your username):
      `select 's_<hash>');`

```sql
drop table if exists s_173f722a36d72a4e353ee93dacf4872c.all_records;
create table s_173f722a36d72a4e353ee93dacf4872c.all_records as (
    select
        application_id
        , org_id
        , shift_id
        , first_name
        , middle_name
        , last_name
        , name_suffix
        , voting_street_address_one
        , voting_street_address_two
        , voting_city
        , voting_state
        , voting_zipcode
        , mailing_street_address_one
        , mailing_street_address_two
        , mailing_city
        , mailing_state
        , mailing_zipcode
        , county
        , gender
        , date_of_birth
        , phone_number
        , email_address
        , updated_at
        , party
        , name_prefix
        , ethnicity
        , latitude
        , longitude
        , completed
        , registration_date
        , shift_type
        , locations_state
        , program_type
        , program_sub_type
        , collection_medium
        , office
        , field_start
        , field_end
        , evc_month
        , evc_year
    from public.qc_vendor_data
)
;
```

   2. Table name: `all_records`
```sql
INSERT INTO s_173f722a36d72a4e353ee93dacf4872c.all_records
SELECT vendor_id AS application_id, org AS org_id, shift_id, first_name, middle_name, last_name, name_suffix, 
       NULL AS voting_street_address_one, NULL AS voting_street_address_two, NULL AS voting_city, NULL AS voting_state, 
       NULL AS voting_zipcode, mailing_address AS mailing_street_address_one, mailing_unit AS mailing_street_address_two, 
       mailing_city, mailing_state, mailing_zip_code, mailing_county AS county, predicted_gender AS gender,
       date_of_birth, regexp_replace(phone, '\D','','g')::bigint AS phone_number, email_address, 
       -- I use the current date for updated_at
       DATE(NOW()) AS updated_at, party, salutation AS name_prefix, 
       race AS ethnicity, NULL AS latitude, NULL AS longitude, 
       NULL AS completed, registration_date, 
       shift_type, program_state AS locations_state, 
       -- requeritments in the document
       'field' AS program_type, 'evc_funded' AS program_sub_type, 
       registration_source AS collention_medium,office, field_start, field_end, 
       -- use registration_date to get the month for evc_month
       TO_CHAR(registration_date::date, 'Month') AS evc_month,
       -- use registration_date to get the year for evc_year
       TO_CHAR(registration_date::date, 'yyyy') AS evc_year
from s_173f722a36d72a4e353ee93dacf4872c.vendor_x_registrations_deduped
-- avoid duplicates according to instructions
WHERE status <> 'Complete'; 
```

### Additional information for processing Vendor X data

- Vendor X sends one record for each step in the registration process that has
  been completed, e.g. a complete registration would have a total of 5 rows in
  the data: one row for each of steps 1-4 and one row for "complete." The step
  or completion associated with each row is in the `status` field. We also need
  to dedupe the multiple records per registration that we receive from Vendor X
  using the `status` column. Unique registrations can be determined using the
  `vendor_id` field, meaning a complete registration will have 5 rows each with
  the same `vendor_id`.
- When inserting Vendor X registrations into all_records, tag them with
  program_type = 'field', and program_sub_type = 'evc_funded'. Please use the
  source column registration_source to populate collection_medium in the final
  all_records table. The fields evc_month and evc_year should be generated by
  extracting the relevant date parts from registration_date. There may be
  several other columns that do not appear in the Vendor X data and should be
  imputed with null values, or columns that require some transformation to match
  the data type in the `qc_vendor_data` table.
- `vendor_id` from Vendor X data corresponds to `application_id` in the QC
  Vendor data. All completed Vendor X (e.g. have reached `status = ‘Complete’`)
  records are sent to our QC Vendor, so they appear in the `qc_vendor_data`
  table. Remove those duplicate "complete" records so that the final
  `all_records` table does not have any duplicates.


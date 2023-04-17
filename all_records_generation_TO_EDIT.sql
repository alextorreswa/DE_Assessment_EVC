drop table if exists {{ YOUR_SCHEMA_HERE }}.all_records;
create table {{ YOUR_SCHEMA_HERE }}.all_records as (
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

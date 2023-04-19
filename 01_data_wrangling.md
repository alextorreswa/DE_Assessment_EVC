# Data Wrangling

Target time: 60 mins

_**Reminder:** Before you get started on this task, verify that you can log into
the online platform as described in [Setup](#setup)._

## Overview

We are working with new partners, Vendor X and Vendor Y, and need to ingest
their data into our data warehouse. Vendor X sends us a csv file each day.
Vendor Y makes their data available via their API. We need to download the
files, merge them and then load them into our database.

The goal is to set up an automated process to ingest this data. We need our Data
Engineer to write a script that will:

1. Download Vendor Y's data from the API
   1. API URL:
      https://k4clzaf58d.execute-api.us-east-1.amazonaws.com/default/handle_users
2. Merge Vendor Y's data with Vendor X's data
   1. Vendor X's data: `data/vendor_x_data.csv`
3. Standardize the column names and the data
   1. See [Data](#data) section below for morecons_email = pd.read_csv('cons_email.csv') info
4. Save data to a file
   1. `all_vendors.csv`
5. Import data in to the database
   1. Schema name (the result of this query using your username):
      `select 's_<hash>;` (use the schema name shared with you)
   2. Table name: `all_vendors`

You may use any programming language you are comfortable with - our preference
is Python. In the README you sumbit, make sure to add a section about how to run
the script. If you are short on time, you may write pseudo code for a script
that would accomplish this task.

_**NOTE:** This task, although related, is independent of the SQL task. Even if
you encounter challenges with this task, you will still be able to complete the
SQL task._

## Data

_**NOTE:** all data is randomly generated._

The imported table should have the following structure:

| column_name                      | data_type       |
| -------------------------------- | --------------- |
| vendor_id                        | `varchar(1024)` |
| status                           | `varchar(1024)` |
| tracking_source                  | `varchar(1024)` |
| tracking_id                      | `varchar(1024)` |
| date_of_birth                    | `date`          |
| email_address                    | `varchar(1024)` |
| citizenship_confirmed            | `bool`          |
| salutation                       | `varchar(1024)` |
| first_name                       | `varchar(1024)` |
| middle_name                      | `varchar(1024)` |
| last_name                        | `varchar(1024)` |
| name_suffix                      | `varchar(1024)` |
| home_address                     | `varchar(1024)` |
| home_unit                        | `int`           |
| home_city                        | `varchar(1024)` |
| home_county                      | `varchar(1024)` |
| home_state                       | `varchar(1024)` |
| home_zip_code                    | `varchar(1024)` |
| mailing_address                  | `varchar(1024)` |
| mailing_unit                     | `int`           |
| mailing_city                     | `varchar(1024)` |
| mailing_county                   | `varchar(1024)` |
| mailing_state                    | `varchar(1024)` |
| mailing_zip_code                 | `varchar(1024)` |
| party                            | `varchar(1024)` |
| race                             | `varchar(1024)` |
| phone                            | `varchar(1024)` |
| phone_type                       | `varchar(1024)` |
| opt_in_to_vendor_email           | `bool`          |
| opt_in_to_vendor_sms             | `bool`          |
| opt_in_to_partner_email          | `bool`          |
| opt_in_to_partner_smsrobocall    | `bool`          |
| volunteer_for_vendor             | `bool`          |
| volunteer_for_partner            | `bool`          |
| pre_registered                   | `bool`          |
| registration_date                | `timestamp`     |
| finish_with_state                | `bool`          |
| built_via_api                    | `bool`          |
| submitted_via_state_api          | `bool`          |
| registration_source              | `varchar(1024)` |
| shift_id                         | `int`           |
| shift_type                       | `int`           |
| office                           | `varchar(1024)` |
| vendor_a_shift_id                | `int`           |
| salutation_standardized          | `varchar(1024)` |
| has_mailing_address_standardized | `bool`          |
| has_state_license_standardized   | `bool`          |
| has_ssn_standardized             | `bool`          |
| predicted_gender                 | `varchar(1024)` |
| org                              | `varchar(1024)` |
| evc_id                           | `varchar(1024)` |
| program_state                    | `varchar(1024)` |
| partner_id                       | `int`           |
| field_start                      | `timestamp`     |
| field_end                        | `timestamp`     |

## Setup

**Database connection details:**

_The username and password were shared with you in the inital email._

```bash
USERNAME: u_<hash>
PASSWORD: p_<hash>
HOST: 68.183.51.176
DATABASE: sqlpad
PORT: 5432
```

## Deliverables

1. README (text or markdown preferred)
2. Source code
3. `all_vendors.csv`
4. [data imported into database]

## Tips

- Ensure the final CSV has valid column names
- Write your code so that it's reusable and and flexible

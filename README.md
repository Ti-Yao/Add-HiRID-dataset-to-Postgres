# Add HiRID dataset to Postgres
N.B. This is for the raw data rather than the merged or imputed.

#### 1 Download database and SQL scripts
1. Get permission to use HiRID dataset from here. https://physionet.org/content/hirid/1.1
2. Download the raw data files.
```
wget -r -N -c -np --user physionet user --ask-password https://physionet.org/files/hirid/1.1/raw_stage/observation_tables_csv.tar.gz
wget -r -N -c -np --user physionet user --ask-password https://physionet.org/files/hirid/1.1/raw_stage/pharma_records_csv.tar.gz
```
3. Unzip the .csv.gz files using e.g. tarball (Linux) or 7zip (windows)
4. Download the scripts from this repository.


#### 2 Install Postgres
```
sudo apt-get install postgresql # (Linux)
brew install postgres           # (Mac OS)
```
or http://www.postgresql.org/download/ (Any Operating System incl Windows)

3 Create a user, database and schema in Postgres
```
sudo -u postgres psql # enter into postgres

# in postgres pay attention to the semicolons!
ALTER USER postgres PASSWORD 'myPassword'; # create password
#ALTER ROLE
CREATE DATABASE hirid; # create database
#CREATE DATABASE
\c hirid  # connect to database
#you are now connected to database "hirid" as user "postgres"
CREATE SCHEMA hirid; 
# CREATE SCHEMA
\q # quit
```
4 Load data into postgres
```
cd /folder/containing/data/and/scripts
psql -U postgres -h 127.0.0.1 -f create_tables.sql 'dbname=hirid options=--search_path=hirid password = myPassword'      # create tables 
psql -U postgres -h 127.0.0.1  -f load_data.sql 'dbname=hirid options=--search_path=hirid password = myPassword'         # load hirid data into tables. This may take a while
```

# Add HiRID dataset to Postgres

### N.B. only adding the observation tables for now

#### 1 Download database and SQL scripts
1. Download the HiRID repository to your computer. https://physionet.org/content/hirid/1.1
2. Unzip all the .csv.gz files tar (Linux) or 7zip (windows)
3. Download the scripts from this repository.


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
CREATE DATABASE hirid; # create database called mimiciv
#CREATE DATABASE
\c mimiciv # connect to database
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

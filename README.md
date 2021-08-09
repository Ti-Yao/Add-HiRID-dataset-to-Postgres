# Add HiRID v1.1.1 dataset to Postgres
N.B. This is for the raw data rather than the merged or imputed.

#### 1 Download database and SQL scripts
1. Get permission to use HiRID dataset from here. https://physionet.org/content/hirid/1.1.1
2. Download the raw data files.
```
wget -r -N -c -np --user physionet user --ask-password https://physionet.org/files/hirid/1.1.1/raw_stage/observation_tables_csv.tar.gz
wget -r -N -c -np --user physionet user --ask-password https://physionet.org/files/hirid/1.1.1/raw_stage/pharma_records_csv.tar.gz
```
3. Unzip the .tar.gz files using e.g. tarball (Linux/Mac OS) or 7zip (windows)
4. Download the scripts from this repository.


#### 2 Install Postgres
```
sudo apt-get install postgresql # (Linux)
brew install postgres           # (Mac OS)
```
or http://www.postgresql.org/download/ (Any Operating System incl Windows)

#### 3 Create a user, database and schema in Postgres
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
#### 4 Load data into postgres
```
cd /folder/containing/data/and/scripts
psql -U postgres -h 127.0.0.1 -f create_tables.sql 'dbname=hirid options=--search_path=hirid password = myPassword'      # create tables 
psql -U postgres -h 127.0.0.1  -f load_data.sql 'dbname=hirid options=--search_path=hirid password = myPassword'         # load hirid data into tables. This may take a while
psql -U postgres -h 127.0.0.1  -f postgres_check.sql 'dbname=hirid options=--search_path=hirid password = myPassword'    # checks if the data has been loaded corrected
```


#### References
1. Hyland, S.L., Faltys, M., Hüser, M. et al. Early prediction of circulatory failure in the intensive care unit using machine learning. Nat Med 26, 364–373 (2020). https://doi.org/10.1038/s41591-020-0789-4
2. CircEWS Github repository https://github.com/ratschlab/circEWS

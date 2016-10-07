#!/bin/bash
# $Id: create_geocode.sh 10634 2012-11-03 18:12:57Z robe $
PGPORT=5432
PGHOST=localhost
PGUSER=postgres
PGPASSWORD=yourpasswordhere
THEDB=geocoder
PSQL_CMD=/usr/bin/psql
PGCONTRIB=/usr/share/postgresql/contrib
${PSQL_CMD} -d "${THEDB}" -c "CREATE EXTENSION fuzzystrmatch" 
${PSQL_CMD} -d "${THEDB}" -c "CREATE SCHEMA tiger"
${PSQL_CMD} -d "${THEDB}" -c "ALTER DATABASE ${THEDB} SET search_path=public, tiger;"
#${PSQL_CMD} -d "${THEDB}" -f "tables/lookup_tables_2010.sql"
${PSQL_CMD} -d "${THEDB}" -c "CREATE SCHEMA tiger_data"
${PSQL_CMD} -d "${THEDB}" -f "create_geocode.sql"
${PSQL_CMD} -d "${THEDB}" -f "tiger_loader_2012.sql"
${PSQL_CMD}  -d "${THEDB}" -f "census_loader.sql"
${PSQL_CMD}  -d "${THEDB}" -c "SELECT tiger.create_census_base_tables();"
${PSQL_CMD} -d "${THEDB}" -c "CREATE INDEX idx_tiger_addr_least_address ON addr USING btree (least_hn(fromhn,tohn));"
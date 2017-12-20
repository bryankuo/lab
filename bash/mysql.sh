#!/bin/bash

# SELECT User, Host FROM mysql.user;

/usr/bin/mysqladmin -u root password @9ExxRoot

mysqldump -u tatung -h localhost -p --single-transaction --no-create-info --skip-add-locks RFID type_group contact_report > RFID-tatung-massive-upload.sql

mysql -u tatung -p RFID < RFID-tatung-massive-upload.sql

# restore a single table from a full mysql mysqldump file?
# ( https://goo.gl/kDchxA)
# sed -n -e '/CREATE TABLE.*`device_event`/,/CREATE TABLE/p' export-tt-ha1-Administration-all.sql > device_event.sql
# Remember to add DROP TABLE at the top and remove the DROP TABLE [next table] at the bottom of the file.

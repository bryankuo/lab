#!/bin/bash

# SELECT User, Host FROM mysql.user;

/usr/bin/mysqladmin -u root password @9ExxRoot

mysqldump -u tatung -h localhost -p --single-transaction --no-create-info --skip-add-locks RFID type_group contact_report > RFID-tatung-massive-upload.sql

mysql -u tatung -p RFID < RFID-tatung-massive-upload.sql

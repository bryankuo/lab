#!/bin/bash
# looping exporting system databases
MYSQL_PSWD="@9ExxRoot"
declare -a sysdb=("IPPbx" "RFID" "Administration" "APS")
# export
for db in "${sysdb[@]}"
do
	echo "$db:"
	mysql -u root -p$MYSQL_PSWD IPPbx -e \
	"SELECT table_name, TABLE_ROWS FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '$db'";
	mysqldump -uroot -p$MYSQL_PSWD $db > export-$(hostname -s)-$db-all.sql
done

# import
for db in "${sysdb[@]}"
do
	mysql -u root -p$MYSQL_PSWD $db < export-$(hostname -s)-$db-all.sql
done

# split a single table from db dump ( https://goo.gl/JkKcHv )
sed -n -e '/DROP TABLE.*`cdr`/,/UNLOCK TABLES/p' export-tt-ha1-IPPbx-all.sql > export-tt-ha1-IPPbx-cdr.sql

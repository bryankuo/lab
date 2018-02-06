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
	# to speedup:
	# mysqldump -uroot -p@9ExxRoot IPPbx --ignore-table=IPPbx.cdr > export-$(hostname -s)-IPPbx-speedup.sql
done

# import
# for db in "${sysdb[@]}"
# do
#	mysql -u root -p$MYSQL_PSWD $db < export-$(hostname -s)-$db-all.sql
# done

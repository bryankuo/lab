mysqldump -u$user -p$password --where="$column < NOW() + INTERVAL -$number DAY" $database $table > \
	/tmp/$(uname -n)-$database-$table-export-$(date +%F).sql

# specific table
mysqldump -u... -p... mydb t1 t2 t3 > mydb_tables.sql

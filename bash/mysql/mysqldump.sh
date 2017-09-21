mysqldump -u$user -p$password --where="$column < NOW() + INTERVAL -$number DAY" $database $table > \
	/tmp/$(uname -n)-$database-$table-export-$(date +%F).sql



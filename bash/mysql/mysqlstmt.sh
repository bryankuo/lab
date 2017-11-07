show database table count:

SELECT IFNULL(table_schema,'Total') "Database",TableCount
FROM (SELECT COUNT(1) TableCount,table_schema
      FROM information_schema.tables
      WHERE table_schema NOT IN ('information_schema','mysql')
      GROUP BY table_schema WITH ROLLUP) A;



/*
gcc -o test-client-info test-client-info.c $(mysql_config --libs) -I/usr/include/mysql
*/
#include <my_global.h>
#include <mysql.h>

int main(int argc, char **argv)
{
  printf("MySQL client version: %s\n", mysql_get_client_info());
}


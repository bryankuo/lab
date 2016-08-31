#include <stdio.h>
#include <stdlib.h>
#include <curl/curl.h>

int main(int argc, char *argv[])
{
  char POST[255] = "" ;
  CURL *curl;
  CURLcode res;
   
  curl = curl_easy_init();
   
  sprintf(POST,"ei=UTF-8&p=%s",argv[1]);
   
  //curl_easy_setopt(curl, CURLOPT_URL, "tw.dictionary.yahoo.com/search");
  //curl_easy_setopt(curl, CURLOPT_URL, "http://192.168.66.161/security/socket.php");
  //curl_easy_setopt(curl, CURLOPT_URL, "http://localhost/security/test/http_download/t2/getfw.php?fwname=e8.bin");
  curl_easy_setopt(curl, CURLOPT_URL, "http://localhost/security/ipcam/get_Information.php?phone_num=8822");
  curl_easy_setopt(curl, CURLOPT_POSTFIELDS, POST);
  res = curl_easy_perform(curl);

  curl_easy_cleanup(curl);
  return 0;
}
<?php
$host = "ASTERISK IP ADDRESS";
$user = "admin";
$secret = "password";

$channel = $_REQUEST['extension'];

$context = "from-internal";
$waitTime = "30";

$priority = "1";
$maxRetry = "2";
$number=strtolower($_REQUEST['number']);
$pos=strpos ($number,"local");
if ($number == null) :
exit() ;
endif ;
if ($pos===false) :
$errno=0 ;
$errstr=0 ;
$callerId = "Web Call $number";
$oSocket = fsockopen ("localhost", 5038, &$errno, &$errstr, 20);
if (!$oSocket) {
echo "$errstr ($errno)<br>\n";
} else {
fputs($oSocket, "Action: login\r\n");
fputs($oSocket, "Events: on\r\n");
fputs($oSocket, "Username: $user\r\n");
fputs($oSocket, "Secret: $secret\r\n\r\n");
fputs($oSocket, "Action: originate\r\n");
fputs($oSocket, "Channel: $channel\r\n");
fputs($oSocket, "WaitTime: $waitTime\r\n");
fputs($oSocket, "CallerId: $callerId\r\n");
fputs($oSocket, "Extension: $number\r\n");
fputs($oSocket, "Context: $context\r\n");
fputs($oSocket, "Priority: $priority\r\n\r\n");
fputs($oSocket, "Action: Logoff\r\n\r\n");
sleep(2);
fclose($oSocket);
}
echo "Extension $channel should be calling $number." ;
else :
exit() ;
endif ;
?>

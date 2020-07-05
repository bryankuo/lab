<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1397982889415" ID="ID_1275125281" LINK="../networking.mm" MODIFIED="1493695756603" TEXT="apache">
<node CREATED="1397982986415" LINK="http://linuxaria.com/article/8-simple-to-follow-tips-to-secure-your-apache-web-server?lang=en" MODIFIED="1397983002817" POSITION="right" TEXT="8 Simple To Follow Tips To Secure Your Apache Web Server"/>
<node CREATED="1414483228942" LINK="http://goo.gl/a4FSlD" MODIFIED="1414483260320" POSITION="right" TEXT="storm">
<icon BUILTIN="help"/>
</node>
<node CREATED="1418954334395" LINK="tux/centos.mm#ID_1288847984" MODIFIED="1418954387741" POSITION="right" TEXT="centos"/>
<node CREATED="1419474014193" FOLDED="true" MODIFIED="1462762272779" POSITION="right" TEXT="secure logon system">
<node CREATED="1419825585467" MODIFIED="1419825586257" TEXT="protecting a directory"/>
<node CREATED="1419825334979" LINK="#ID_1687680921" MODIFIED="1419825341957" TEXT="authentication"/>
<node CREATED="1419825495595" LINK="#ID_1199225901" MODIFIED="1419825502988" TEXT=".htaccess"/>
</node>
<node CREATED="1419490687288" FOLDED="true" MODIFIED="1490839521778" POSITION="right" TEXT="modules">
<node CREATED="1419490692608" FOLDED="true" MODIFIED="1427867756657" TEXT="location">
<node CREATED="1419490699800" MODIFIED="1419490700622" TEXT="sudo ls -l /usr/lib/httpd/modules"/>
</node>
<node CREATED="1419475902698" FOLDED="true" LINK="http://goo.gl/iyTKei" MODIFIED="1490839521776" TEXT="show all loaded">
<node CREATED="1419489836176" MODIFIED="1419489837466" TEXT="sudo httpd -M | grep -e &quot;proxy&quot; -e &quot;auth&quot; -e &quot;ssl&quot;"/>
</node>
<node CREATED="1462504793191" FOLDED="true" LINK="http://goo.gl/ijuH" MODIFIED="1462762221796" TEXT="mod_rewrite">
<node CREATED="1462504798539" LINK="http://goo.gl/10We2Z" MODIFIED="1462505178205" TEXT="An In-Depth Guide to mod_rewrite for Apache">
<icon BUILTIN="info"/>
</node>
<node CREATED="1462505681698" LINK="http://goo.gl/XeUL" MODIFIED="1462505690520" TEXT="URL Rewriting Guide"/>
<node CREATED="1462505760210" MODIFIED="1462505760951" TEXT="Server-Variables"/>
<node CREATED="1462512975344" FOLDED="true" MODIFIED="1490839521777" TEXT="Directives">
<node CREATED="1462507176907" FOLDED="true" LINK="http://goo.gl/jNRHW" MODIFIED="1490839521777" TEXT="RewriteCond">
<node CREATED="1462512959838" FOLDED="true" LINK="http://goo.gl/pBwq8b" MODIFIED="1490839521776" TEXT="In general, Apache does the rewrite phase before the authorization phase">
<node CREATED="1462513230620" MODIFIED="1462513231556" TEXT="%{LA-U:REMOTE_USER}"/>
<node CREATED="1462513244678" LINK="#ID_822454679" MODIFIED="1462513259294" TEXT="%{ENV:REMOTE_USER}"/>
</node>
<node CREATED="1462524146653" MODIFIED="1462524147546" TEXT="CondPattern"/>
</node>
<node CREATED="1462507186091" FOLDED="true" MODIFIED="1490839521777" TEXT="RewriteRule">
<node CREATED="1462515280359" LINK="http://goo.gl/lZsA" MODIFIED="1462515293077" TEXT="RewriteRule Pattern Substitution [flags]"/>
<node CREATED="1462514532269" FOLDED="true" MODIFIED="1462523160816" TEXT="flags">
<node CREATED="1462514536994" MODIFIED="1462514538142" TEXT="L"/>
<node CREATED="1462514539046" MODIFIED="1462514540460" TEXT="R"/>
<node CREATED="1462514540910" MODIFIED="1462514542052" TEXT="N"/>
</node>
</node>
<node CREATED="1462507163299" MODIFIED="1462507164088" TEXT="RewriteMap"/>
<node CREATED="1462507209383" MODIFIED="1462507210617" TEXT="RedirectMatch"/>
<node CREATED="1462523153176" MODIFIED="1462523158531" TEXT="RewriteLog"/>
</node>
<node CREATED="1462516861484" FOLDED="true" LINK="https://goo.gl/ldU87w" MODIFIED="1490839521777" TEXT="If you&#x2019;re adding the RewriteRule into your main Apache config file (httpd.conf)">
<node CREATED="1462516879919" MODIFIED="1462516880657" TEXT="mod_rewrite runs before authentication"/>
</node>
</node>
</node>
<node CREATED="1419486187847" FOLDED="true" MODIFIED="1462762493607" POSITION="right" TEXT="authentication">
<node CREATED="1419474750273" FOLDED="true" LINK="http://goo.gl/njozj7" MODIFIED="1427867756658" TEXT="using Apache web server authentication">
<icon BUILTIN="info"/>
<node CREATED="1419474975633" FOLDED="true" LINK="http://goo.gl/njozj7" MODIFIED="1427867756657" TEXT="password file authentication">
<node CREATED="1419474849257" MODIFIED="1419474850193" TEXT="by a single login"/>
<node CREATED="1419474859921" MODIFIED="1419474860656" TEXT="by group access permissions"/>
</node>
<node CREATED="1419474955089" LINK="http://goo.gl/3NlLeC" MODIFIED="1419475015149" TEXT="Using LDAP"/>
<node CREATED="1419475061809" MODIFIED="1419475063091" TEXT="Using NIS"/>
<node CREATED="1419475086409" LINK="http://goo.gl/jIUSdR" MODIFIED="1419475102679" TEXT="Using a MySQL"/>
</node>
<node CREATED="1419488910376" FOLDED="true" MODIFIED="1427867756658" TEXT="with mysql">
<node CREATED="1419478400523" LINK="http://goo.gl/XgnClH" MODIFIED="1419486704713" TEXT="mod_auth_mysql "/>
<node CREATED="1419488892344" LINK="http://goo.gl/mXOLCV" MODIFIED="1419488905560" TEXT="Apache MySQL Authentication for Debian Etch"/>
<node CREATED="1419558745244" LINK="http://goo.gl/l2n91Y" MODIFIED="1419558777860" TEXT="The biggest gotcha is that the configuration documentation is badly out of date."/>
<node CREATED="1419835408642" LINK="http://goo.gl/rFtwWm" MODIFIED="1419835422952" TEXT="How-To: Apache2 Authentication Using MySQL Backend"/>
</node>
<node CREATED="1419480073972" FOLDED="true" MODIFIED="1427867756659" TEXT="AuthType">
<node CREATED="1419480076436" FOLDED="true" MODIFIED="1427867756659" TEXT="basic">
<node CREATED="1419480135524" MODIFIED="1419480165270" TEXT="auth_basic_module"/>
<node CREATED="1419832291487" LINK="#ID_1199225901" MODIFIED="1419832298586" TEXT=".htaccess"/>
<node CREATED="1419838418826" LINK="http://goo.gl/mu1BQU" MODIFIED="1419838433215" TEXT="Basic Authentication wasn&apos;t designed to manage logging out."/>
<node CREATED="1419840833417" LINK="http://goo.gl/9g51l6" MODIFIED="1419840847234" TEXT="because most browsers cache credentials for BASIC authentication"/>
</node>
<node CREATED="1419480078964" FOLDED="true" MODIFIED="1427867756659" TEXT="digest">
<node CREATED="1419480179452" MODIFIED="1419486714248" TEXT="auth_digest_module">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1419825476451" FOLDED="true" MODIFIED="1442068650143" TEXT="PAM">
<node CREATED="1419479858043" FOLDED="true" LINK="http://goo.gl/7NH2Ut" MODIFIED="1442068650142" TEXT="use OS users">
<icon BUILTIN="idea"/>
<icon BUILTIN="info"/>
<node CREATED="1419479909068" FOLDED="true" MODIFIED="1442068650141" TEXT="SSL">
<node CREATED="1419489679560" MODIFIED="1419489681046" TEXT="Invalid command &apos;SSLRequireSSL&apos;"/>
<node CREATED="1419490864881" LINK="http://goo.gl/Azd9Et" MODIFIED="1419490890630" TEXT="install centos"/>
<node CREATED="1419489790496" FOLDED="true" LINK="http://goo.gl/3rWfEU" MODIFIED="1442068650140" TEXT="mod_ssl">
<node CREATED="1419490367832" LINK="http://goo.gl/nPsOmV" MODIFIED="1419490381596" TEXT="SSL/TLS Strong Encryption: How-To"/>
<node CREATED="1419491426977" LINK="http://goo.gl/Azd9Et" MODIFIED="1419491450667" TEXT="How to install the Apache mod_ssl module"/>
<node CREATED="1419491470825" LINK="http://goo.gl/Azd9Et" MODIFIED="1419491503322" TEXT="How to configure the Apache mod_ssl module">
<icon BUILTIN="help"/>
</node>
<node CREATED="1419491544041" FOLDED="true" LINK="http://goo.gl/ZE3VA" MODIFIED="1442068650139" TEXT="Step #2: Create an SSL Certificate">
<node CREATED="1419491887857" MODIFIED="1419491888779" TEXT="passphrase to protect the Apache web server key pair"/>
<node CREATED="1419491910839" MODIFIED="1419491911734" TEXT="Generate a Certificate Signing Request (CSR)"/>
<node CREATED="1419492129129" FOLDED="true" MODIFIED="1442068650139" TEXT="Create the Web Server Certificate">
<node CREATED="1419492181481" MODIFIED="1419492182526" TEXT="To sign httpserver.csr using your CA"/>
<node CREATED="1419492789377" MODIFIED="1419492803570" TEXT="Error opening CA private key /etc/pki/CA/private/cakey.pem"/>
<node CREATED="1419493331402" LINK="http://goo.gl/cUgPdm" MODIFIED="1419493371744" TEXT="One needs to generate CA files."/>
<node CREATED="1419493480930" FOLDED="true" LINK="http://goo.gl/fMZcCg" MODIFIED="1442068650138" TEXT="this is, work for me">
<icon BUILTIN="info"/>
<node CREATED="1419493876034" LINK="professional.mm#ID_1837023487" MODIFIED="1419493947091" TEXT="openssl">
<icon BUILTIN="help"/>
</node>
<node CREATED="1419493576066" MODIFIED="1419493583133" TEXT="x509">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1419492499785" MODIFIED="1419492500630" TEXT="Install SSL Certificate"/>
</node>
<node CREATED="1419496549744" FOLDED="true" MODIFIED="1427867756661" TEXT="service httpd restart">
<node CREATED="1419496551755" MODIFIED="1419496608876" TEXT="why it requests for passphrase for each time">
<icon BUILTIN="help"/>
</node>
<node CREATED="1419496597651" MODIFIED="1419496605868" TEXT="how to solve this">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1419496685979" MODIFIED="1419496689108" TEXT="Firewall Configuration">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1419486046043" FOLDED="true" LINK="http://goo.gl/FMa3ox" MODIFIED="1427867756662" TEXT="Basic authentication is from PAM">
<icon BUILTIN="idea"/>
<node CREATED="1419480086748" MODIFIED="1419480088113" TEXT="basic"/>
<node CREATED="1419486658119" MODIFIED="1419486659271" TEXT="Install mod-auth-external and pwauth"/>
<node CREATED="1419486770993" FOLDED="true" MODIFIED="1427867756662" TEXT="apxs">
<node CREATED="1419487145807" LINK="http://goo.gl/gPAmSz" MODIFIED="1419487156789" TEXT="not found"/>
</node>
<node CREATED="1419495415507" LINK="http://goo.gl/cUgPdm" MODIFIED="1419495451290" TEXT="Make sure SSL is used ( another reference )"/>
</node>
<node CREATED="1419486070727" LINK="professional.mm#ID_622762071" MODIFIED="1419486149660" TEXT="PAM"/>
<node CREATED="1419496637349" FOLDED="true" MODIFIED="1427867756663" TEXT="how to disable it in a fast/convenient way">
<node CREATED="1419499726484" MODIFIED="1419499733842" TEXT="by renaming"/>
<node CREATED="1419499721620" MODIFIED="1419499723557" TEXT="/etc/httpd/conf.d/auth_pam.conf"/>
<node CREATED="1419499777180" MODIFIED="1419499777780" TEXT="/etc/httpd/conf.d/ssl.conf"/>
<node CREATED="1419499779732" MODIFIED="1419499784265" TEXT="and restart"/>
</node>
</node>
<node CREATED="1419825517715" LINK="#Freemind_Link_5212" MODIFIED="1419825525045" TEXT="HTTPS"/>
</node>
<node CREATED="1419825379523" FOLDED="true" LINK="http://goo.gl/G8y1" MODIFIED="1427867756664" TEXT=".htaccess">
<node CREATED="1419825393459" LINK="http://goo.gl/1K4Fa1" MODIFIED="1419825407592" TEXT="a directory-level configuration file"/>
<node CREATED="1419825719723" FOLDED="true" LINK="http://goo.gl/IE60W" MODIFIED="1427867756663" TEXT="Set Apache Password Protected Directories">
<node CREATED="1419831781553" MODIFIED="1419831783383" TEXT="AllowOverride AuthConfig directive"/>
</node>
<node CREATED="1419832255263" FOLDED="true" MODIFIED="1427867756664" TEXT="password file with htpasswd">
<node CREATED="1419832350559" MODIFIED="1419832351396" TEXT="htpasswd -c password-file username"/>
</node>
</node>
<node CREATED="1427164814485" LINK="http://goo.gl/XGOq5d" MODIFIED="1427164828186" TEXT=".htpasswd In Depth"/>
</node>
<node CREATED="1427163630196" MODIFIED="1427163640101" POSITION="right" TEXT="script before start"/>
<node CREATED="1427164720247" LINK="http://goo.gl/tRvmG" MODIFIED="1427164728937" POSITION="right" TEXT="htpasswd"/>
<node CREATED="1435457443273" LINK="https://goo.gl/wgfXNb" MODIFIED="1435457467421" POSITION="right" TEXT="flickr: &#x900f;&#x904e; apache module &#x518d;&#x8f49;&#x5230; resize worker"/>
<node CREATED="1462762400015" LINK="tux/centos.mm#ID_1040522632" MODIFIED="1462762488022" POSITION="right" TEXT="centos"/>
<node CREATED="1444016824401" LINK="http://goo.gl/njozj7" MODIFIED="1444016842242" POSITION="right" TEXT="Web Login Authentication"/>
<node CREATED="1444114197127" LINK="http://goo.gl/Eb0Zl2" MODIFIED="1444114210083" POSITION="right" TEXT="Using User Authentication"/>
<node CREATED="1448261712007" FOLDED="true" LINK="http://goo.gl/R0KV5V" MODIFIED="1467166476652" POSITION="right" TEXT="error_log">
<node CREATED="1448261688025" FOLDED="true" MODIFIED="1490839521778" TEXT="Script timed out before returning headers">
<node CREATED="1448261753112" LINK="http://goo.gl/C8rqmZ" MODIFIED="1448261770700" TEXT="You can try to increase Timeout directive"/>
</node>
<node CREATED="1448261708431" MODIFIED="1448261709647" TEXT="Timeout waiting for CGI script"/>
<node CREATED="1448262224807" FOLDED="true" MODIFIED="1490839521778" TEXT="/etc/httpd/conf.d/httpd.conf">
<node CREATED="1448262236471" FOLDED="true" MODIFIED="1455419294712" TEXT="Timeout">
<node CREATED="1448262247519" MODIFIED="1448262251540" TEXT="60 as default"/>
</node>
</node>
</node>
<node CREATED="1462762311168" FOLDED="true" LINK="http://goo.gl/ALWPXT" MODIFIED="1467166474423" POSITION="right" TEXT="configuration">
<icon BUILTIN="info"/>
<node CREATED="1462762571551" FOLDED="true" MODIFIED="1490839521779" TEXT="DocumentRoot">
<node CREATED="1462763263872" MODIFIED="1462763268120" TEXT="Directory"/>
</node>
<node CREATED="1462762600383" MODIFIED="1462762600989" TEXT="DirectoryIndex"/>
<node CREATED="1463983737206" FOLDED="true" MODIFIED="1490839521782" TEXT="Directory">
<node CREATED="1463983742951" FOLDED="true" MODIFIED="1490839521779" TEXT="Require">
<node CREATED="1463987325648" MODIFIED="1463987326691" TEXT="argument"/>
<node CREATED="1463987327519" MODIFIED="1463987331349" TEXT="valid-user"/>
<node CREATED="1463987675257" MODIFIED="1463987677134" TEXT="user"/>
<node CREATED="1463987677456" FOLDED="true" MODIFIED="1490839521779" TEXT="group">
<node CREATED="1463987468376" LINK="http://goo.gl/Eb0Zl2" MODIFIED="1463987599083" TEXT="using a group file">
<icon BUILTIN="info"/>
</node>
<node CREATED="1463988542513" FOLDED="true" LINK="http://goo.gl/JJjKF6" MODIFIED="1490839521779" TEXT="by group access permissions">
<node CREATED="1463988624729" MODIFIED="1463988625527" TEXT="in that directory that contains the groupname and list of users"/>
</node>
</node>
</node>
<node CREATED="1462445112262" FOLDED="true" LINK="https://goo.gl/EXEHk" MODIFIED="1463987682089" TEXT="Per-user web directories">
<node CREATED="1462501999896" LINK="http://goo.gl/Wg6H2e" MODIFIED="1462502015252" TEXT="Per-user web directories"/>
<node CREATED="1462445123158" FOLDED="true" LINK="https://goo.gl/MiJj9K" MODIFIED="1490839521780" TEXT="apache serve different user folder">
<node CREATED="1462445323838" LINK="https://goo.gl/Sf3cY7" MODIFIED="1462445336315" TEXT="mod_userdir"/>
</node>
<node CREATED="1462502079992" LINK="http://goo.gl/ByVYbv" MODIFIED="1462502091736" TEXT="Enable apache per-user web directories"/>
<node CREATED="1462499998768" FOLDED="true" MODIFIED="1462762202820" TEXT="REMOTE_USER">
<node CREATED="1462446321083" LINK="http://goo.gl/d69HTq" MODIFIED="1462446340728" TEXT="%{ENV:REMOTE_USER}"/>
<node CREATED="1462499889497" LINK="http://goo.gl/ea4ZCj" MODIFIED="1462499915493" TEXT="forward the REMOTE_USER variable"/>
<node CREATED="1462499976335" LINK="http://goo.gl/d69HTq" MODIFIED="1462499986945" TEXT="is not actually an environment variable inside Apache"/>
<node CREATED="1462502356017" FOLDED="true" LINK="https://goo.gl/WQomzD" MODIFIED="1490839521780" TEXT="httpd.conf conditional statement">
<node CREATED="1462502407408" LINK="http://goo.gl/yvob5v" MODIFIED="1462502428869" TEXT="With Apache 2.4, it is easy with &lt;If&gt;/&lt;Else&gt; directives"/>
<node CREATED="1462502983473" LINK="http://goo.gl/UYHavO" MODIFIED="1462502995191" TEXT="there are a few other solutions"/>
<node CREATED="1462503067192" MODIFIED="1462503088162" TEXT="Server version: Apache/2.2.15 (Unix)">
<icon BUILTIN="button_cancel"/>
</node>
<node CREATED="1462503112577" FOLDED="true" LINK="http://goo.gl/UYHavO" MODIFIED="1490839521780" TEXT="there are a few other solutions for doing conditional statements in Apache 2.2">
<node CREATED="1462504806969" LINK="#ID_494713730" MODIFIED="1462504815475" TEXT="mod_rewrite"/>
</node>
</node>
</node>
<node CREATED="1462500363592" FOLDED="true" LINK="https://goo.gl/VTj0jb" MODIFIED="1490839521781" TEXT="UserDir">
<node CREATED="1463982947228" LINK="https://goo.gl/kwcvdp" MODIFIED="1463982959026" TEXT="Security Tips"/>
<node CREATED="1463983360999" LINK="http://goo.gl/Vltpk" MODIFIED="1463983380023" TEXT="Enable userdir Apache module on Ubuntu Linux"/>
<node CREATED="1463984203783" FOLDED="true" LINK="http://goo.gl/UDfGtv" MODIFIED="1490839521780" TEXT="Apache localhost/~username/ not working">
<node CREATED="1463984235167" LINK="http://goo.gl/pLBHqz" MODIFIED="1463984247909" TEXT="httpd-userdir.conf "/>
</node>
</node>
<node CREATED="1462500381784" MODIFIED="1462500391941" TEXT="mod_userdir"/>
<node CREATED="1463987282526" LINK="http://goo.gl/Eb0Zl2" MODIFIED="1463987297955" TEXT="Using Groups">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1462501502880" FOLDED="true" MODIFIED="1490839521781" TEXT="per-group web directories">
<icon BUILTIN="help"/>
<icon BUILTIN="idea"/>
<node CREATED="1462500316935" MODIFIED="1462500318161" TEXT="AuthGroupFile"/>
<node CREATED="1462500331855" FOLDED="true" LINK="https://goo.gl/SqL2Hm" MODIFIED="1490839521781" TEXT="mod_authz_groupfile">
<node CREATED="1462500628936" FOLDED="true" LINK="https://goo.gl/yJ266u" MODIFIED="1490839521781" TEXT="mod_authz_dbm">
<node CREATED="1462500634848" MODIFIED="1462500640013" TEXT="better performance"/>
</node>
</node>
<node CREATED="1462500871920" FOLDED="true" MODIFIED="1490839521781" TEXT="role - based access control">
<node CREATED="1462501068696" MODIFIED="1462501069469" TEXT="role-based access control (RBAC)"/>
</node>
<node CREATED="1462500939488" MODIFIED="1462500948079" TEXT="resource - based access control"/>
<node CREATED="1462501472649" MODIFIED="1462501473782" TEXT="httpd-userdir.conf"/>
<node CREATED="1463987762704" LINK="http://goo.gl/QURXyw" MODIFIED="1463987779096" TEXT="htaccess allow access to specific user"/>
</node>
</node>
<node CREATED="1463981551451" MODIFIED="1463981554997" TEXT="Files"/>
<node CREATED="1463988759577" MODIFIED="1463988760444" TEXT="AuthGroupFile"/>
<node CREATED="1464058936938" LINK="http://goo.gl/Eb0Zl2" MODIFIED="1464058953929" TEXT="Using User Authentication">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1463981934630" LINK="http://goo.gl/GvbzFj" MODIFIED="1463981944647" POSITION="right" TEXT="Expressions in Apache HTTP Server"/>
<node CREATED="1488538005793" MODIFIED="1490839954062" POSITION="right" TEXT="hosting both legacy and new version">
<node CREATED="1488522613880" LINK="https://goo.gl/U1NnMO" MODIFIED="1488522627889" TEXT="Multiple Document Roots based on directory? "/>
<node CREATED="1488537949503" FOLDED="true" LINK="https://goo.gl/E4QvoC" MODIFIED="1490839521782" TEXT="Each &lt;VirtualHost&gt; section can have its own DocumentRoot directive.">
<node CREATED="1488787540813" MODIFIED="1488787541585" TEXT="VirtualHost"/>
<node CREATED="1488787569573" MODIFIED="1488787570593" TEXT="apache simple virtual host example"/>
</node>
<node CREATED="1488537998914" LINK="https://goo.gl/LlNpqv" MODIFIED="1488538033250" TEXT="VirtualDocumentRoot "/>
</node>
<node CREATED="1488787604925" FOLDED="true" MODIFIED="1489717209238" POSITION="right" TEXT="apache simple virtual host example">
<node CREATED="1488787611909" MODIFIED="1488787617281" TEXT="ip based"/>
<node CREATED="1488787617669" MODIFIED="1488787621169" TEXT="name based"/>
<node CREATED="1488787690109" MODIFIED="1488787691073" TEXT="VirtualHost containers"/>
<node CREATED="1488787925653" LINK="https://goo.gl/KwWV6" MODIFIED="1488787938420" TEXT="How To Setup Apache Virtual Host Configuration (With Examples)"/>
<node CREATED="1489657774903" LINK="https://goo.gl/7p9z75" MODIFIED="1489657789892" TEXT="Usual Practice: conf.d/"/>
</node>
<node CREATED="1489717213168" LINK="https://goo.gl/DrC4GJ" MODIFIED="1489717252599" POSITION="right" TEXT="For security reasons, httpd will follow symbolic links only if"/>
<node CREATED="1489718512472" LINK="https://goo.gl/DrC4GJ" MODIFIED="1489718526906" POSITION="right" TEXT="the Alias directive will map any part of the filesystem into the web space"/>
<node CREATED="1489723465350" LINK="https://goo.gl/P72kAa" MODIFIED="1489723482072" POSITION="right" TEXT="Centos: How to run additional apache instance on different port"/>
<node COLOR="#000000" CREATED="1387020450981" LINK="http://en.wikipedia.org/wiki/Digest_access_authentication" MODIFIED="1493695683533" POSITION="right" STYLE="fork" TEXT="Digest access authentication">
<edge COLOR="#b2b2fe"/>
<node CREATED="1445484456403" LINK="#ID_107708048" MODIFIED="1445484461556" TEXT="As htdigest doesn&apos;t have any nice way to pass the password in"/>
<node CREATED="1445483717589" LINK="http://goo.gl/cG42Rh" MODIFIED="1445483737765" TEXT="As htdigest doesn&apos;t have any nice way to pass the password in"/>
<node CREATED="1445483878131" FOLDED="true" LINK="http://goo.gl/wofDFp" MODIFIED="1445492951409" TEXT="Mercurial: How to enable remote users to change their password?">
<node CREATED="1445484319499" LINK="http://goo.gl/qE3x9F" MODIFIED="1445484357135" TEXT="Using expect to automate passwd and htpasswd procedures (not suggested)"/>
</node>
<node CREATED="1445492959711" LINK="http://goo.gl/M0xmmM" MODIFIED="1445492976583" TEXT="Change Password of an User in Apache Password file"/>
<node CREATED="1446877264628" FOLDED="true" LINK="https://goo.gl/SBxp8y" MODIFIED="1455419294711" TEXT="htdigest.c">
<node CREATED="1446877473337" LINK="https://goo.gl/EdncNj" MODIFIED="1446877495683" TEXT="Apache Portable Runtime"/>
</node>
</node>
<node CREATED="1463464467444" MODIFIED="1493695671089" POSITION="right" TEXT="symbolic link to CGI">
<node CREATED="1463464841410" LINK="http://goo.gl/ASMVl" MODIFIED="1463464853083" TEXT="How do I get Apache to follow symlinks?"/>
<node CREATED="1463465581034" LINK="http://goo.gl/mpTy2n" MODIFIED="1463465593234" TEXT="SCRIPT_FILENAME CGI environment variable"/>
<node CREATED="1463465733418" MODIFIED="1463465734227" TEXT="apache shows the text of index.cgi instead of executing the script"/>
<node CREATED="1463466638034" LINK="#ID_1035620700" MODIFIED="1463466690660" TEXT="If you&apos;re going to be using the script with symlinks than this is not an ideal situation">
<icon BUILTIN="info"/>
</node>
</node>
<node COLOR="#000000" CREATED="1387020450958" ID="ID_791757542" MODIFIED="1493695651772" POSITION="right" STYLE="fork" TEXT="server side">
<edge COLOR="#b2b2fe"/>
<font NAME="SansSerif" SIZE="12"/>
<node COLOR="#000000" CREATED="1387020450958" LINK="web/javascript.mm#ID_722957359" MODIFIED="1419920668573" STYLE="fork" TEXT="node.js">
<edge COLOR="#b2b2fe"/>
<font NAME="SansSerif" SIZE="12"/>
</node>
<node COLOR="#000000" CREATED="1388931707688" FOLDED="true" ID="ID_457142456" MODIFIED="1531206186424" STYLE="fork" TEXT="web server">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707688" FOLDED="true" MODIFIED="1427867756654" STYLE="fork" TEXT="lighttpd">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707688" FOLDED="true" MODIFIED="1427867756653" STYLE="fork" TEXT="HTTPS">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707688" MODIFIED="1388931707688" STYLE="fork" TEXT="module">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707688" MODIFIED="1388931707688" STYLE="fork" TEXT="test">
<edge COLOR="#338800"/>
</node>
</node>
<node COLOR="#000000" CREATED="1388931707689" FOLDED="true" LINK="http://redmine.lighttpd.net/projects/lighttpd/wiki/Docs:ConfigurationOptions#Core-Debug-Info" MODIFIED="1427867756653" STYLE="fork" TEXT="configuration">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707689" LINK="http://www.cyberciti.biz/tips/howto-lighttpd-block-useragent.html" MODIFIED="1388931707689" STYLE="fork" TEXT="block wget useragent for specific urls">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707689" FOLDED="true" MODIFIED="1427867756653" STYLE="fork" TEXT="upload">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707689" LINK="http://forum.lighttpd.net/topic/24740" MODIFIED="1388931707689" STYLE="fork" TEXT="defaults to /var/tmp as we assume it is a local harddisk">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707689" LINK="http://www.ruby-forum.com/topic/5031" MODIFIED="1388931707689" STYLE="fork" TEXT="Lighttpd file upload issue - sporadic choke?">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707689" MODIFIED="1388931707689" STYLE="fork" TEXT="default 4mb limit">
<edge COLOR="#338800"/>
</node>
</node>
<node COLOR="#000000" CREATED="1388931707689" FOLDED="true" MODIFIED="1427867756653" STYLE="fork" TEXT="log">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707689" LINK="http://serverfault.com/questions/142320/how-to-enable-error-log-in-lighttpd-properly" MODIFIED="1388931707689" STYLE="fork" TEXT="how to set error level">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707689" MODIFIED="1388931707689" STYLE="fork" TEXT="access log">
<edge COLOR="#338800"/>
</node>
</node>
<node COLOR="#000000" CREATED="1388931707689" MODIFIED="1388931707689" STYLE="fork" TEXT="debug">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707689" MODIFIED="1388931707689" STYLE="fork" TEXT="encoding">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707690" LINK="http://redmine.lighttpd.net/attachments/443/lighttpd.conf" MODIFIED="1388931707690" STYLE="fork" TEXT="example">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707690" LINK="http://redmine.lighttpd.net/projects/lighttpd/wiki/Docs:ConfigurationOptions" MODIFIED="1388931707690" STYLE="fork" TEXT="Configuration File Options">
<edge COLOR="#338800"/>
</node>
</node>
</node>
<node COLOR="#000000" CREATED="1388931707690" FOLDED="true" MODIFIED="1427867756654" STYLE="fork" TEXT="BOA">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707690" MODIFIED="1388931707690" STYLE="fork" TEXT="user management">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707690" MODIFIED="1388931707690" STYLE="fork" TEXT="certificates">
<edge COLOR="#338800"/>
<icon BUILTIN="stop"/>
</node>
</node>
<node COLOR="#000000" CREATED="1388931707690" FOLDED="true" ID="ID_1799268882" MODIFIED="1531206185126" STYLE="fork" TEXT="memory">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707690" LINK="networking.mm#ID_1916887579" MODIFIED="1493695657670" STYLE="fork" TEXT="apache">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707690" MODIFIED="1388931707690" STYLE="fork" TEXT="pool">
<edge COLOR="#338800"/>
</node>
</node>
<node COLOR="#000000" CREATED="1388931707690" FOLDED="true" MODIFIED="1427867756655" STYLE="fork" TEXT="lighttpd">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707690" LINK="http://tinfinger.blogspot.tw/2007/09/from-apache-to-lighttpd-and-back-again.html" MODIFIED="1388931707690" STYLE="fork" TEXT="leaks">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707691" FOLDED="true" MODIFIED="1427867756655" STYLE="fork" TEXT="after a high load period">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707691" MODIFIED="1388931707691" STYLE="fork" TEXT="CPU">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707691" MODIFIED="1388931707691" STYLE="fork" TEXT="network traffic">
<edge COLOR="#338800"/>
</node>
<node COLOR="#000000" CREATED="1388931707691" MODIFIED="1388931707691" STYLE="fork" TEXT="memory">
<edge COLOR="#338800"/>
</node>
</node>
<node COLOR="#000000" CREATED="1388931707691" FOLDED="true" MODIFIED="1427867756655" STYLE="fork" TEXT="mod_staticfile">
<edge COLOR="#338800"/>
<node COLOR="#000000" CREATED="1388931707691" LINK="http://redmine.lighttpd.net/projects/lighttpd/wiki/Server.modulesDetails" MODIFIED="1388931707691" STYLE="fork" TEXT="These modules are loaded automatically, don&apos;t load them yourself">
<edge COLOR="#338800"/>
</node>
</node>
</node>
</node>
<node CREATED="1431123016863" FOLDED="true" MODIFIED="1434014548312" TEXT="micro_httpd">
<node CREATED="1431123064685" LINK="http://goo.gl/FUCm" MODIFIED="1431123076418" TEXT="runs from inetd, which means its performance is poor. But for low-traffic sites, it&apos;s quite adequate."/>
</node>
</node>
<node CREATED="1418954426320" LINK="#ID_1916887579" MODIFIED="1418954432170" TEXT="apache"/>
<node CREATED="1427162227502" LINK="tux/centos.mm" MODIFIED="1427162239144" TEXT="centos"/>
</node>
<node CREATED="1493695799913" ID="ID_299933810" LINK="https://goo.gl/r8XelA" MODIFIED="1493695815621" POSITION="right" TEXT="How to run command as apache?"/>
<node CREATED="1493695842015" ID="ID_937124101" LINK="https://goo.gl/Uv7i1k" MODIFIED="1493695853205" POSITION="right" TEXT="run script as user who has nologin shell"/>
<node CREATED="1531205572138" ID="ID_1245871527" MODIFIED="1531205573289" POSITION="right" TEXT="Add a directory">
<node CREATED="1531206160330" ID="ID_1443799609" LINK="https://serverfault.com/a/295979" MODIFIED="1531206166374" TEXT="add directory"/>
<node CREATED="1531206144746" ID="ID_948179962" LINK="https://goo.gl/qiZX3w" MODIFIED="1531206180922" TEXT="enabled modules?"/>
</node>
</node>
</map>

<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1458465808109" ID="ID_1084435062" LINK="ha.mm" MODIFIED="1521510555637" TEXT="DRBD">
<node CREATED="1529056857578" ID="ID_418586396" MODIFIED="1529056861999" POSITION="right" TEXT="articles">
<node CREATED="1529056863026" ID="ID_1469117323" LINK="https://goo.gl/CaEWHm" MODIFIED="1529056874951" TEXT="DRBD&#x5b89;&#x88c5;&#x914d;&#x7f6e;&#x3001;&#x5de5;&#x4f5c;&#x539f;&#x7406;&#x53ca;&#x6545;&#x969c;&#x6062;&#x590d;"/>
</node>
<node CREATED="1463129467078" ID="ID_326697948" MODIFIED="1463129468012" POSITION="right" TEXT="Distributed Replicated Block Device"/>
<node CREATED="1445538397604" FOLDED="true" MODIFIED="1491469117175" POSITION="right" TEXT="version">
<node CREATED="1445538401725" FOLDED="true" MODIFIED="1490259106388" TEXT="8.4.6">
<node CREATED="1490257795770" FOLDED="true" LINK="https://goo.gl/7A0grB" MODIFIED="1490258026253" TEXT="I recommend MySQL Circular Replication only. Here is why">
<node CREATED="1490257741882" LINK="https://goo.gl/7A0grB" MODIFIED="1490257780133" TEXT="DRBD works great when the Server Pair is in the same bulding"/>
<node CREATED="1490257763033" LINK="https://goo.gl/7A0grB" MODIFIED="1490257777873" TEXT="Unfortunately, DRBD has horrible performance over a distance between two locations"/>
</node>
</node>
<node CREATED="1490258035530" FOLDED="true" MODIFIED="1490259108992" TEXT="9">
<node CREATED="1490257981330" LINK="https://goo.gl/2ny90P" MODIFIED="1490258004274" TEXT="Geo Clustering: What, How, and Why?"/>
</node>
</node>
<node CREATED="1462961304579" ID="ID_1919951929" LINK="http://goo.gl/0HRqFB" MODIFIED="1536120478575" POSITION="right" TEXT="The DRBD User&apos;s Guide - DRBD Users Guide (8.4)">
<icon BUILTIN="info"/>
<node CREATED="1463124963198" MODIFIED="1463124968395" TEXT="role">
<icon BUILTIN="help"/>
</node>
<node CREATED="1463135464013" FOLDED="true" LINK="http://goo.gl/bkxyXs" MODIFIED="1463383982183" TEXT="1.4. Resource roles">
<node CREATED="1463369055864" MODIFIED="1463369059436" TEXT="primary"/>
<node CREATED="1463369059682" MODIFIED="1463369063080" TEXT="secondary"/>
</node>
<node CREATED="1463119272641" FOLDED="true" LINK="https://goo.gl/TFSEQY" MODIFIED="1484648763307" TEXT="2.3. Replication modes">
<node CREATED="1463119386745" FOLDED="true" LINK="http://goo.gl/4oPRSy" MODIFIED="1484648763305" TEXT="&#x540c;&#x6b65;&#x65b9;&#x5f0f;&#x6709;">
<node CREATED="1463111385086" FOLDED="true" LINK="http://goo.gl/XiM2nj" MODIFIED="1484648763304" TEXT="Single-primary mode">
<node CREATED="1463118901692" LINK="http://goo.gl/4oPRSy" MODIFIED="1463118915548" TEXT="&#x53ea;&#x5141;&#x8a31;&#x4e00;&#x500b; node &#x8b80;&#x5beb;&#xff0c;&#x6a94;&#x6848;&#x7cfb;&#x7d71;&#x53ea;&#x9069;&#x5408; ext3, ext4, xfs"/>
<node CREATED="1463134469173" MODIFIED="1463134475555" TEXT="primary / secondary"/>
<node CREATED="1484642132499" MODIFIED="1484642133743" TEXT="this mode can be used with any conventional file system (ext3, ext4, XFS etc.)"/>
</node>
<node CREATED="1463122975501" FOLDED="true" LINK="http://goo.gl/w3gBBh" MODIFIED="1484648763305" TEXT="2.2. Dual-primary mode">
<node CREATED="1463123021219" MODIFIED="1463123023424" TEXT="&#x6703;&#x6709;&#x540c;&#x6642;&#x5b58;&#x53d6;&#x7684;&#x53ef;&#x80fd;&#xff0c;&#x6240;&#x4ee5;&#x9700;&#x8981;&#x6709; distributed lock manager&#xff0c;&#x50cf; GFS2 &#x8207; OCFS2"/>
</node>
</node>
<node CREATED="1463119402017" FOLDED="true" MODIFIED="1484648763306" TEXT="protocol">
<icon BUILTIN="help"/>
<node CREATED="1463119406145" FOLDED="true" MODIFIED="1484648763305" TEXT="A">
<node CREATED="1484641835659" MODIFIED="1484641836568" TEXT="Protocol A is most often used in long distance replication scenario"/>
</node>
<node CREATED="1463119407921" FOLDED="true" MODIFIED="1484648763306" TEXT="B">
<node CREATED="1484641888370" MODIFIED="1484641899574" TEXT="Local write operations on the primary node are considered completed"/>
<node CREATED="1484641900529" MODIFIED="1484641900529" TEXT="as soon as the local disk write has occurred"/>
</node>
<node CREATED="1463119409617" FOLDED="true" MODIFIED="1484648763306" TEXT="C">
<node CREATED="1484641945635" MODIFIED="1484641952390" TEXT="Local write operations on the primary node are considered completed"/>
<node CREATED="1484641953082" MODIFIED="1484641953759" TEXT=" only after both the local and the remote disk write have been confirmed."/>
</node>
</node>
</node>
<node CREATED="1484209733883" FOLDED="true" LINK="https://goo.gl/o2eVB7" MODIFIED="1484648763307" TEXT="Chapter 5. Configuring DRBD">
<node CREATED="1463136298909" FOLDED="true" LINK="https://goo.gl/umUoLv" MODIFIED="1463383982187" TEXT="5.2. Checking DRBD status">
<node CREATED="1463136330173" LINK="https://goo.gl/WJyNWa" MODIFIED="1463136366588" TEXT="5.2.3. Status information via drbdadm"/>
</node>
<node CREATED="1463118171971" LINK="https://goo.gl/QH5FmG" MODIFIED="1463118237130" TEXT="5.3. Configuring your resource"/>
<node CREATED="1463119729139" LINK="https://goo.gl/0XKBSD" MODIFIED="1463119738288" TEXT="5.5. The initial device synchronization"/>
</node>
<node CREATED="1484534929431" FOLDED="true" LINK="https://goo.gl/z9gm0f" MODIFIED="1490252212989" TEXT="Chapter 6. Common administrative tasks">
<node CREATED="1463136565445" LINK="https://goo.gl/AUplSt" MODIFIED="1463136581957" TEXT="6.1. Checking DRBD status"/>
<node CREATED="1484535248161" MODIFIED="1484535249047" TEXT="Automating"/>
<node CREATED="1463124930607" FOLDED="true" LINK="https://goo.gl/LUYTzP" MODIFIED="1484027197576" TEXT="6.5. Basic Manual Fail-over">
<node CREATED="1463125132702" MODIFIED="1463125140375" TEXT="unmount"/>
<node CREATED="1463125140678" MODIFIED="1463125146620" TEXT="demote to secondary"/>
</node>
</node>
<node CREATED="1463130140510" FOLDED="true" ID="ID_1492605532" LINK="https://goo.gl/qXBBZy" MODIFIED="1463383982188" TEXT="8.3. Adding a DRBD-backed service to the cluster configuration, including a master-slave resource">
<node CREATED="1463130312164" MODIFIED="1463130313253" TEXT="how to enable a DRBD-backed service in a Pacemaker cluster"/>
</node>
<node CREATED="1484642312379" FOLDED="true" LINK="https://goo.gl/scFisa" MODIFIED="1484648763307" TEXT="Why DRBD won&#x2019;t let you mount the Secondary">
<node CREATED="1484642300163" LINK="https://goo.gl/scFisa" MODIFIED="1484642319487" TEXT="If you do want access to the device from both nodes, use DRBD 8 in allow-two-primaries mode"/>
</node>
<node CREATED="1490176803428" LINK="https://goo.gl/cgMsDX" MODIFIED="1490176822519" TEXT="man 5 drbd.conf(5)"/>
</node>
<node CREATED="1445507516063" FOLDED="true" MODIFIED="1491469117175" POSITION="right" TEXT="notes">
<node CREATED="1458465812406" LINK="http://goo.gl/O8rso6" MODIFIED="1458465923711" TEXT="network-based RAID-1"/>
<node CREATED="1458465882243" LINK="https://goo.gl/Rcrka6" MODIFIED="1458465895654" TEXT="an exact copy (or mirror) of a set of data on two or more disks;"/>
<node CREATED="1445538890521" LINK="#ID_1772640511" MODIFIED="1445538898501" TEXT="drbd"/>
<node CREATED="1445507634144" LINK="https://goo.gl/fk190R" MODIFIED="1445507638893" TEXT="wiki"/>
<node CREATED="1445499880628" FOLDED="true" LINK="http://goo.gl/BAifKA" MODIFIED="1484037896137" TEXT="&#x81ea;&#x52d5;&#x540c;&#x6b65;&#x7684;&#x5132;&#x5b58;&#x7a7a;&#x9593; - DRBD">
<node CREATED="1445499855385" MODIFIED="1445499856777" TEXT="&#x900f;&#x904e;drbd&#x628a;&#x5132;&#x5b58;&#x8cc7;&#x6599;&#x8b8a;&#x6210;&#x5169;&#x4efd;"/>
<node CREATED="1445499870645" MODIFIED="1445499871652" TEXT="&#x505a;RAID1 (Mirror) over TCP/IP"/>
<node CREATED="1445500080420" FOLDED="true" MODIFIED="1460098808716" TEXT="install">
<node CREATED="1445500084052" MODIFIED="1445500085010" TEXT="&#x5207;&#x51fa;&#x65b0;&#x7684;&#x5206;&#x5272;&#x8868;sdb1"/>
</node>
<node CREATED="1445500106396" FOLDED="true" MODIFIED="1484037896134" TEXT="configure">
<node CREATED="1445500110964" MODIFIED="1445500112051" TEXT="&#x5c07;&#x5f7c;&#x6b64;&#x7684;IP&#x8cc7;&#x6599;&#x52a0;&#x5165;&#x7684;&#x672c;&#x6a5f;&#x5230;hosts"/>
</node>
<node CREATED="1444479537731" MODIFIED="1444479539244" TEXT="&#x8cc7;&#x6599;&#x6703;&#x81ea;&#x52d5;&#x5099;&#x4efd;&#x5230;&#x4e0d;&#x540c;&#x7684;&#x5132;&#x5b58;&#x7a7a;&#x9593;"/>
<node CREATED="1444482012833" FOLDED="true" LINK="http://goo.gl/gk9vYY" MODIFIED="1460098808716" TEXT="&#x4e5f;&#x53ef;&#x5c07;&#x4e4b;&#x8996;&#x4f5c;&#x70ba;&#x4ee5;&#x7db2;&#x8def;&#x70ba;&#x57fa;&#x790e;&#x7684;RAID-1">
<node CREATED="1444486276973" FOLDED="true" MODIFIED="1460098808716" TEXT="DRBD device initialization">
<node CREATED="1444486078945" LINK="https://goo.gl/MtyNYf" MODIFIED="1444486129153" TEXT="Create on both nodes two partitions on the RAID10 device. "/>
</node>
</node>
</node>
<node CREATED="1444481933618" FOLDED="true" LINK="http://goo.gl/ikY6G5" MODIFIED="1460965396930" TEXT="HA-DRBD Heartbeat &#x5efa;&#x7f6e; MySQL &#x9ad8;&#x53ef;&#x7528;&#x6027;">
<icon BUILTIN="info"/>
<node CREATED="1445507129263" MODIFIED="1445507130398" TEXT="&#x9ad8;&#x53ef;&#x7528;&#x6027;&#x5c0d;&#x65bc;&#x4e3b;&#x6a5f;&#x7684; FQDN &#x7684;&#x8a2d;&#x5b9a;&#x975e;&#x5e38;&#x8981;&#x6c42;"/>
</node>
<node CREATED="1445507598039" LINK="http://goo.gl/36NIFq" MODIFIED="1445507613321" TEXT="The DRBD User&#x2019;s Guide">
<icon BUILTIN="info"/>
</node>
<node CREATED="1444647510502" LINK="http://goo.gl/sNmg6F" MODIFIED="1444647550518" TEXT="needs a separate partition"/>
<node CREATED="1445500302996" FOLDED="true" MODIFIED="1463383982196" TEXT="file system type requirement">
<icon BUILTIN="help"/>
<node CREATED="1445502562893" LINK="http://goo.gl/tTZsbQ" MODIFIED="1445502573365" TEXT="mkfs.ext3"/>
</node>
<node CREATED="1444647564590" LINK="http://goo.gl/7NZQVh" MODIFIED="1444647580296" TEXT="is done mostly in-kernel"/>
<node CREATED="1442296332295" FOLDED="true" MODIFIED="1460098808718" TEXT="The project&apos;s main software product">
<node CREATED="1444702372936" LINK="#ID_1784507804" MODIFIED="1444702378756" TEXT="Heartbeat"/>
</node>
<node CREATED="1445851213088" FOLDED="true" LINK="../mysql.mm" MODIFIED="1460098808718" TEXT="mysql">
<node CREATED="1445851218202" LINK="http://goo.gl/SNcLUM" MODIFIED="1445851240680" TEXT="stop MySQL and rsync the contents of its existing datadir to the new location."/>
<node CREATED="1445851474200" MODIFIED="1445851475309" TEXT="/var/lib/mysql"/>
<node CREATED="1445851482232" MODIFIED="1445851484494" TEXT="rsync"/>
<node CREATED="1445851819616" LINK="http://goo.gl/IN9HRX" MODIFIED="1445851830830" TEXT="MySQL now provides support for DRBD"/>
<node CREATED="1445852025392" LINK="http://goo.gl/cX0hAj" MODIFIED="1445852037189" TEXT="DRBD for MySQL High Availability"/>
</node>
<node CREATED="1458528714341" LINK="#ID_1107701848" MODIFIED="1458528761885" TEXT="CentOS6.6&#x306e;Linux-HA&#x3067;DRBD&#x3092;&#x69cb;&#x7bc9;&#x3059;&#x308b;&#x624b;&#x9806;&#x3081;&#x3082;"/>
<node CREATED="1458875260949" LINK="https://geekpeek.net/wp-content/uploads/2013/08/drbd-scheme-300x80.jpg" MODIFIED="1458875276539" TEXT="good picture to explain"/>
<node CREATED="1462954229034" FOLDED="true" LINK="https://goo.gl/tPqbG7" MODIFIED="1463383982197" TEXT="DRBD &#x2013; How to configure DRBD on CentOS 6">
<icon BUILTIN="info"/>
<node CREATED="1462954800062" LINK="../networking.mm#ID_136775265" MODIFIED="1462954992939" TEXT="ntp syncing"/>
<node CREATED="1462955383337" MODIFIED="1462955386950" TEXT="ntp.conf"/>
</node>
<node CREATED="1462956837289" FOLDED="true" LINK="http://goo.gl/2e3WAZ" MODIFIED="1484121661052" TEXT="can sometimes pickup &apos;existing&apos; filesystems even without one being on the sytem.">
<node CREATED="1462956874385" MODIFIED="1462956875222" TEXT="You could of dd if=/dev/zero"/>
</node>
<node CREATED="1463121217826" FOLDED="true" MODIFIED="1463383982197" TEXT="load at boot">
<node CREATED="1463121226642" FOLDED="true" LINK="https://goo.gl/bPJoPL" MODIFIED="1463383982197" TEXT="40.2. Persistent Module Loading">
<node CREATED="1463121441973" MODIFIED="1463121443738" TEXT="/etc/rc.modules "/>
</node>
</node>
<node CREATED="1490260130165" MODIFIED="1490260147523" TEXT="how fast can drbd sync"/>
</node>
<node CREATED="1445502252797" FOLDED="true" MODIFIED="1490176780206" POSITION="right" TEXT="verify">
<node CREATED="1445502256805" LINK="http://goo.gl/tTZsbQ" MODIFIED="1445502267245" TEXT="To manually fail-over the DRBD device"/>
<node CREATED="1445502596661" LINK="http://goo.gl/tTZsbQ" MODIFIED="1445502606466" TEXT="Now we can try a manual fail-over including MySQL."/>
<node CREATED="1445507412287" LINK="http://goo.gl/jeolcJ" MODIFIED="1445507440510" TEXT="&#x6e2c;&#x8a66; HA &#x6a5f;&#x5236;"/>
</node>
<node CREATED="1463126558357" FOLDED="true" MODIFIED="1486105908385" POSITION="right" TEXT="startup">
<node CREATED="1463123124899" LINK="http://goo.gl/4oPRSy" MODIFIED="1463123139146" TEXT="&#x7576; drbd start&#x6642;&#xff0c;drbd device &#x4e5f;&#x6703;&#x88ab;&#x5efa;&#x7acb;&#x8d77;&#x4f86;&#xff0c;&#x5b83;&#x5c31;&#x662f;&#x88ab;&#x7528;&#x4f86;&#x639b;&#x8f09;&#x653e;&#x8cc7;&#x6599;&#x7684; device"/>
<node CREATED="1463126562949" FOLDED="true" LINK="http://goo.gl/zpRju7" MODIFIED="1484648763309" TEXT="Problem mounting drbd0 at boot">
<node CREATED="1463126733373" LINK="http://goo.gl/XfdPpR" MODIFIED="1463126744911" TEXT="you probably _really_ want a HA cluster manager like pacemaker or heartbeat dealing with this."/>
</node>
<node CREATED="1463129156694" FOLDED="true" LINK="http://goo.gl/l3fsSY" MODIFIED="1463383982198" TEXT="configure your operating system to load the module at boot time">
<node CREATED="1463129234097" LINK="https://goo.gl/a2Oupt" MODIFIED="1463129245131" TEXT="How to load modules on boot CentOS 6.x"/>
<node CREATED="1463129032070" LINK="http://goo.gl/l3fsSY" MODIFIED="1463129172333" TEXT="For CentOS 7.1"/>
</node>
<node CREATED="1463131005710" FOLDED="true" LINK="https://goo.gl/qXBBZy" MODIFIED="1463383982199" TEXT="recommended that you defer DRBD startup">
<node CREATED="1463131267301" MODIFIED="1463131268653" TEXT="ocf:linbit:drbd OCF resource agent"/>
</node>
</node>
<node CREATED="1445499696628" FOLDED="true" MODIFIED="1486105908385" POSITION="right" TEXT="Monitor DRBD status">
<node CREATED="1445499683764" MODIFIED="1445499684913" TEXT="service drbd status"/>
<node CREATED="1445500137780" LINK="#ID_1400237890" MODIFIED="1447931888359" TEXT="8.4.6"/>
</node>
<node CREATED="1462961090510" FOLDED="true" MODIFIED="1486105908385" POSITION="right" TEXT="shutdown">
<node CREATED="1462961095619" MODIFIED="1462961100486" TEXT="correct way"/>
</node>
<node CREATED="1463118434226" FOLDED="true" LINK="https://goo.gl/L9oxAm" MODIFIED="1490252212995" POSITION="right" TEXT="drbdsetup">
<node CREATED="1490250418478" MODIFIED="1490250421434" TEXT="show"/>
</node>
<node CREATED="1445501017941" FOLDED="true" LINK="https://goo.gl/r1rqMn" MODIFIED="1490176767758" POSITION="right" TEXT="drbdadm">
<icon BUILTIN="info"/>
<node CREATED="1458875345516" LINK="#ID_1449728282" MODIFIED="1458875351887" TEXT="drbdadm"/>
<node CREATED="1445502856789" MODIFIED="1445502859306" TEXT="connect"/>
<node CREATED="1445502350773" FOLDED="true" MODIFIED="1463383982201" TEXT="create-md">
<node CREATED="1445541007660" FOLDED="true" LINK="https://goo.gl/tPqbG7" MODIFIED="1463383982201" TEXT="Initialize DRBD meta data">
<node CREATED="1462954229034" LINK="#ID_743100940" MODIFIED="1462954509816" TEXT="DRBD &#x2013; How to configure DRBD on CentOS 6">
<icon BUILTIN="info"/>
</node>
</node>
</node>
<node CREATED="1458878153086" MODIFIED="1458878153762" TEXT="Removing DRBD resource"/>
<node CREATED="1445502355724" FOLDED="true" MODIFIED="1460098808734" TEXT="up">
<node CREATED="1458875431205" LINK="https://goo.gl/nXZZdQ" MODIFIED="1458875470659" TEXT="2. Enable and Disable DRBD Resource"/>
</node>
<node CREATED="1445502849197" FOLDED="true" MODIFIED="1460098808735" TEXT="down">
<node CREATED="1458878241174" LINK="http://goo.gl/lB2IFL" MODIFIED="1458878254058" TEXT="Safely Remove Resource in 8.3"/>
</node>
<node CREATED="1444479771713" MODIFIED="1444479772501" TEXT="primary"/>
<node CREATED="1445502302069" MODIFIED="1445502302966" TEXT="secondary"/>
<node CREATED="1445502869917" MODIFIED="1445502871827" TEXT="attach"/>
<node CREATED="1458878192558" MODIFIED="1458878196235" TEXT="detach"/>
<node CREATED="1445507285536" FOLDED="true" MODIFIED="1460111960682" TEXT="-- --overwrite-data-of-peer primary ha">
<node CREATED="1445507302951" LINK="http://goo.gl/EVQnxx" MODIFIED="1445507335973" TEXT="&#x4f7f;&#x4e8c;&#x53f0;&#x4e3b;&#x6a5f;&#x958b;&#x59cb;&#x540c;&#x6b65; hdb &#x786c;&#x789f;&#x8cc7;&#x6599; (&#x5c46;&#x6642;&#x7684; /dev/drbd0)"/>
<node CREATED="1460107693207" MODIFIED="1460107694116" TEXT="&#x8a2d;&#x5b9a; Node1 &#x70ba; Primary Node"/>
<node CREATED="1460108275751" LINK="https://goo.gl/aaH7Zz" MODIFIED="1460108312162" TEXT="Sets the device into primary role">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1463123268579" MODIFIED="1463123272777" TEXT="cstate"/>
<node CREATED="1458878398846" LINK="https://goo.gl/lX3Utn" MODIFIED="1458878478651" TEXT="dstate"/>
<node CREATED="1458878469190" LINK="https://goo.gl/lX3Utn" MODIFIED="1458878481009" TEXT="invalidate"/>
<node CREATED="1463119327241" MODIFIED="1463119331093" TEXT="--overwrite-data-of-peer">
<icon BUILTIN="help"/>
</node>
<node CREATED="1463369114179" FOLDED="true" MODIFIED="1463383982201" TEXT="status">
<node CREATED="1463369118250" MODIFIED="1463369122662" TEXT="centos 7.1"/>
</node>
<node CREATED="1484287599683" LINK="https://goo.gl/9F7U4o" MODIFIED="1484287618468" TEXT="role"/>
<node CREATED="1484287747879" MODIFIED="1484287748795" TEXT="Switch the DRBD block device to Primary using drbdadm"/>
<node CREATED="1487055352395" MODIFIED="1487055355286" TEXT="adjust"/>
<node CREATED="1487055406208" FOLDED="true" MODIFIED="1488961488577" TEXT="reconfigure">
<icon BUILTIN="help"/>
<node CREATED="1487055461784" LINK="https://goo.gl/KWcCph" MODIFIED="1487055814408" TEXT="6.3. Reconfiguring resources"/>
<node CREATED="1487055897080" MODIFIED="1487055898777" TEXT="sudo drbdadm adjust ippbx"/>
</node>
</node>
<node CREATED="1445917218808" LINK="#ID_1772640511" MODIFIED="1445917224835" POSITION="right" TEXT="drbd"/>
<node CREATED="1460962005543" ID="ID_1460653876" LINK="../tux/lvm.mm" MODIFIED="1460962018669" POSITION="right" TEXT="lvm"/>
<node CREATED="1460965554913" MODIFIED="1460965555849" POSITION="right" TEXT="need its own block device on each node"/>
<node CREATED="1484122451915" ID="ID_897055773" LINK="https://goo.gl/QH5FmG" MODIFIED="1484122465866" POSITION="right" TEXT="A per-resource configuration file is usually named /etc/drbd.d/&lt;resource&gt;.res"/>
<node CREATED="1484289653857" LINK="https://goo.gl/nqYXaN" MODIFIED="1484289664830" POSITION="right" TEXT="Typical problems in DRBD include"/>
<node CREATED="1484637207569" LINK="https://goo.gl/ASJjH5" MODIFIED="1484637220422" POSITION="right" TEXT="The Cross-Over/DRBD interface"/>
<node CREATED="1484641674747" LINK="https://goo.gl/scFisa" MODIFIED="1484641708862" POSITION="right" TEXT="Why DRBD won&apos;t let you mount the Secondary"/>
<node CREATED="1484641687539" LINK="https://goo.gl/1ms9qC" MODIFIED="1484641698729" POSITION="right" TEXT="Checking your Secondary&apos;s integrity"/>
<node CREATED="1486028708113" FOLDED="true" MODIFIED="1486105908386" POSITION="right" TEXT="drbd not defined in your config">
<node CREATED="1486028742677" MODIFIED="1486028749657" TEXT="Make sure the node name"/>
<node CREATED="1486028750717" LINK="https://goo.gl/GlnvmN" MODIFIED="1486028768860" TEXT=" (node1 and node2) match the output of &apos;uname -n&apos; on the two nodes."/>
</node>
<node CREATED="1486720843269" FOLDED="true" MODIFIED="1488961488577" POSITION="right" TEXT="DRBD vs. rsync">
<node CREATED="1486720839110" LINK="https://goo.gl/3ST3PO" MODIFIED="1486720892310" TEXT="have found it unreliable during maintenance events"/>
</node>
<node CREATED="1444486491928" ID="ID_272330913" MODIFIED="1536114346366" POSITION="right" TEXT="configure">
<node CREATED="1445538999820" FOLDED="true" MODIFIED="1484648763308" TEXT="simplest">
<node CREATED="1445539067361" FOLDED="true" LINK="https://goo.gl/WS5QpR" MODIFIED="1460098808722" TEXT="Chapter 5. Configuring DRBD">
<node CREATED="1445539123790" FOLDED="true" LINK="https://goo.gl/vKv2sm" MODIFIED="1460098808719" TEXT="5.1. Preparing your lower-level storage">
<node CREATED="1445539444863" MODIFIED="1445539446284" TEXT="A hard drive partition (or a full physical hard drive)"/>
<node CREATED="1445539471233" FOLDED="true" MODIFIED="1460098808719" TEXT="may also use resource stacking">
<node CREATED="1445539483237" MODIFIED="1445539489532" TEXT="what is this">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1445539544542" MODIFIED="1445539545986" TEXT="Both hosts have a free (currently unused) partition named /dev/sda7"/>
</node>
<node CREATED="1445539630484" FOLDED="true" LINK="https://goo.gl/OUjOPi" MODIFIED="1460098808720" TEXT="5.2. Preparing your network configuration">
<node CREATED="1445539809299" MODIFIED="1445539810151" TEXT="not possible to configure a DRBD resource to support more than one TCP connection"/>
<node CREATED="1445539844116" MODIFIED="1445539844914" TEXT="No other services are using TCP ports 7788 through 7799 on either host."/>
</node>
<node CREATED="1445539894842" FOLDED="true" LINK="https://goo.gl/jKTOBw" MODIFIED="1460098808721" TEXT="5.3. Configuring your resource">
<node CREATED="1445539958247" FOLDED="true" MODIFIED="1460098808720" TEXT="should always make sure that ">
<node CREATED="1445539972456" MODIFIED="1445539996331" TEXT="drbd.conf, "/>
<node CREATED="1445539996711" MODIFIED="1445539997448" TEXT="and any other files it includes, "/>
<node CREATED="1445539988849" MODIFIED="1445539989571" TEXT="are exactly identical on all participating cluster nodes"/>
</node>
<node CREATED="1445540198049" MODIFIED="1445540198806" TEXT="assume a minimal setup"/>
</node>
</node>
</node>
<node CREATED="1444481879173" FOLDED="true" LINK="https://goo.gl/0RY6J2" MODIFIED="1460098808723" TEXT="&#x9632;&#x706b;&#x7246;&#x7684;&#x8003;&#x616e;">
<node CREATED="1444485802393" LINK="http://goo.gl/29MjN9" MODIFIED="1444485815906" TEXT=" Iptables ports (7788) allowed"/>
<node CREATED="1445539849480" LINK="#ID_1438568335" MODIFIED="1445539862881" TEXT="tcp 7788-7799"/>
</node>
<node CREATED="1444485887891" FOLDED="true" MODIFIED="1484648763308" TEXT="partition">
<node CREATED="1445501184012" LINK="http://goo.gl/tTZsbQ" MODIFIED="1445501196113" TEXT="prepare your device/partition"/>
<node CREATED="1444486018756" LINK="https://goo.gl/MtyNYf" MODIFIED="1444486033042" TEXT="Create on both nodes two partitions on the RAID10 device."/>
<node CREATED="1445501993989" LINK="http://goo.gl/tTZsbQ" MODIFIED="1445502004101" TEXT="with MySQL databases we should only have Primary/Secondary roles,"/>
<node CREATED="1445502052701" MODIFIED="1445502059041" TEXT="format and mount the device"/>
<node CREATED="1445502078861" FOLDED="true" LINK="http://goo.gl/tTZsbQ" MODIFIED="1484648763308" TEXT="Do not add the device to the fstab.">
<icon BUILTIN="yes"/>
<node CREATED="1445502171301" LINK="http://goo.gl/tTZsbQ" MODIFIED="1445502181296" TEXT="This resource will be controlled by Heartbeat later."/>
<node CREATED="1447985444537" LINK="#ID_1789518683" MODIFIED="1447985449745" TEXT="Do not add the device to the fstab."/>
</node>
</node>
<node CREATED="1445500850093" ID="ID_604626414" LINK="https://goo.gl/Jekd3x" MODIFIED="1541492307560" TEXT="&#x8a2d;&#x5b9a;&#x6a94;&#x5728;/etc/drbd.conf">
<node CREATED="1449493463150" FOLDED="true" MODIFIED="1463383982190" TEXT="ls -latr /usr/share/doc/drbd84-utils-8.9.2/">
<node CREATED="1449493468755" MODIFIED="1449493473155" TEXT="example conf"/>
</node>
<node CREATED="1444648694623" FOLDED="true" LINK="https://goo.gl/e7APxb" MODIFIED="1491469117176" TEXT="/etc/drbd.conf">
<icon BUILTIN="info"/>
<node CREATED="1445501399061" FOLDED="true" LINK="https://goo.gl/MQuEUD" MODIFIED="1460098808725" TEXT="introduction">
<node CREATED="1445501383845" LINK="https://goo.gl/MQuEUD" MODIFIED="1445501398451" TEXT="is read by drbdadm"/>
</node>
<node CREATED="1445500892188" FOLDED="true" MODIFIED="1491469117176" TEXT="&#x7d0d;&#x5165;">
<node CREATED="1445540626140" LINK="#ID_1032025749" MODIFIED="1445540632031" TEXT="global_common.conf"/>
<node CREATED="1445540457805" LINK="#ID_442879933" MODIFIED="1445540470118" TEXT="/etc&#x4e0b;drbd.d/"/>
</node>
<node CREATED="1463118361577" LINK="#ID_1449728282" MODIFIED="1463118373095" TEXT="read by drbdadm"/>
<node CREATED="1490259544812" LINK="https://goo.gl/snSyxC" MODIFIED="1490259579647" TEXT="after-resync-target"/>
</node>
<node CREATED="1445539321367" ID="ID_219091627" MODIFIED="1536114346373" TEXT="/etc/drbd.d">
<node CREATED="1445540447676" ID="ID_808684679" MODIFIED="1536114346376" TEXT="global_common.conf">
<node CREATED="1445501318037" FOLDED="true" MODIFIED="1463383982192" TEXT="global">
<node CREATED="1445540576341" MODIFIED="1445540577585" TEXT="usage-count yes;"/>
</node>
<node CREATED="1445501321317" FOLDED="true" ID="ID_1028191281" MODIFIED="1541492291238" TEXT="common">
<node CREATED="1489730275622" FOLDED="true" MODIFIED="1490169522450" TEXT="startup">
<node CREATED="1489142028429" MODIFIED="1489142032737" TEXT="wfc-timeout"/>
<node CREATED="1489142005325" MODIFIED="1489142028097" TEXT="degr-wfc-timeout"/>
</node>
<node CREATED="1445540705794" ID="ID_1626973078" MODIFIED="1536114346381" TEXT="net ">
<node CREATED="1445540721043" MODIFIED="1445540723278" TEXT="protocol C;"/>
<node CREATED="1490177937139" ID="ID_1194232273" MODIFIED="1490177938321" TEXT="after-sb-0pri, after-sb-1pri, after-sb-2pri"/>
<node CREATED="1490177885243" ID="ID_1113191877" LINK="https://goo.gl/Jekd3x" MODIFIED="1490177957147" TEXT="refer to drbdsetup(8) for a detailed description of this section&apos;s parameters."/>
<node CREATED="1536116177724" ID="ID_467152692" MODIFIED="1536116181986" TEXT="policy">
<node CREATED="1490237254448" ID="ID_594833720" MODIFIED="1490237256525" TEXT="after-sb-0pri">
<node CREATED="1536119454932" ID="ID_1336544112" LINK="https://goo.gl/tnavxk" MODIFIED="1536119485031" TEXT="none of the two nodes is in primary role."/>
</node>
<node CREATED="1490237270048" ID="ID_255191840" MODIFIED="1490237273406" TEXT="after-sb-1pri">
<node CREATED="1536119663685" ID="ID_1002452431" MODIFIED="1536119664864" TEXT="one node in primary role and one node in secondary role. "/>
</node>
<node CREATED="1490237283952" ID="ID_896281866" MODIFIED="1490237285628" TEXT="after-sb-2pri"/>
<node CREATED="1536117113311" ID="ID_1034257449" MODIFIED="1536117124198" TEXT="multiple | ored option?"/>
</node>
<node CREATED="1490250737798" ID="ID_1787247575" MODIFIED="1490250746479" TEXT="congestion policy">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1486024236053" ID="ID_529981855" MODIFIED="1536117429706" TEXT="handler">
<node CREATED="1536130219403" ID="ID_455794185" MODIFIED="1536130220466" TEXT="startup"/>
<node CREATED="1536120488802" ID="ID_1748588824" LINK="https://goo.gl/N6DfxH" MODIFIED="1536120499326" TEXT="initial-split-brain"/>
<node CREATED="1486024242555" FOLDED="true" ID="ID_1271934412" LINK="https://goo.gl/KtwzXV" MODIFIED="1536130253273" TEXT="split-brain">
<node CREATED="1489562352984" MODIFIED="1489562354292" TEXT="backing devices of your DRBD resource on both sides of your cluster started to diverge"/>
<node CREATED="1486024984636" ID="ID_853063494" LINK="https://goo.gl/rn2VUk" MODIFIED="1536119997318" TEXT="Solve a DRBD split-brain in 4 steps">
<node CREATED="1489562215826" MODIFIED="1489562216950" TEXT="Indications"/>
</node>
<node CREATED="1486025837700" ID="ID_1536307805" LINK="https://goo.gl/zJVLwE" MODIFIED="1536120000969" TEXT="6.17. Configuring split brain behavior">
<node CREATED="1489562474800" MODIFIED="1489562476317" TEXT="Automatic split brain recovery policies"/>
</node>
<node CREATED="1486025679788" ID="ID_324058877" LINK="https://goo.gl/C60pB5" MODIFIED="1486025691571" TEXT="7.3. Manual split brain recovery"/>
<node CREATED="1536120554786" ID="ID_1598133262" MODIFIED="1536120557931" TEXT="recovery">
<node CREATED="1490177829839" ID="ID_121231758" MODIFIED="1490177833376" TEXT="auto"/>
<node CREATED="1536120569281" ID="ID_1733263821" MODIFIED="1536120572066" TEXT="manual"/>
</node>
<node CREATED="1536120559778" ID="ID_1504785204" MODIFIED="1536120563674" TEXT="prevention"/>
</node>
<node CREATED="1536120515666" ID="ID_826167603" LINK="https://goo.gl/N6DfxH" MODIFIED="1536120524372" TEXT="after-resync-target"/>
<node CREATED="1536117435063" ID="ID_141959215" MODIFIED="1536117441713" TEXT="out-of-sync"/>
</node>
</node>
</node>
<node CREATED="1445500908404" MODIFIED="1445500909187" TEXT="drbd&#x4e0b;*.res"/>
<node CREATED="1449542815456" LINK="https://goo.gl/jKTOBw" MODIFIED="1449542826152" TEXT="5.3.1. Example configuration"/>
<node CREATED="1445540298927" ID="ID_1588749727" LINK="https://goo.gl/jKTOBw" MODIFIED="1541492307564" TEXT="r0.res">
<node CREATED="1449542769496" LINK="https://goo.gl/jKTOBw" MODIFIED="1449542790167" TEXT="Simple DRBD resource configuration (/etc/drbd.d/r0.res)."/>
<node CREATED="1445501333093" ID="ID_1163912889" MODIFIED="1541492307569" TEXT="resource">
<node CREATED="1458810680218" FOLDED="true" MODIFIED="1460098808727" TEXT="device">
<node CREATED="1449541901111" MODIFIED="1449541902978" TEXT="DRBD device"/>
<node CREATED="1449541918401" LINK="https://goo.gl/3920ch" MODIFIED="1449541940889" TEXT="a virtual block device managed by DRBD"/>
</node>
<node CREATED="1449494410245" FOLDED="true" LINK="https://goo.gl/Pamm3c" MODIFIED="1460098808727" TEXT="on host-name">
<node CREATED="1449494532267" MODIFIED="1449494825233" TEXT="address:port"/>
<node CREATED="1449494978403" MODIFIED="1449494981543" TEXT="volume"/>
<node CREATED="1449494855334" MODIFIED="1449494858279" TEXT="disk"/>
</node>
<node CREATED="1449542370936" FOLDED="true" MODIFIED="1460098808728" TEXT="meta-disk internal,">
<node CREATED="1449542385208" LINK="http://goo.gl/0PMCwg" MODIFIED="1449542428139" TEXT="the last part of the backing device is used to store the meta-data"/>
</node>
<node CREATED="1458811816365" MODIFIED="1458811820317" TEXT="syncer">
<icon BUILTIN="help"/>
</node>
<node CREATED="1458811834738" LINK="#ID_759482267" MODIFIED="1458811865060" TEXT="protocol C;"/>
<node CREATED="1458811973586" FOLDED="true" MODIFIED="1490258026259" TEXT="net">
<node CREATED="1458811977443" FOLDED="true" LINK="http://goo.gl/O8rso6" MODIFIED="1490258026259" TEXT="allow-two-primaries;">
<icon BUILTIN="help"/>
<node CREATED="1490257434960" LINK="https://goo.gl/snSyxC" MODIFIED="1490257455203" TEXT="You only should use this option if you use a shared storage file"/>
</node>
</node>
<node CREATED="1490252382439" ID="ID_759459945" MODIFIED="1490252383436" TEXT="handlers">
<node CREATED="1541492309184" ID="ID_239750875" MODIFIED="1541492310216" TEXT="by drbdadm&apos;s userspace callouts."/>
</node>
</node>
<node CREATED="1449495034933" LINK="https://goo.gl/jKTOBw" MODIFIED="1449495051808" TEXT="options with equal values on both hosts can be specified directly in the resource section."/>
<node CREATED="1449542849712" MODIFIED="1449542850943" TEXT="Multi-volume DRBD resource configuration"/>
<node CREATED="1458811869338" LINK="../tatung.mm#ID_1806850366" MODIFIED="1458811929178" TEXT="aka tatung.res"/>
</node>
</node>
<node CREATED="1445501448989" LINK="#ID_713743724" MODIFIED="1445540336399" TEXT="is equal on both nodes"/>
<node CREATED="1489729447966" ID="ID_537210027" LINK="https://goo.gl/Qy9Pqw" MODIFIED="1489729456513" TEXT="man drbd.conf"/>
<node CREATED="1536126278565" ID="ID_1616768272" LINK="https://goo.gl/a9SUaa" MODIFIED="1536126295662" TEXT="8.3 example"/>
</node>
<node CREATED="1445502523565" MODIFIED="1445502524835" TEXT="we have to disable the automated start/stop mechanism"/>
<node CREATED="1445502538461" MODIFIED="1445502541876" TEXT="device"/>
<node CREATED="1445507203111" FOLDED="true" MODIFIED="1484648763309" TEXT="replica">
<node CREATED="1445507212887" FOLDED="true" MODIFIED="1484648763308" TEXT="mysql">
<node CREATED="1445507216423" LINK="http://goo.gl/rj1PJX" MODIFIED="1445507232999" TEXT="&#x4fee;&#x6539; mysql &#x8a2d;&#x5b9a;&#x6a94;&#xff0c;&#x5c07; mysql &#x8cc7;&#x6599;&#x5eab;&#x5b58;&#x653e;&#x8def;&#x5f91;&#x7531;&#x9810;&#x8a2d;&#x7684; /var/lib/mysql &#x4fee;&#x6539;&#x81f3;&#x5c46;&#x6642;&#x6703;&#x57f7;&#x884c;&#x786c;&#x789f;&#x8cc7;&#x6599;&#x540c;&#x6b65;&#x7684; /db"/>
</node>
</node>
<node CREATED="1445507958960" FOLDED="true" MODIFIED="1460098808732" TEXT="nic">
<node CREATED="1445499339260" FOLDED="true" MODIFIED="1460098808732" TEXT="2 nic required?">
<node CREATED="1445538294209" MODIFIED="1445538298469" TEXT="mgnt"/>
<node CREATED="1445538298802" MODIFIED="1445538306507" TEXT="mirror"/>
</node>
<node CREATED="1445507962136" MODIFIED="1445507965134" TEXT="mgnt"/>
<node CREATED="1445507965471" LINK="#ID_902155500" MODIFIED="1445507975722" TEXT="replica"/>
</node>
<node CREATED="1463112108289" LINK="#ID_1293718249" MODIFIED="1463112115054" TEXT="Single-primary mode"/>
<node CREATED="1463119167913" ID="ID_1441087234" MODIFIED="1536120038170" TEXT="reference articles">
<node CREATED="1463119143433" LINK="#ID_1967837099" MODIFIED="1463119149103" TEXT="How to configure DRBD On CentOS 6.5"/>
</node>
<node CREATED="1463135319765" FOLDED="true" LINK="http://goo.gl/Jz9d14" MODIFIED="1463383982195" TEXT="Do we need to run mkfs on the replicating node?">
<node CREATED="1463135340462" MODIFIED="1463135341058" TEXT=" I guess you do not (and with ext3, you do not want to) use dual primary mode."/>
<node CREATED="1463135348501" MODIFIED="1463135349039" TEXT="You don&apos;t have to run mkfs on the secondary."/>
<node CREATED="1463135431013" MODIFIED="1463135431962" TEXT="I guess you should read the drbd users-guide fundamentals chapter."/>
<node CREATED="1463135440565" FOLDED="true" MODIFIED="1463383982194" TEXT="Especially the chapter on resource roles">
<node CREATED="1463135458158" LINK="#ID_1243919311" MODIFIED="1463135475851" TEXT="1.4. Resource roles"/>
</node>
</node>
<node CREATED="1463370258471" FOLDED="true" LINK="https://goo.gl/KtwzXV" MODIFIED="1463383982195" TEXT="Configure Pacemaker Cluster">
<node CREATED="1460102774652" LINK="#ID_680775940" MODIFIED="1460102908108" TEXT="&#x8001;&#x7070;&#x9d28;&#x7684;&#x7b46;&#x8a18;&#x672c;: &#x3010;CentOS 6.2&#x3011;DRBD &#x5efa;&#x7acb;MySQL server HA"/>
<node CREATED="1460102933252" LINK="#ID_791386929" MODIFIED="1460102939169" TEXT="Active/Passive MySQL High Availability Pacemaker Cluster with DRBD on CentOS 7"/>
</node>
<node CREATED="1490173018895" MODIFIED="1490173022654" TEXT="sync rate"/>
<node CREATED="1490250369746" ID="ID_1172413234" LINK="https://goo.gl/jVb6oT" MODIFIED="1490250620018" TEXT="5.2. Checking DRBD status"/>
<node CREATED="1444486488778" FOLDED="true" ID="ID_1967837099" LINK="http://goo.gl/29MjN9" MODIFIED="1510206392863" TEXT="How to configure DRBD On CentOS 6.5">
<node CREATED="1463134134657" ID="ID_1848555588" MODIFIED="1463134137722" TEXT="drbd 8.3"/>
<node CREATED="1463134163390" ID="ID_1443316674" MODIFIED="1463134164333" TEXT="Set NTP server and add it to crontab  on both machines:"/>
<node CREATED="1463134181125" ID="ID_208819279" MODIFIED="1463134181925" TEXT="&#x2013;overwrite-data-of-peer"/>
<node CREATED="1463134397213" ID="ID_134510126" MODIFIED="1463134398147" TEXT="Switch Primary/Secondary"/>
</node>
</node>
<node CREATED="1491898403082" LINK="https://goo.gl/rJxFta" MODIFIED="1491898416571" POSITION="right" TEXT="Force one node to be uptodate"/>
<node CREATED="1495189731921" LINK="https://goo.gl/Bn1JUc" MODIFIED="1495189770242" POSITION="right" TEXT="Internal metadata, and why we recommend it"/>
<node CREATED="1495434651062" FOLDED="true" MODIFIED="1499844888654" POSITION="right" TEXT="sets aside a small area on a local disk (on every cluster node) where it keeps">
<node CREATED="1495434681408" MODIFIED="1495434683909" TEXT="the Activity Log"/>
<node CREATED="1495434695264" MODIFIED="1495434696236" TEXT="the quick-sync bitmap"/>
<node CREATED="1495434696735" MODIFIED="1495434714676" TEXT="data generation UUIDs"/>
</node>
<node CREATED="1505109138488" FOLDED="true" MODIFIED="1518158664855" POSITION="right" TEXT="max volume size">
<node CREATED="1505109229979" LINK="https://goo.gl/1nwii7" MODIFIED="1505109252444" TEXT="current maximum device size is 1PiB (1 PetiByte = 1024 TibiByte"/>
</node>
<node CREATED="1505179390257" LINK="https://goo.gl/cHBm4K" MODIFIED="1505179408533" POSITION="right" TEXT="Since DRBD 8.4, the default has switched to variable-rate synchronization."/>
<node CREATED="1521183633846" ID="ID_1979835020" LINK="https://goo.gl/aAqEe9" MODIFIED="1529393307022" POSITION="right" TEXT="DRBD terrible sync performance">
<node CREATED="1521510561096" ID="ID_709762117" MODIFIED="1521510568525" TEXT="how to speed up">
<icon BUILTIN="help"/>
<node CREATED="1521510569758" ID="ID_130172761" MODIFIED="1521510575826" TEXT="configuration">
<icon BUILTIN="help"/>
</node>
<node CREATED="1521510576669" ID="ID_1158257894" MODIFIED="1521510579157" TEXT="tips">
<icon BUILTIN="help"/>
</node>
<node CREATED="1521510579941" ID="ID_1157395188" MODIFIED="1521510587771" TEXT="multiple NIC">
<icon BUILTIN="help"/>
</node>
<node CREATED="1521510588662" ID="ID_1166867457" MODIFIED="1521510593134" TEXT="example">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1521527234199" ID="ID_1539573023" LINK="https://goo.gl/Jj18qq" MODIFIED="1521527247112" POSITION="right" TEXT="configuration and performance tuning wiki"/>
<node CREATED="1521603306966" ID="ID_737790252" LINK="https://goo.gl/jMvNjF" MODIFIED="1521603341140" POSITION="right" TEXT="failed count"/>
<node CREATED="1525381754342" FOLDED="true" ID="ID_491584663" LINK="https://goo.gl/5KMWYt" MODIFIED="1529056790579" POSITION="right" TEXT="Resizing resources">
<node CREATED="1525382011679" ID="ID_1608035663" MODIFIED="1525382015031" TEXT="growing">
<node CREATED="1525381901323" ID="ID_724892938" MODIFIED="1525381904679" TEXT="online"/>
<node CREATED="1525381898493" ID="ID_179186781" MODIFIED="1525381900938" TEXT="offline">
<node CREATED="1525381910587" ID="ID_1525173622" MODIFIED="1525381918406" TEXT="external meta">
<node CREATED="1525381925156" ID="ID_1564983925" MODIFIED="1525381926398" TEXT="auto"/>
</node>
<node CREATED="1525381918744" ID="ID_1890853637" MODIFIED="1525381921799" TEXT="internal meta"/>
</node>
</node>
<node CREATED="1525382015444" ID="ID_744006132" MODIFIED="1525382020566" TEXT="shrinking"/>
</node>
<node CREATED="1525382078075" ID="ID_139921999" LINK="https://goo.gl/RVfG7q" MODIFIED="1525382202812" POSITION="right" TEXT="internal vs external metadata"/>
<node CREATED="1524737979112" ID="ID_1388915606" LINK="https://goo.gl/45pgHj" MODIFIED="1524738001641" POSITION="left" TEXT="should not be used over a geographic distance."/>
<node CREATED="1490240542224" ID="ID_1511294887" MODIFIED="1536117555150" POSITION="left" TEXT="split brain">
<node CREATED="1458877119024" FOLDED="true" MODIFIED="1490252212998" TEXT="recovery">
<node CREATED="1458877122549" LINK="http://goo.gl/VmzMr1" MODIFIED="1458877135531" TEXT="How to fix DRBD recovery from split brain"/>
<node CREATED="1458877500701" FOLDED="true" LINK="http://goo.gl/nqYXaN" MODIFIED="1486105908385" TEXT="&#x201c;Manually Connecting the DRBD Slave to the Master&#x201d;.">
<node CREATED="1458877556213" MODIFIED="1458877557013" TEXT="If the master node reports WFConnection while the slave node reports StandAlone "/>
<node CREATED="1458877568733" MODIFIED="1458877569396" TEXT=" it indicates a DRBD split brain. See &#x201c;Correcting a DRBD Split Brain&#x201d;."/>
</node>
<node CREATED="1490237867432" FOLDED="true" MODIFIED="1490252212996" TEXT="manual">
<node CREATED="1490237897128" LINK="https://goo.gl/RW0Epz" MODIFIED="1490237917346" TEXT="recommended"/>
<node CREATED="1484290655361" LINK="https://goo.gl/C60pB5" MODIFIED="1484290678293" TEXT="7.3. Manual split brain recovery"/>
</node>
<node CREATED="1490237871384" FOLDED="true" MODIFIED="1490252212997" TEXT="auto">
<node CREATED="1490238010080" MODIFIED="1490238010917" TEXT="resolution algorithms "/>
</node>
</node>
<node CREATED="1460110127352" FOLDED="true" LINK="https://goo.gl/rn2VUk" MODIFIED="1490252212998" TEXT="Indications of a Split-Brain">
<node CREATED="1490240493992" LINK="https://goo.gl/rn2VUk" MODIFIED="1490240503334" TEXT="fencing policy is set to dont-care (default)"/>
<node CREATED="1490240594465" LINK="#ID_1027310883" MODIFIED="1490240634276" TEXT="manual"/>
</node>
<node CREATED="1445851728416" MODIFIED="1445851743347" TEXT="what is split-brain scenario?"/>
<node CREATED="1490252221967" LINK="https://goo.gl/Rtxhep" MODIFIED="1490252235127" TEXT="for example, due to one of the following occurrences:"/>
<node CREATED="1490261263003" FOLDED="true" LINK="https://goo.gl/tbrUD8" MODIFIED="1491469117175" TEXT="can&apos;t start resync">
<node CREATED="1490261250256" LINK="https://goo.gl/tbrUD8" MODIFIED="1490261286003" TEXT="Dirty and quick solution"/>
</node>
<node CREATED="1529029127831" ID="ID_1088755322" LINK="https://goo.gl/4bR89J" MODIFIED="1529029153265" TEXT="guess fencing would be best option to avoid split-brain"/>
<node CREATED="1529055068474" ID="ID_956390306" LINK="https://goo.gl/XedtES" MODIFIED="1529055220557" TEXT="Remote failed to finish a request within">
<node CREATED="1529055153233" ID="ID_1784801705" LINK="https://goo.gl/XedtES" MODIFIED="1529055225722" TEXT="If a secondary node">
<node CREATED="1529055173887" ID="ID_719469640" LINK="https://goo.gl/XedtES" MODIFIED="1529055228938" TEXT="fails to complete a write request in ko-count times the timeout parameter, "/>
<node CREATED="1529055189168" ID="ID_62963285" LINK="https://goo.gl/XedtES" MODIFIED="1529055231198" TEXT="it is excluded from the cluster."/>
</node>
<node CREATED="1529055253759" ID="ID_33752764" MODIFIED="1529055254564" TEXT="You could have checked what in fact is configured in kernel,"/>
<node CREATED="1529055266415" ID="ID_965049379" MODIFIED="1529055267092" TEXT="# drbdsetup 0 show --show-defaults"/>
</node>
<node CREATED="1536117558291" ID="ID_1227179642" LINK="https://goo.gl/JPBsDK" MODIFIED="1536117571630" TEXT="make sure it never occures!">
<node CREATED="1536117668885" ID="ID_1334091887" MODIFIED="1536117669664" TEXT="have redundant communication paths"/>
</node>
</node>
<node CREATED="1529056740113" FOLDED="true" ID="ID_1782320508" MODIFIED="1536119448233" POSITION="left" TEXT="issues">
<node CREATED="1529056744548" ID="ID_355055661" MODIFIED="1529056745392" TEXT="NetworkFailure">
<node CREATED="1529056768459" ID="ID_509718948" LINK="https://goo.gl/efbtP4" MODIFIED="1529056780659" TEXT="the only possibilities are a flaky NIC or a flaky cable"/>
<node CREATED="1529393101971" ID="ID_1627172743" MODIFIED="1529393292451" TEXT="ko-count number"/>
</node>
<node CREATED="1529465264496" ID="ID_1376361496" MODIFIED="1529465266208" TEXT="Remote failed to finish a request within 42017ms &gt; ko-count (7) * timeout (60 * 0.1s) ">
<node CREATED="1529465988181" ID="ID_1081408952" MODIFIED="1529465990569" TEXT="default"/>
<node CREATED="1529465992797" ID="ID_270185337" MODIFIED="1529465994738" TEXT="8.4">
<node CREATED="1529465996257" ID="ID_1499217045" MODIFIED="1529465997852" TEXT="7"/>
</node>
<node CREATED="1529466000469" ID="ID_1750197522" MODIFIED="1529466003538" TEXT="0">
<node CREATED="1529466004937" ID="ID_925760694" MODIFIED="1529466009564" TEXT="hung for 3 minutes"/>
</node>
<node CREATED="1529466241182" ID="ID_924830134" MODIFIED="1529466243982" TEXT="8.4.3">
<node CREATED="1529466219395" ID="ID_1978773797" MODIFIED="1529466237552" TEXT="potential false hits at timeout detection"/>
</node>
<node CREATED="1529466625314" ID="ID_793475006" MODIFIED="1529466634960" TEXT="man 8 drbdsetup-8.4">
<node CREATED="1529466636288" ID="ID_879482370" MODIFIED="1529466641313" TEXT="--ko-count"/>
<node CREATED="1529466645038" ID="ID_1712261655" MODIFIED="1529466657626" TEXT="default may vary between versions"/>
<node CREATED="1529467439589" ID="ID_1711997879" MODIFIED="1529467448299" TEXT="standalone mode"/>
</node>
</node>
</node>
<node CREATED="1529466825331" ID="ID_462989531" MODIFIED="1529466832559" POSITION="left" TEXT="reload configuration">
<node CREATED="1529466927965" ID="ID_1171866186" MODIFIED="1529466939605" TEXT="drbdadm disconnect first"/>
<node CREATED="1529466941700" ID="ID_135371832" MODIFIED="1529466946910" TEXT="change both nodes"/>
<node CREATED="1529467980262" ID="ID_712199656" MODIFIED="1529467988354" TEXT="change a replication protocol"/>
</node>
</node>
</map>

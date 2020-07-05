<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1442282951765" ID="ID_482983392" LINK="../technologies.mm" MODIFIED="1518158664860" TEXT="High-availability cluster">
<node CREATED="1460686242416" ID="ID_932007722" LINK="../tatung.mm" MODIFIED="1460686253795" POSITION="right" TEXT="tatung"/>
<node CREATED="1444480132273" ID="ID_348916051" LINK="#ID_1438244703" MODIFIED="1444480142189" POSITION="right" TEXT="High-availability cluster"/>
<node CREATED="1489646348186" FOLDED="true" ID="ID_1155568577" MODIFIED="1493360593473" POSITION="left" TEXT="solutions">
<node CREATED="1445393926066" FOLDED="true" ID="ID_660329443" LINK="http://goo.gl/FbeiZB" MODIFIED="1489481944914" TEXT="RICCI cluster service">
<node CREATED="1489457765602" ID="ID_1356568606" LINK="https://goo.gl/oW8oA3" MODIFIED="1489457785473" TEXT="Remote Management System - Management Station"/>
<node CREATED="1489457769184" ID="ID_57274838" LINK="https://goo.gl/oW8oA3" MODIFIED="1489457789115" TEXT="centos5"/>
</node>
<node CREATED="1442286912828" FOLDED="true" ID="ID_597360549" MODIFIED="1492676357808" TEXT="Windows">
<node CREATED="1442282676160" MODIFIED="1442282677546" TEXT="Windows Failover Clustering"/>
<node CREATED="1442282728549" ID="ID_786541684" LINK="https://goo.gl/sDzVCx" MODIFIED="1442282741814" TEXT="Microsoft has three technologies for clustering"/>
<node CREATED="1442285688971" LINK="http://goo.gl/v25bt" MODIFIED="1442285717157" TEXT="Windows Server 2008 Failover Clustering"/>
<node CREATED="1442282758662" MODIFIED="1442282759571" TEXT="Microsoft Cluster Service (MSCS)"/>
<node CREATED="1489736231968" ID="ID_533733512" MODIFIED="1489736233716" TEXT="Windows Server Failover Clustering (WSFC)"/>
<node CREATED="1489736434216" FOLDED="true" ID="ID_167877396" MODIFIED="1490169522437" TEXT="wsfc licensing">
<node CREATED="1489736660784" ID="ID_6840633" LINK="https://goo.gl/vAOLqd" MODIFIED="1489736675710" TEXT="SQL Server Licensing &amp; Clustering for Always On"/>
</node>
</node>
<node CREATED="1489646369175" FOLDED="true" ID="ID_1346523100" LINK="#ID_1907468207" MODIFIED="1490169522438" TEXT="Linux-HA">
<node CREATED="1489736168655" ID="ID_1171718212" LINK="https://goo.gl/DB7Qxg" MODIFIED="1489736181422" TEXT="Introduction and Advantages/Disadvantages of Clustering in Linux"/>
</node>
</node>
<node CREATED="1442296253109" ID="ID_1907468207" LINK="https://goo.gl/wYpXjr" MODIFIED="1534144394842" POSITION="left" TEXT="Linux-HA">
<node CREATED="1457338016151" FOLDED="true" ID="ID_478321261" MODIFIED="1490169522441" TEXT="books">
<node CREATED="1457338027075" FOLDED="true" ID="ID_1340040277" LINK="https://goo.gl/zfFMjB" MODIFIED="1489647901824" TEXT="Pro Linux High Availability Clustering">
<node CREATED="1457338028957" ID="ID_913780293" MODIFIED="1457338042223" TEXT="Sander van Vugt"/>
</node>
<node CREATED="1457660927341" ID="ID_1378727793" LINK="http://goo.gl/ceiEeu" MODIFIED="1457660960299" TEXT="centos high availability"/>
</node>
<node CREATED="1457341919468" ID="ID_1099772213" LINK="http://goo.gl/gdZUT" MODIFIED="1458524811959" TEXT="Documentation"/>
<node CREATED="1457341177484" ID="ID_1533323950" MODIFIED="1534471688162" TEXT="subprojects">
<node CREATED="1457341183011" ID="ID_235655891" MODIFIED="1534497444720" TEXT="Cluster Glue">
<icon BUILTIN="help"/>
<node CREATED="1457341581692" ID="ID_1546288797" LINK="http://goo.gl/lWIff2" MODIFIED="1457341591122" TEXT="stack chart"/>
<node CREATED="1457341709292" ID="ID_594881483" MODIFIED="1457341710225" TEXT="Local Resource Manager (LRM)"/>
<node CREATED="1458037580942" ID="ID_3875697" LINK="https://goo.gl/EefYSI" MODIFIED="1458037610851" TEXT="possible to install cluster-glue from the network:ha-clustering:Stable repository on OBS"/>
<node CREATED="1458037655534" ID="ID_1388389199" LINK="http://goo.gl/yhSQTm" MODIFIED="1458037666680" TEXT="On Red Hat platforms, you install the cluster-glue and heartbeat packages with the YUM package manager. "/>
<node CREATED="1458038230711" ID="ID_643296785" LINK="https://goo.gl/LjFQTc" MODIFIED="1458038346368" TEXT="the cluster-glue package that was present in 6"/>
</node>
<node CREATED="1457341763364" FOLDED="true" ID="ID_184162845" LINK="http://goo.gl/qLONhD" MODIFIED="1518158664851" TEXT="Resource Agents ">
<node CREATED="1458027212818" ID="ID_2783560" MODIFIED="1458027213808" TEXT="Resource Agents"/>
<node CREATED="1458027247801" ID="ID_974581731" MODIFIED="1458027248503" TEXT="These are basically scripts"/>
<node CREATED="1458027268265" FOLDED="true" ID="ID_998102556" MODIFIED="1463383982124" TEXT="that wrap software that the cluster needs">
<node CREATED="1458027286433" ID="ID_546580787" MODIFIED="1458027287071" TEXT="to manage, providing a unified interface to configuration"/>
<node CREATED="1458027298193" ID="ID_1304297905" MODIFIED="1458027298759" TEXT="supervision and management of the software."/>
</node>
<node CREATED="1458184655615" ID="ID_460238605" LINK="https://goo.gl/SAa6bo" MODIFIED="1458184678194" TEXT="Every cluster resource is defined by a Resource Agent."/>
<node CREATED="1463379346432" ID="ID_865758076" LINK="http://goo.gl/N9HT2p" MODIFIED="1463379358396" TEXT="LSB Resource Agents are those found in /etc/init.d"/>
<node CREATED="1486103029289" FOLDED="true" ID="ID_853275426" MODIFIED="1510207408994" TEXT="LSB">
<node CREATED="1486103304503" ID="ID_479402951" LINK="https://goo.gl/tyZuCn" MODIFIED="1486103333051" TEXT="LSB &#x5373; Linux &#x6807;&#x51c6;&#x670d;&#x52a1;"/>
<node CREATED="1486714672092" ID="ID_188333277" LINK="https://goo.gl/N9HT2p" MODIFIED="1486714687003" TEXT="LSB Resource Agents"/>
<node CREATED="1487675412053" ID="ID_1183286042" LINK="https://goo.gl/N9HT2p" MODIFIED="1487675430307" TEXT="LSB Resource Agents"/>
<node CREATED="1503303744774" FOLDED="true" ID="ID_1103204156" LINK="https://goo.gl/N9HT2p" MODIFIED="1518158664840" TEXT="Compatibility Checks">
<icon BUILTIN="info"/>
<node CREATED="1503303812844" ID="ID_1145481412" LINK="https://goo.gl/SxUpDc" MODIFIED="1503303826504" TEXT="The LSB Spec"/>
<node CREATED="1503457709689" ID="ID_876002967" LINK="https://goo.gl/2yJe13" MODIFIED="1503457722769" TEXT="Init Script Actions">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1503303951595" ID="ID_132018997" LINK="https://goo.gl/qwMWXQ" MODIFIED="1503303963016" TEXT="Restart of resources"/>
<node CREATED="1503303889499" FOLDED="true" ID="ID_1130050611" MODIFIED="1518158664841" TEXT="restart">
<node CREATED="1503303894611" ID="ID_1599967363" LINK="https://goo.gl/Vnh5YW" MODIFIED="1503303929325" TEXT="That depends entirely on the exit codes returned by the RA."/>
<node CREATED="1503303908523" ID="ID_1639868891" LINK="https://goo.gl/Vnh5YW" MODIFIED="1503303931298" TEXT="Did you check the Resource agents developers guide?"/>
<node CREATED="1503303918210" ID="ID_878417525" LINK="https://goo.gl/Vnh5YW" MODIFIED="1503303933137" TEXT="This seems to be your own, right? "/>
</node>
</node>
<node CREATED="1486351836842" FOLDED="true" ID="ID_445126194" MODIFIED="1488961488499" TEXT="The OCF Resource Agent Developer&#x2019;s Guide  ">
<node CREATED="1486350927272" FOLDED="true" ID="ID_79075589" LINK="https://goo.gl/aGxpeO" MODIFIED="1488961488499" TEXT="Testing resource agents">
<node CREATED="1486350986378" ID="ID_1379536424" MODIFIED="1486350988775" TEXT="ocft"/>
</node>
<node CREATED="1486118930569" ID="ID_936668656" LINK="https://goo.gl/zbzrwZ" MODIFIED="1486118950623" TEXT="11. Installing and packaging resource agents"/>
</node>
<node CREATED="1486714655722" FOLDED="true" ID="ID_781713947" MODIFIED="1518158664851" TEXT="OCF">
<node CREATED="1487728401355" ID="ID_909497675" LINK="https://goo.gl/soRsrW" MODIFIED="1487728417459" TEXT="B.4. OCF Return Codes"/>
<node CREATED="1484216196948" FOLDED="true" ID="ID_1530577258" LINK="https://goo.gl/7yP8jT" MODIFIED="1518158664850" TEXT="symlink">
<node CREATED="1492673246674" ID="ID_1326411765" LINK="https://goo.gl/yh91Jw" MODIFIED="1492673256254" TEXT="man page"/>
<node CREATED="1492670020777" FOLDED="true" ID="ID_1455629870" LINK="https://goo.gl/vTz9NB" MODIFIED="1518158664847" TEXT="ocf_heartbeat_symlink man page">
<node CREATED="1492677423227" ID="ID_704770693" MODIFIED="1492677423977" TEXT="It is primarily intended to manage configuration files which should be enabled or disabled"/>
</node>
<node CREATED="1492670642026" FOLDED="true" ID="ID_1663977467" LINK="https://goo.gl/qUPfFy" MODIFIED="1518158664849" TEXT="Managing cron jobs with Pacemaker">
<node CREATED="1492670690114" ID="ID_525838195" MODIFIED="1492670690790" TEXT="only on the node that also is currently the active Postfix host"/>
</node>
<node CREATED="1510206404543" ID="ID_1029526901" LINK="https://goo.gl/PfZXM3" MODIFIED="1510206419216" TEXT="ocf_heartbeat_symlink"/>
</node>
</node>
</node>
<node CREATED="1486118989167" ID="ID_1027277797" LINK="https://goo.gl/GCSomX" MODIFIED="1486119002715" TEXT="clusterlab github"/>
</node>
<node CREATED="1460102682781" ID="ID_469855528" MODIFIED="1460102685565" TEXT="articles"/>
<node CREATED="1460102702293" ID="ID_1276628523" MODIFIED="1534474768414" TEXT="issues">
<node CREATED="1444484043997" ID="ID_662497889" MODIFIED="1444484052476" TEXT="nfs / partition"/>
<node CREATED="1444189045072" ID="ID_1506006725" MODIFIED="1444189065262" TEXT="rsync to secondary server">
<icon BUILTIN="idea"/>
<icon BUILTIN="help"/>
</node>
<node CREATED="1444647309431" ID="ID_659461248" LINK="http://goo.gl/MBfxWB" MODIFIED="1444647331619" TEXT="FAST FAILOVER CONFIGURATION WITH DRBD AND HEARTBEAT"/>
<node CREATED="1444702889336" ID="ID_902083354" MODIFIED="1444702905269" TEXT="unicast vs. multicast">
<icon BUILTIN="help"/>
</node>
<node CREATED="1444703597112" ID="ID_1326850853" MODIFIED="1444703604913" TEXT="number of machine">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1457342174084" ID="ID_1252047359" MODIFIED="1536052724660" TEXT="whole idea">
<node CREATED="1489648670515" FOLDED="true" ID="ID_1070294363" MODIFIED="1490169522442" TEXT="cluster">
<node CREATED="1489648695471" ID="ID_67028485" LINK="https://goo.gl/20VJlo" MODIFIED="1489648712773" TEXT="is a voting algorithm used by CMAN"/>
</node>
<node CREATED="1457339869224" FOLDED="true" ID="ID_113647108" MODIFIED="1484648763291" TEXT="failover">
<icon BUILTIN="idea"/>
<node CREATED="1457341012724" ID="ID_467138770" LINK="#ID_925730373" MODIFIED="1457341021163" TEXT="Heartbeat"/>
<node CREATED="1457340976252" ID="ID_335667441" LINK="#ID_881918740" MODIFIED="1457340982831" TEXT="CoroSync"/>
</node>
<node CREATED="1458194110531" ID="ID_1878945627" LINK="http://goo.gl/UXLxRD" MODIFIED="1458194125902" TEXT="ordering"/>
<node CREATED="1489375952688" ID="ID_266527840" MODIFIED="1536114458713" TEXT="fencing">
<node CREATED="1489567024154" FOLDED="true" ID="ID_1252562304" LINK="https://goo.gl/E8KPyC" MODIFIED="1490169522443" TEXT="concept">
<node CREATED="1489647509865" FOLDED="true" ID="ID_1365206136" LINK="https://goo.gl/BAwgli" MODIFIED="1490169522442" TEXT="is the only 100% reliable way">
<node CREATED="1489647545151" ID="ID_1784623290" LINK="https://goo.gl/BAwgli" MODIFIED="1489647563142" TEXT=" to ensure the integrity of your data"/>
<node CREATED="1489647527607" ID="ID_720757463" LINK="https://goo.gl/BAwgli" MODIFIED="1489647565264" TEXT="and that applications are only active on one host. "/>
</node>
<node CREATED="1489651807270" ID="ID_1042717441" LINK="https://goo.gl/6j40QK" MODIFIED="1489651831480" TEXT="is for *other* surviving nodes to ensure known state of suspected node."/>
</node>
<node CREATED="1489049404832" ID="ID_871321831" MODIFIED="1536114459913" TEXT="level">
<node CREATED="1457345034621" ID="ID_86262313" MODIFIED="1536114461143" TEXT="node">
<node CREATED="1457345688821" ID="ID_1441159180" LINK="https://goo.gl/fQcyc3" MODIFIED="1457345737241" TEXT="fenced, when notified of the failure, fences the failed node."/>
<node CREATED="1488880021373" FOLDED="true" ID="ID_1151011477" LINK="https://goo.gl/cXsq0g" MODIFIED="1488961488523" TEXT="Don&apos;t disable fencing!">
<node CREATED="1488880091588" ID="ID_1726377491" MODIFIED="1488880099951" TEXT="then drbd will block when the peer is lost,"/>
<node CREATED="1488880101404" ID="ID_619865338" MODIFIED="1488880102097" TEXT=" call the fence handler and wait for pacemaker to report back"/>
</node>
<node CREATED="1488938551205" ID="ID_1203993132" MODIFIED="1488938613439" TEXT="domain">
<icon BUILTIN="help"/>
</node>
<node CREATED="1489050971307" FOLDED="true" ID="ID_1846799934" MODIFIED="1489481944916" TEXT="stonith">
<node CREATED="1489049544402" FOLDED="true" ID="ID_874548363" MODIFIED="1489376205406" TEXT="fencing device">
<node CREATED="1489050843227" ID="ID_1393654583" LINK="https://goo.gl/oXKtrp" MODIFIED="1489050855402" TEXT="General Properties"/>
</node>
<node CREATED="1489050980067" ID="ID_191199180" MODIFIED="1489050982759" TEXT="plugin"/>
<node CREATED="1489050610395" ID="ID_472174228" LINK="https://goo.gl/hJxVH4" MODIFIED="1489050625235" TEXT="B.2. Fencing Configuration"/>
<node CREATED="1489050661851" ID="ID_1762210204" LINK="https://goo.gl/t08llr" MODIFIED="1489050672440" TEXT="Chapter 4. Fencing: Configuring STONITH"/>
<node CREATED="1489051340675" ID="ID_616216842" MODIFIED="1489051341527" TEXT="stonith_admin"/>
<node CREATED="1489051873051" FOLDED="true" ID="ID_1489208362" MODIFIED="1489481944916" TEXT="configure">
<node CREATED="1489051879243" FOLDED="true" ID="ID_1961271179" MODIFIED="1489481944915" TEXT="multiple">
<node CREATED="1489051883579" FOLDED="true" ID="ID_95550655" LINK="https://goo.gl/iERjI0" MODIFIED="1489457758597" TEXT="Use IPMI as first fencing level">
<node CREATED="1489052079243" ID="ID_934493476" LINK="https://goo.gl/tBexRm" MODIFIED="1489053383849" TEXT="IPMI Basics">
<icon BUILTIN="help"/>
</node>
<node CREATED="1489052178196" ID="ID_1208956997" LINK="HPDL320eB120iRAID-centos6-dd.mm#ID_1651191484" MODIFIED="1489052244119" TEXT="HPDL320e support"/>
<node CREATED="1489384409572" ID="ID_507585418" LINK="../tux.mm#ID_270505688" MODIFIED="1489385108877" TEXT="linux ipmitool"/>
</node>
<node CREATED="1489051959339" FOLDED="true" ID="ID_894571707" MODIFIED="1489376205407" TEXT="Use PDUs as second fencing level">
<node CREATED="1489052083243" ID="ID_50290649" MODIFIED="1489052086128" TEXT="PDU"/>
</node>
</node>
</node>
</node>
<node CREATED="1489137933939" ID="ID_1960957982" LINK="https://goo.gl/Ar9Jrt" MODIFIED="1489137953562" TEXT="power fencing device"/>
</node>
<node CREATED="1489049415122" ID="ID_1976895219" MODIFIED="1489049417631" TEXT="resource"/>
</node>
<node CREATED="1489567563106" FOLDED="true" ID="ID_789313415" MODIFIED="1490169522444" TEXT="issues">
<node CREATED="1489385491715" FOLDED="true" ID="ID_1289874163" MODIFIED="1489481944918" TEXT="dual fencing">
<icon BUILTIN="help"/>
<node CREATED="1489463191426" FOLDED="true" ID="ID_1620367646" LINK="https://goo.gl/Wvo8CX" MODIFIED="1489481944918" TEXT="So in short">
<node CREATED="1489463206570" ID="ID_32411541" MODIFIED="1489463207438" TEXT="1. Pick a node you prefer to win, add &apos;delay=&quot;15&quot;&apos; to it&apos;s fence"/>
<node CREATED="1489463218586" ID="ID_574883006" MODIFIED="1489463219422" TEXT="2. Disable acpid. "/>
</node>
</node>
<node CREATED="1489462964621" FOLDED="true" ID="ID_1128367859" MODIFIED="1490169522443" TEXT="loop">
<node CREATED="1489462968690" ID="ID_1043111595" LINK="https://goo.gl/Wvo8CX" MODIFIED="1489462983610" TEXT="This scenario is very possible when IPMI fencing is used."/>
<node CREATED="1489568383243" ID="ID_1974412761" LINK="https://goo.gl/t0PU5j" MODIFIED="1489568395962" TEXT="The problem with  two node clusters and not using quorum"/>
<node CREATED="1489568460971" ID="ID_1253203010" LINK="https://goo.gl/t0PU5j" MODIFIED="1489568471746" TEXT="To avoid this, simple do not start pacemaker on boot."/>
</node>
<node CREATED="1489567584010" FOLDED="true" ID="ID_789605850" MODIFIED="1490169522443" TEXT="stonith deathmatch">
<node CREATED="1489735434139" ID="ID_1255385672" LINK="https://goo.gl/ePbsRe" MODIFIED="1489735449957" TEXT="how to diagnose stonith death match?"/>
</node>
<node CREATED="1457341487540" FOLDED="true" ID="ID_18759529" LINK="#ID_1506557979" MODIFIED="1490169522443" TEXT="split brain prevention">
<icon BUILTIN="help"/>
<node CREATED="1457341505998" ID="ID_137653057" LINK="#ID_850977873" MODIFIED="1457341511605" TEXT="fence agents"/>
<node CREATED="1457344359917" ID="ID_1384074123" LINK="#ID_1710130875" MODIFIED="1458198302835" TEXT="STONITH"/>
<node CREATED="1489567635347" ID="ID_124138295" LINK="https://goo.gl/1EKsrp" MODIFIED="1489567648247" TEXT="unable to communicate with each other"/>
</node>
<node CREATED="1489386223147" FOLDED="true" ID="ID_1966419001" LINK="https://goo.gl/Wvo8CX" MODIFIED="1489462960626" TEXT="How to avoid dual fencing">
<node CREATED="1489386254723" ID="ID_308957214" LINK="https://goo.gl/Wvo8CX" MODIFIED="1489386331959" TEXT="by setting different  delays on the two nodes"/>
<node CREATED="1489386298747" ID="ID_1929864611" LINK="https://goo.gl/Wvo8CX" MODIFIED="1489386333998" TEXT="so that one of them will fence before the  other "/>
<node CREATED="1489386312987" FOLDED="true" ID="ID_378121644" LINK="https://goo.gl/Wvo8CX" MODIFIED="1489457758625" TEXT="see the &quot;delay&quot; parameter">
<node CREATED="1489386363179" ID="ID_1145852803" MODIFIED="1489386363905" TEXT="I&apos;m currently setting the delays  at 5s and 15s, dual fencing does disappear"/>
</node>
<node CREATED="1489386421379" ID="ID_1066819177" MODIFIED="1489386422448" TEXT="Generally, you pick a node you prefer to  survive in this case"/>
</node>
</node>
<node CREATED="1489375852856" ID="ID_1675960049" LINK="https://goo.gl/3lK6CI" MODIFIED="1489375970843" TEXT=" is the process of locking resources away from a node whose status is uncertain"/>
<node CREATED="1489376930858" FOLDED="true" ID="ID_1540730801" MODIFIED="1489651848769" TEXT="device">
<node CREATED="1489376933434" ID="ID_329954542" LINK="https://goo.gl/EMai2p" MODIFIED="1489376943735" TEXT="&#x662f;&#x4e00;&#x7a2e;&#x53ef;&#x4ee5;&#x76f4;&#x63a5;&#x5c0d;&#x4f3a;&#x670d;&#x5668;&#x505a;&#x96fb;&#x6e90;Power ON/Power OFF&#x7684;&#x88dd;&#x7f6e;"/>
<node CREATED="1489470661853" FOLDED="true" ID="ID_1547451487" MODIFIED="1489481944917" TEXT="multiple">
<node CREATED="1489471599023" ID="ID_1597804110" LINK="https://goo.gl/iERjI0" MODIFIED="1489471670454" TEXT="Configure Multiple Fencing Devices Using pcs"/>
</node>
<node CREATED="1489471606662" ID="ID_1254175618" MODIFIED="1489471610042" TEXT="configure"/>
<node CREATED="1489571213744" ID="ID_1447136039" MODIFIED="1489571216460" TEXT="IPMI"/>
<node CREATED="1489571217216" ID="ID_816972768" MODIFIED="1489571218876" TEXT="PDU"/>
<node CREATED="1489571206857" FOLDED="true" ID="ID_1347305648" LINK="https://goo.gl/uhqEpe" MODIFIED="1490169522444" TEXT="Guest Fencing">
<node CREATED="1489572701360" ID="ID_1567907043" MODIFIED="1489572703461" TEXT="qemu"/>
</node>
<node CREATED="1489484097227" FOLDED="true" ID="ID_469109653" LINK="../tux/applications.mm" MODIFIED="1489563720970" TEXT="IPMI">
<node CREATED="1489476165216" ID="ID_1964194292" LINK="https://goo.gl/J0d7Yn" MODIFIED="1489476192157" TEXT="iLO4 fencing is setup using fence_ipmilan">
<icon BUILTIN="info"/>
</node>
<node CREATED="1489477733064" ID="ID_581204709" LINK="https://goo.gl/JxEEOA" MODIFIED="1489477781421" TEXT="Chapter 4, Configuring HP ILO Management Boards as Fencing Devices "/>
</node>
<node CREATED="1489643970205" ID="ID_1936691219" LINK="https://goo.gl/8HZ8LW" MODIFIED="1489643978086" TEXT="VM">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1489572803464" FOLDED="true" ID="ID_1938860424" MODIFIED="1490169522444" TEXT="agents">
<node CREATED="1489572808576" ID="ID_1128668395" LINK="https://goo.gl/vLyUdz" MODIFIED="1489572822495" TEXT="fence-virt"/>
</node>
<node CREATED="1489571406352" FOLDED="true" ID="ID_1670527202" LINK="https://goo.gl/6HigSq" MODIFIED="1490169522445" TEXT="4.1. Available STONITH (Fencing) Agents">
<node CREATED="1489571882936" FOLDED="true" ID="ID_484509129" LINK="https://goo.gl/ZXDG6z" MODIFIED="1490169522444" TEXT="fencevbox">
<node CREATED="1489643371998" ID="ID_1599929153" MODIFIED="1489643373099" TEXT="Vboxguest"/>
<node CREATED="1489643388374" ID="ID_452336802" MODIFIED="1489643389161" TEXT="Use VBoxManage console utility over ssh to reboot, on, off and get status of vboxguest"/>
</node>
<node CREATED="1489571916032" ID="ID_176600077" LINK="https://goo.gl/ZXDG6z" MODIFIED="1489571925540" TEXT="VirtualBox fencing and Red Hat Enterprise Linux Cluster Suite "/>
</node>
<node CREATED="1489385344020" FOLDED="true" ID="ID_1678423780" LINK="https://goo.gl/EMai2p" MODIFIED="1489481944917" TEXT="&#x5ba2;&#x6236;&#x901a;&#x5e38;&#x662f;&#x63a1;&#x8cfc;&#x672c;&#x8eab;&#x6709;&#x652f;&#x63f4;IPMI&#x7684;&#x4f3a;&#x670d;&#x5668;&#xff0c;&#x76f4;&#x63a5;&#x7528;&#x4f3a;&#x670d;&#x5668;IPMI&#x7684;&#x529f;&#x80fd;&#xff0c;&#x6216;&#x662f;&#x984d;&#x5916;&#x8cfc;&#x8cb7;IBM RSAII&#x5361;&#x6216;&#x662f;HP iLO&#x5361;">
<node CREATED="1489388527460" ID="ID_1177581503" LINK="https://community.hpe.com/t5/ProLiant-Servers-ML-DL-SL/IPMI-iLO-no-lan-channels-available/td-p/4625459" MODIFIED="1489388539515" TEXT="ipmitool bmc info&quot; shows the iLO interface"/>
</node>
<node CREATED="1489386027220" ID="ID_557577627" LINK="https://goo.gl/Wvo8CX" MODIFIED="1489386042169" TEXT="manual vs. auto"/>
<node CREATED="1489386462347" ID="ID_877188035" LINK="https://goo.gl/TjNLkB" MODIFIED="1489476090808" TEXT="pacemaker and pcs on Linux example, Fencing">
<icon BUILTIN="info"/>
</node>
<node CREATED="1489482219780" FOLDED="true" ID="ID_1546726056" LINK="https://goo.gl/Xpt8dM" MODIFIED="1489563720971" TEXT="you ALWAYS MUST FENCE a node">
<node CREATED="1489482229235" ID="ID_1605941479" LINK="https://goo.gl/Xpt8dM" MODIFIED="1489482245744" TEXT=" before you do administrative  requests on the remaining one. you did not. your fault"/>
</node>
<node CREATED="1489567368778" ID="ID_990470312" LINK="https://goo.gl/tkQvwu" MODIFIED="1534497440190" TEXT="Is &quot;Fencing&quot; the same as STONITH? ( Yes )">
<node CREATED="1489567428370" FOLDED="true" ID="ID_306453597" MODIFIED="1490169522445" TEXT="The Linux-HA&apos;s project used the term &quot;STONITH&quot;">
<node CREATED="1489567456242" ID="ID_1793044820" MODIFIED="1489567457727" TEXT="implies power fencing"/>
</node>
<node CREATED="1489567417051" ID="ID_1673177861" MODIFIED="1489567417711" TEXT="Red Hat&apos;s cluster stack used the term &quot;fencing&quot; for the same concept."/>
</node>
<node CREATED="1489568149306" FOLDED="true" ID="ID_1262797326" LINK="https://goo.gl/t0PU5j" MODIFIED="1490169522446" TEXT="Two-Nodes Cluster fencing : Best Practices">
<icon BUILTIN="info"/>
<node CREATED="1489568205525" ID="ID_1389609744" MODIFIED="1489568206215" TEXT="quorum can&apos;t be used."/>
<node CREATED="1489568288347" ID="ID_1410652222" MODIFIED="1489568289119" TEXT="In theory, the faster node will power off"/>
</node>
<node CREATED="1534144755026" ID="ID_1575062725" LINK="https://goo.gl/G8Xbt2" MODIFIED="1534144770778" TEXT="Resource integrity is ensured using fencing"/>
</node>
<node CREATED="1457339875027" ID="ID_108396586" MODIFIED="1534474766167" TEXT="data replication">
<icon BUILTIN="idea"/>
<node CREATED="1460102965636" ID="ID_518683794" LINK="#ID_1498675153" MODIFIED="1460102970225" TEXT="Let&#x2019;s start with DRBD Management on CentOS 6 guide!"/>
</node>
<node CREATED="1458812294674" FOLDED="true" ID="ID_992589307" MODIFIED="1463383982131" TEXT="active/passive vs. Active/Active">
<node CREATED="1458812149214" FOLDED="true" ID="ID_318802397" LINK="http://goo.gl/F6tBou" MODIFIED="1459326873811" TEXT="Active-Active high availability cluster">
<node CREATED="1458812179242" ID="ID_970875397" LINK="http://cdn2.hubspot.net/hubfs/26878/images/active_active_high_availability_cluster_load_balancer.png?t=1458563560549" MODIFIED="1458812201123" TEXT="good chart metaphor">
<icon BUILTIN="info"/>
</node>
<node CREATED="1458812151427" ID="ID_505635026" MODIFIED="1458812156960" TEXT="load balance"/>
</node>
<node CREATED="1458808775696" FOLDED="true" ID="ID_1496601735" LINK="http://goo.gl/VLSbd6" MODIFIED="1459326873811" TEXT="Differences Between Active-active and Active-passive Cluster">
<node CREATED="1458808828169" ID="ID_416050707" LINK="#ID_1496601735" MODIFIED="1458808834263" TEXT="Differences Between Active-active and Active-passive Cluster"/>
</node>
<node CREATED="1458812339786" FOLDED="true" ID="ID_176233180" LINK="http://goo.gl/VLSbd6" MODIFIED="1459326873812" TEXT="with respect to">
<node CREATED="1458812304025" ID="ID_1573832362" MODIFIED="1458812305649" TEXT="setup"/>
<node CREATED="1458812314938" ID="ID_825806190" MODIFIED="1458812315689" TEXT="Failover"/>
<node CREATED="1458812326084" ID="ID_108701357" MODIFIED="1458812326791" TEXT="Failback"/>
<node CREATED="1458812338091" ID="ID_1718008572" MODIFIED="1458812338823" TEXT="Client connection failover"/>
</node>
<node CREATED="1463383313545" ID="ID_1881834821" LINK="#ID_987617484" MODIFIED="1463383319301" TEXT="Active/Passive Cluster with Pacemaker, Corosync"/>
</node>
<node CREATED="1445502616997" FOLDED="true" ID="ID_44852858" MODIFIED="1493360593475" TEXT="notify when failover switching">
<icon BUILTIN="help"/>
<icon BUILTIN="idea"/>
<node CREATED="1445502627045" ID="ID_818358499" MODIFIED="1445502632551" TEXT="nagios">
<icon BUILTIN="help"/>
</node>
<node CREATED="1445538204344" FOLDED="true" ID="ID_1317563160" MODIFIED="1492670575327" TEXT="crm">
<node CREATED="1492669901898" ID="ID_1183900647" MODIFIED="1492669906334" TEXT="crm shell"/>
</node>
<node CREATED="1445538207593" ID="ID_825905950" MODIFIED="1445538214283" TEXT="GUI">
<icon BUILTIN="help"/>
</node>
<node CREATED="1458812234794" FOLDED="true" ID="ID_1555594191" MODIFIED="1459326873814" TEXT="hook?">
<node CREATED="1458812239819" ID="ID_781270659" MODIFIED="1458812241464" TEXT="email"/>
<node CREATED="1458871667355" FOLDED="true" ID="ID_650122910" LINK="https://goo.gl/zr2W2D" MODIFIED="1459326873813" TEXT="Corosync Pacemaker - Execute script on failover">
<node CREATED="1458871646148" ID="ID_97911843" MODIFIED="1458871647268" TEXT="/usr/lib/ocf/"/>
<node CREATED="1458871695563" ID="ID_1740484886" MODIFIED="1458871715903" TEXT="understanding directory structure?">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1458872233811" FOLDED="true" ID="ID_742347602" MODIFIED="1459326873814" TEXT="failover switching">
<node CREATED="1458872282947" ID="ID_1661469801" LINK="http://goo.gl/xZtYVP" MODIFIED="1458872352235" TEXT="The RedHat doc is terse, "/>
<node CREATED="1458872296243" ID="ID_1599614685" LINK="http://goo.gl/qmFOvF" MODIFIED="1458872624327" TEXT="but Florian&apos;s blog entry is pretty detailed ">
<icon BUILTIN="info"/>
<icon BUILTIN="help"/>
</node>
<node CREATED="1458872307115" ID="ID_1547955405" MODIFIED="1458872308032" TEXT="and the references at the end are helpful."/>
</node>
</node>
<node CREATED="1459246210403" FOLDED="true" ID="ID_1219221486" LINK="#ID_781713947" MODIFIED="1489376031504" TEXT="OCF">
<icon BUILTIN="help"/>
<node CREATED="1458196053108" ID="ID_258366251" LINK="http://goo.gl/n1B208" MODIFIED="1458196067806" TEXT="OCFS2 and GFS2 cluster filesystems">
<icon BUILTIN="help"/>
</node>
<node CREATED="1459246173339" FOLDED="true" ID="ID_1168554956" LINK="#ID_1033133020" MODIFIED="1487225381118" TEXT="OCF Resource Agents">
<icon BUILTIN="help"/>
<node CREATED="1486103753655" ID="ID_1559473813" LINK="https://goo.gl/vTyIKj" MODIFIED="1486103771919" TEXT="Writing your own OCF Resource Agent mini Howto"/>
<node CREATED="1486103885591" ID="ID_1380770773" LINK="https://goo.gl/5FqGeZ" MODIFIED="1486103899887" TEXT="are those found in /usr/lib/ocf/resource.d/provider"/>
<node CREATED="1486108954266" FOLDED="true" ID="ID_392944939" MODIFIED="1486692992697" TEXT="OCF Resource Agents">
<node CREATED="1486108967738" ID="ID_12863779" LINK="https://goo.gl/5FqGeZ" MODIFIED="1486108981391" TEXT="are required to have these actions"/>
<node CREATED="1486108996554" ID="ID_1928159062" LINK="https://goo.gl/5FqGeZ" MODIFIED="1486109004178" TEXT="should support the following action"/>
</node>
<node CREATED="1486692998914" ID="ID_1449700224" MODIFIED="1486693000149" TEXT="parameters"/>
<node CREATED="1486352020731" FOLDED="true" ID="ID_1061416821" LINK="https://goo.gl/edNQwL" MODIFIED="1488961488531" TEXT="vsftpd">
<node CREATED="1486351960365" ID="ID_1806308783" LINK="https://goo.gl/0HyZme" MODIFIED="1486351973926" TEXT="Pacemaker - Cluster Configuration for Vsftpd"/>
<node CREATED="1486352017522" ID="ID_1683296459" LINK="https://goo.gl/bxyJnw" MODIFIED="1486352045616" TEXT="Pacemaker: vsftpd cluster (lsb init script) "/>
<node CREATED="1486352225402" ID="ID_383206255" LINK="https://goo.gl/8pfvZU" MODIFIED="1486352238011" TEXT="Pacemaker Cluster Web server Project RHEL 6.0"/>
</node>
</node>
<node CREATED="1463125637343" ID="ID_71515387" LINK="http://goo.gl/A3oGDg" MODIFIED="1463125649238" TEXT="9. Convert Cluster to Active/Active"/>
<node CREATED="1484128538985" FOLDED="true" ID="ID_1895498680" MODIFIED="1488961488531" TEXT="Open Cluster Framework (OCF)">
<node CREATED="1484128551014" ID="ID_1767258608" LINK="https://goo.gl/YbAhG1" MODIFIED="1484128561563" TEXT="Pacemaker &#x2013; Cluster Resource Agents Overview"/>
</node>
<node CREATED="1486103318877" ID="ID_800114748" LINK="https://goo.gl/tyZuCn" MODIFIED="1486103329299" TEXT="OCF &#x5b9e;&#x9645;&#x4e0a;&#x662f;&#x5bf9; LSB &#x670d;&#x52a1;&#x7684;&#x6269;&#x5c55;"/>
<node CREATED="1487230769626" FOLDED="true" ID="ID_920005895" LINK="https://goo.gl/1QLzg8" MODIFIED="1488961488532" TEXT="10. Testing resource agents  ">
<node CREATED="1487230811562" FOLDED="true" ID="ID_1385012668" LINK="https://goo.gl/qVWK15" MODIFIED="1488961488532" TEXT="ocf-tester">
<node CREATED="1487231080586" ID="ID_1434653203" LINK="https://goo.gl/i3EIMu" MODIFIED="1487231084392" TEXT="man 8"/>
</node>
<node CREATED="1487231013306" FOLDED="true" ID="ID_177164314" LINK="https://goo.gl/aGxpeO" MODIFIED="1487656250909" TEXT="10.2. Testing with ocft">
<node CREATED="1487237550486" ID="ID_718746436" MODIFIED="1487237551257" TEXT="main difference to ocf-tester is that ocft can automate creating complex testing environment"/>
</node>
</node>
<node CREATED="1487237785421" FOLDED="true" ID="ID_70835922" LINK="https://goo.gl/q3Rgl7" MODIFIED="1488961488532" TEXT="Writing OCF Resource Agents">
<node CREATED="1487237827141" ID="ID_1747152078" LINK="https://goo.gl/soRsrW" MODIFIED="1487237837775" TEXT="B.4. OCF Return Codes"/>
</node>
<node CREATED="1487315035505" FOLDED="true" ID="ID_1046064718" LINK="https://goo.gl/zbzrwZ" MODIFIED="1488961488533" TEXT="installing ocf RA">
<node CREATED="1487315068329" ID="ID_628035019" MODIFIED="1487315069030" TEXT="it is not installed on this system"/>
<node CREATED="1487576609673" ID="ID_670950215" LINK="https://goo.gl/8p9NAK" MODIFIED="1487576624369" TEXT="11.2. Packaging resource agents"/>
<node CREATED="1487315045769" ID="ID_66007978" LINK="../tux/centos.mm#ID_718569773" MODIFIED="1487552790039" TEXT="RPM packaging"/>
</node>
<node CREATED="1487575528249" ID="ID_1078262497" LINK="https://goo.gl/H5LddJ" MODIFIED="1487575546061" TEXT="regrading pacemaker integration with user application"/>
</node>
<node CREATED="1463129871622" ID="ID_631045463" MODIFIED="1536052732636" TEXT="cluster resource">
<node CREATED="1536052745817" ID="ID_1457744839" LINK="https://goo.gl/TAJb9q" MODIFIED="1536052763324" TEXT="operations"/>
<node CREATED="1457664095607" ID="ID_148511734" MODIFIED="1536052740235" TEXT="management">
<node CREATED="1458184720734" FOLDED="true" ID="ID_259127317" LINK="#ID_354408022" MODIFIED="1460360674397" TEXT="resources">
<node CREATED="1458184726853" ID="ID_89133567" LINK="https://goo.gl/SAa6bo" MODIFIED="1458184741348" TEXT="IP address"/>
<node CREATED="1458184759310" ID="ID_217231792" MODIFIED="1458184760155" TEXT="Apache (httpd) Resource"/>
<node CREATED="1458184776166" ID="ID_74520602" MODIFIED="1458184780339" TEXT="adding"/>
<node CREATED="1458184780710" ID="ID_851406601" MODIFIED="1458184783291" TEXT="deleting"/>
<node CREATED="1458199141541" ID="ID_513530805" LINK="http://goo.gl/2E3ef1" MODIFIED="1458199173699" TEXT="namespace"/>
<node CREATED="1458199150541" ID="ID_1888279777" LINK="http://goo.gl/2E3ef1" MODIFIED="1458199177089" TEXT="provider"/>
<node CREATED="1458199146509" ID="ID_1878467669" LINK="http://goo.gl/2E3ef1" MODIFIED="1458199179148" TEXT="script"/>
<node CREATED="1459247633820" ID="ID_1781953713" MODIFIED="1459247638234" TEXT="agent">
<icon BUILTIN="help"/>
</node>
<node CREATED="1460099941970" ID="ID_694819820" MODIFIED="1460099946702" TEXT="group">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1486102296023" ID="ID_1281630540" MODIFIED="1486102302115" TEXT="custom"/>
<node CREATED="1463129876886" ID="ID_395281467" LINK="#ID_184162845" MODIFIED="1463129921963" TEXT="Resource Agent"/>
<node CREATED="1486102327808" FOLDED="true" ID="ID_741378140" MODIFIED="1486105908376" TEXT="constraint">
<node CREATED="1458194081788" FOLDED="true" ID="ID_1122522495" LINK="http://goo.gl/94fq9D" MODIFIED="1459326873807" TEXT="colocation">
<node CREATED="1459317372880" ID="ID_533835262" LINK="https://goo.gl/iR2pvn" MODIFIED="1459317384006" TEXT="determines that the location of one resource depends on the location of another resource."/>
</node>
</node>
<node CREATED="1486113971123" FOLDED="true" ID="ID_695642370" LINK="https://goo.gl/NfvGU6" MODIFIED="1488961488540" TEXT="classes">
<node CREATED="1487231114634" ID="ID_1504040139" LINK="https://goo.gl/plL3ht" MODIFIED="1487231125428" TEXT="5.2. Resource Classes"/>
</node>
<node CREATED="1486115855845" ID="ID_1057917297" LINK="https://goo.gl/NfvGU6" MODIFIED="1486115859760" TEXT="types"/>
<node CREATED="1487225435786" ID="ID_381230096" MODIFIED="1487225438268" TEXT="provider"/>
<node CREATED="1487225441047" FOLDED="true" ID="ID_701581269" LINK="https://goo.gl/DFPB9F" MODIFIED="1492669910981" TEXT="Dummy">
<node CREATED="1487225451344" FOLDED="true" ID="ID_1105968375" LINK="https://goo.gl/zr2W2D" MODIFIED="1492669910979" TEXT="Corosync Pacemaker - Execute script on failover">
<icon BUILTIN="info"/>
<node CREATED="1487225474983" ID="ID_162486338" MODIFIED="1487225475691" TEXT="This tutorial describes how to change the Dummy OCF resource to execute a script on failover"/>
<node CREATED="1487230731819" ID="ID_220225596" MODIFIED="1487230732640" TEXT="Test the script using the ocf-tester program to see if you have any mistakes"/>
<node CREATED="1487656266403" ID="ID_96525717" MODIFIED="1487656291515" TEXT="did not mentioning how to create a RA, but a hook">
<icon BUILTIN="idea"/>
</node>
<node CREATED="1487656377671" ID="ID_199193060" MODIFIED="1487657631047" TEXT="added by CRM"/>
</node>
<node CREATED="1487225535703" ID="ID_1775782875" MODIFIED="1487225536588" TEXT="Example stateless resource agent"/>
<node CREATED="1487576280201" ID="ID_1546336155" LINK="https://goo.gl/H5LddJ" MODIFIED="1487576291606" TEXT=" pacemaker integration with user application"/>
<node CREATED="1487657646671" FOLDED="true" ID="ID_869384728" MODIFIED="1488961488548" TEXT="encoding issue">
<icon BUILTIN="help"/>
<node CREATED="1487657773943" ID="ID_1450351353" MODIFIED="1487657775253" TEXT="scp"/>
<node CREATED="1487657771605" ID="ID_1417718744" LINK="https://goo.gl/pgSQNT" MODIFIED="1487657788556" TEXT="ISO-8859-1 as default file encoding and the target system uses UTF-8 as file encoding. "/>
</node>
</node>
<node CREATED="1487225596615" FOLDED="true" ID="ID_574751223" LINK="https://goo.gl/DQ5qlX" MODIFIED="1487649369351" TEXT="ClusterMon">
<node CREATED="1487317036515" ID="ID_1441130903" LINK="https://goo.gl/I38q2K" MODIFIED="1487317052445" TEXT="configuring Notifications via External-Agent adding external script"/>
<node CREATED="1487317192786" FOLDED="true" ID="ID_242217005" LINK="https://goo.gl/kcxfUs" MODIFIED="1488961488549" TEXT="configure Event Notification with Monitoring Resources using External Agent">
<node CREATED="1487317239274" FOLDED="true" ID="ID_707115178" LINK="https://goo.gl/ubEugn" MODIFIED="1488961488548" TEXT="&#x2060;8.3. Event Notification with Monitoring Resources">
<node CREATED="1487317301402" ID="ID_130063959" LINK="#ID_279865636" MODIFIED="1487317316816" TEXT="ocf:pacemaker:ClusterMon"/>
</node>
<node CREATED="1487317613658" ID="ID_211420647" MODIFIED="1487317617014" TEXT="pcs example"/>
</node>
<node CREATED="1487318567906" ID="ID_1337551680" LINK="https://goo.gl/cHNFdH" MODIFIED="1487318580947" TEXT="Configure ClusterMon - Event Notifications"/>
</node>
<node CREATED="1487317307666" FOLDED="true" ID="ID_279865636" MODIFIED="1488961488555" TEXT="ocf:pacemaker:ClusterMon">
<node CREATED="1487319804699" FOLDED="true" ID="ID_378729653" LINK="https://goo.gl/cHNFdH" MODIFIED="1488961488553" TEXT="example">
<node CREATED="1487320308315" ID="ID_299880269" MODIFIED="1487320310063" TEXT="email"/>
</node>
</node>
<node CREATED="1487318946754" FOLDED="true" ID="ID_1690845830" LINK="https://goo.gl/8xUhvp" MODIFIED="1492669908178" TEXT="pcs property set notification-agent">
<icon BUILTIN="info"/>
<node CREATED="1487319536843" ID="ID_545678862" MODIFIED="1487319537696" TEXT="When Pacemaker 1.1.14 arrives"/>
<node CREATED="1487319564035" ID="ID_794210812" MODIFIED="1487319565015" TEXT="rpm -qa|grep -i pacemaker "/>
<node CREATED="1487319605731" ID="ID_766030726" MODIFIED="1487319606399" TEXT="crmadmin --version"/>
</node>
<node CREATED="1488938980111" ID="ID_316142537" MODIFIED="1488938989223" TEXT="stickiness">
<icon BUILTIN="help"/>
</node>
<node CREATED="1489129533310" FOLDED="true" ID="ID_1936169563" LINK="https://goo.gl/bAq2Uj" MODIFIED="1489137207910" TEXT="ocf:pacemaker:ping RA">
<node CREATED="1489129544032" ID="ID_1867468402" LINK="https://goo.gl/WJn50p" MODIFIED="1489129594547" TEXT=" was designed precisely to failover a node over upon loss of connectivity. "/>
<node CREATED="1489129610719" ID="ID_634924556" MODIFIED="1489129611308" TEXT="only if it a 100% connectivity loss. "/>
<node CREATED="1489129630327" ID="ID_481060474" MODIFIED="1489129637227" TEXT="But when i only ~50% packet loss - it works awful -"/>
<node CREATED="1489129638255" ID="ID_649546811" MODIFIED="1489129638964" TEXT=" pacemaker change active node about 5 times a minute. "/>
<node CREATED="1489130917920" ID="ID_1355451812" LINK="https://goo.gl/SwB0FB" MODIFIED="1489133891089" TEXT="Migrate resources depending on ocf:pacemaker:ping RA with Pacemaker">
<icon BUILTIN="info"/>
</node>
<node CREATED="1489131070056" ID="ID_1390522487" LINK="https://goo.gl/VD4b2F" MODIFIED="1489131082061" TEXT="Tell Pacemaker to monitor connectivity"/>
<node CREATED="1489131450680" ID="ID_1523531311" LINK="https://goo.gl/R1nTp0" MODIFIED="1489131456542" TEXT="configuration"/>
<node CREATED="1489136278348" ID="ID_63377176" LINK="https://goo.gl/g6DL0B" MODIFIED="1489136290119" TEXT="clusterlab git">
<icon BUILTIN="info"/>
</node>
<node CREATED="1489136313051" ID="ID_1483583727" LINK="https://goo.gl/BgP09j" MODIFIED="1489136318488" TEXT="pcs example"/>
</node>
<node CREATED="1489129722992" FOLDED="true" ID="ID_451443273" LINK="https://goo.gl/5KQztF" MODIFIED="1489376205409" TEXT="ocf_heartbeat_IPaddr">
<node CREATED="1489130993024" ID="ID_190222814" MODIFIED="1489130996512" TEXT="local_stop_script">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1490169575720" FOLDED="true" ID="ID_1239008545" MODIFIED="1490252212944" TEXT="migration">
<node CREATED="1490170143263" ID="ID_163487173" LINK="https://goo.gl/kR3sJz" MODIFIED="1490170159797" TEXT="uses moving instead of migrating"/>
</node>
<node CREATED="1492669158849" ID="ID_1921499128" LINK="https://goo.gl/Wst5co" MODIFIED="1492669252926" TEXT="Clones - Resources That Get Active on Multiple Hosts&#x201d; "/>
</node>
<node CREATED="1486102068602" FOLDED="true" ID="ID_881966296" LINK="#ID_1506557979" MODIFIED="1490252212977" TEXT="split-brain">
<node CREATED="1490237793833" ID="ID_1568699778" LINK="https://goo.gl/RW0Epz" MODIFIED="1490237815158" TEXT="aka cluster partition"/>
<node CREATED="1486102092304" FOLDED="true" ID="ID_20028855" MODIFIED="1490169522446" TEXT="quorum">
<node CREATED="1489376503666" ID="ID_1961951831" LINK="https://goo.gl/EMai2p" MODIFIED="1489376523577" TEXT="Red Hat&#x53ef;&#x5229;&#x7528;quorum disk&#x7684;&#x6280;&#x8853;&#x4f86;&#x89e3;&#x6c7a;&#x9019;&#x500b;&#x554f;&#x984c;"/>
<node CREATED="1489648386584" ID="ID_1315422745" MODIFIED="1489648389316" TEXT="policy"/>
<node CREATED="1489649501416" ID="ID_1490638143" LINK="https://goo.gl/20VJlo" MODIFIED="1489649530397" TEXT="doesn&apos;t prevent split-brain situations"/>
</node>
<node CREATED="1486102097375" FOLDED="true" ID="ID_1903133237" MODIFIED="1486105908377" TEXT="recovery">
<node CREATED="1486102103231" ID="ID_335617828" MODIFIED="1486102106355" TEXT="policy"/>
<node CREATED="1486102140095" ID="ID_1946238951" LINK="https://goo.gl/zJVLwE" MODIFIED="1486102152206" TEXT="6.17.2. Automatic split brain recovery policies"/>
</node>
</node>
<node CREATED="1486721247277" FOLDED="true" ID="ID_997644154" LINK="../freeswitch.mm" MODIFIED="1487649373939" TEXT="freeswitch">
<node CREATED="1486721236195" ID="ID_609518598" LINK="#ID_997644154" MODIFIED="1486721258314" TEXT="freeswitch"/>
<node CREATED="1486721157357" FOLDED="true" ID="ID_1797195561" LINK="https://goo.gl/ItGVEf" MODIFIED="1488961488567" TEXT="Enterprise deployment IP Failover - FreeSWITCH Wiki">
<node CREATED="1486723417727" ID="ID_158389320" MODIFIED="1486723418850" TEXT="HeartBeat/Pacemaker"/>
</node>
<node CREATED="1486721216190" FOLDED="true" ID="ID_1530851031" LINK="https://goo.gl/hgmMnL" MODIFIED="1488961488567" TEXT="how to configure FreeSWITCH in an active-passive schema">
<node CREATED="1486723364842" ID="ID_603789900" MODIFIED="1486723365803" TEXT="Corosync and Pacemaker"/>
<node CREATED="1486723570646" ID="ID_1000504395" MODIFIED="1486723573051" TEXT="add tracking call to your FreeSWITCH profiles"/>
</node>
</node>
<node CREATED="1489110928394" FOLDED="true" ID="ID_909835868" MODIFIED="1489377542229" TEXT="node">
<node CREATED="1489110931831" FOLDED="true" ID="ID_769867211" MODIFIED="1489376205409" TEXT="state">
<node CREATED="1489110935023" ID="ID_1976407451" MODIFIED="1489110936995" TEXT="clean"/>
<node CREATED="1489110937551" ID="ID_1458813903" MODIFIED="1489110939443" TEXT="unclean"/>
</node>
</node>
<node CREATED="1489376216794" ID="ID_1105624372" LINK="https://goo.gl/EMai2p" MODIFIED="1489376230586" TEXT="RHCS&#x57fa;&#x672c;&#x7406;&#x8ad6;"/>
<node CREATED="1489376614465" ID="ID_1747304276" LINK="https://goo.gl/EMai2p" MODIFIED="1489376627673" TEXT="&#x300c;Failover Domain&#x300d;&#x5c31;&#x662f;Cluster&#x7684;&#x5b50;&#x96c6;(subset)"/>
<node CREATED="1489376630882" ID="ID_1076525870" MODIFIED="1489376636750" TEXT="failover domain"/>
<node CREATED="1489376861082" ID="ID_1628950015" LINK="https://goo.gl/EMai2p" MODIFIED="1489376872997" TEXT="&#x5728;RHCS&#x4e2d;&#x7684;Service&#x5176;&#x5be6;&#x662f;&#x4e00;&#x5806;Resource&#x7684;&#x7d44;&#x5408;&#x3002;"/>
<node CREATED="1489543657487" FOLDED="true" ID="ID_1053550166" MODIFIED="1489563720976" TEXT="resource agent">
<node CREATED="1489543663960" ID="ID_411328079" LINK="https://goo.gl/HcPLLD" MODIFIED="1489543705389" TEXT="A resource agent is the glue between pacemaker and your daemon"/>
</node>
<node CREATED="1490169544497" ID="ID_1696363289" MODIFIED="1518158718076" TEXT="cluster">
<node CREATED="1490169547735" ID="ID_15915717" LINK="https://goo.gl/27Jpam" MODIFIED="1490169562246" TEXT=" if it is active/active you can just bring one node to standby"/>
<node CREATED="1490169693344" ID="ID_1411146814" LINK="https://goo.gl/kR3sJz" MODIFIED="1490169720318" TEXT="If you have active/passive then it is easy for you,"/>
<node CREATED="1490169702776" ID="ID_1683294440" LINK="https://goo.gl/kR3sJz" MODIFIED="1490169722556" TEXT=" activate the second node and put in standby the first one"/>
<node CREATED="1518158719619" ID="ID_1657143072" MODIFIED="1518158723239" TEXT="events">
<node CREATED="1518158724121" ID="ID_1574001355" LINK="https://goo.gl/a1GSf6" MODIFIED="1518158742359" TEXT="TRIGGERING SCRIPTS FOR CLUSTER EVENTS"/>
<node CREATED="1518159493498" ID="ID_34128597" LINK="https://goo.gl/a1GSf6" MODIFIED="1518159516081" TEXT="ocf:pacemaker:ClusterMon"/>
</node>
</node>
<node CREATED="1491532207940" ID="ID_1636808133" MODIFIED="1518158695605" TEXT="resource manager">
<node CREATED="1491532111981" FOLDED="true" ID="ID_1305973014" LINK="https://goo.gl/ss2rDD" MODIFIED="1492670575328" TEXT="cibadmin">
<node CREATED="1491532172036" ID="ID_1257173106" MODIFIED="1491532173032" TEXT="Part of the Pacemaker cluster resource manager"/>
</node>
<node CREATED="1521438330916" ID="ID_1622577809" LINK="pacemaker.mm" MODIFIED="1521438330924" TEXT="Pacemaker"/>
</node>
</node>
<node CREATED="1457338657939" ID="ID_1724397720" MODIFIED="1534144394847" TEXT="survey">
<node CREATED="1444702419912" FOLDED="true" ID="ID_156601737" LINK="http://goo.gl/L38b8T" MODIFIED="1492669909172" TEXT="Alternatives to Heartbeat, Pacemaker and CoroSync?">
<icon BUILTIN="info"/>
<node CREATED="1442296344389" FOLDED="true" ID="ID_925730373" MODIFIED="1492669909170" TEXT="Heartbeat">
<node CREATED="1443708391053" LINK="https://goo.gl/kBhiWE" MODIFIED="1443708407367" TEXT="Installing and Configuring Openfiler with DRBD and Heartbeat">
<icon BUILTIN="help"/>
</node>
<node CREATED="1444702650256" LINK="http://goo.gl/WqgVvJ" MODIFIED="1444702663248" TEXT="limited to two nodes"/>
<node CREATED="1445278074994" LINK="http://goo.gl/DBWmPA" MODIFIED="1445278086532" TEXT="Creating an initial Heartbeat configuration"/>
<node CREATED="1445396094597" LINK="tux/centos.mm#ID_645429319" MODIFIED="1445396113342" TEXT="centos"/>
<node CREATED="1445508198280" FOLDED="true" ID="ID_621128162" LINK="http://goo.gl/3EwVAF" MODIFIED="1460098808665" TEXT="Heartbeat Pacemaker 3 node/ip failover">
<node CREATED="1445508176608" LINK="http://goo.gl/unaMtw" MODIFIED="1445508222072" TEXT="if heartbeat with more than 2 node is possible, "/>
<node CREATED="1445508184968" LINK="http://goo.gl/unaMtw" MODIFIED="1445508224525" TEXT="then I say heartbeat is not limited to 2 nodes we can join more than 2 nodes. "/>
</node>
<node CREATED="1457341080868" ID="ID_1655203255" LINK="http://goo.gl/SRseL" MODIFIED="1457341094436" TEXT="a daemon"/>
<node CREATED="1457341281532" FOLDED="true" ID="ID_100749966" LINK="https://goo.gl/Sxx9HN" MODIFIED="1460098808665" TEXT="google trend comparison - heartbeat vs. pacemaker">
<node CREATED="1457623237893" FOLDED="true" ID="ID_1626719730" LINK="http://goo.gl/uDMvvJ" MODIFIED="1460098808665" TEXT="Corosync vs Heartbeat ">
<node CREATED="1457623272787" ID="ID_1292346203" MODIFIED="1457623281360" TEXT="Which combination is good for a 2 node Active - Passive configuration?"/>
<node CREATED="1457623423981" ID="ID_1858109149" LINK="http://goo.gl/cAGnCf" MODIFIED="1457623450241" TEXT="Heartbeat is deprecated and no longer developed"/>
<node CREATED="1457623589002" ID="ID_804764689" LINK="http://goo.gl/GBzDJE" MODIFIED="1457623602199" TEXT="supports a few more features in Pacemaker then Heartbeat does not"/>
<node CREATED="1457623665393" ID="ID_1024668119" LINK="http://goo.gl/j25S5N" MODIFIED="1457623678371" TEXT="&quot;heartbeat&quot; was used for many different things"/>
</node>
</node>
<node CREATED="1457342043676" ID="ID_1731334036" LINK="https://goo.gl/6C2ppu" MODIFIED="1457342053666" TEXT="is typically used in conjunction with a cluster resource manager (CRM)"/>
</node>
<node CREATED="1457664066766" ID="ID_1903794366" LINK="#ID_1599849031" MODIFIED="1457664072630" TEXT="Pacemaker"/>
<node CREATED="1444702466456" FOLDED="true" ID="ID_888971428" LINK="http://goo.gl/imR9S9" MODIFIED="1460098808666" TEXT="keepalived">
<node CREATED="1444703121944" LINK="http://goo.gl/8cJKrH" MODIFIED="1444703407793" TEXT="a routing software written in C">
<icon BUILTIN="info"/>
</node>
<node CREATED="1444702772272" MODIFIED="1444702773654" TEXT="simpler to setup"/>
<node CREATED="1444702797000" MODIFIED="1444702797797" TEXT="doesn&apos;t have a unicast option by default"/>
<node CREATED="1444702959032" LINK="http://goo.gl/LPvwNM" MODIFIED="1444702989922" TEXT="Since release 1.2.8 (2013-08-05) Keepalived supports Unicast"/>
<node CREATED="1444703064200" LINK="https://goo.gl/vmPHRK" MODIFIED="1444703079321" TEXT="Introductory article">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1444702603064" FOLDED="true" ID="ID_711697714" MODIFIED="1460098808666" TEXT="HAProxy">
<icon BUILTIN="help"/>
<node CREATED="1444703022912" LINK="http://goo.gl/17AzVY" MODIFIED="1444703040193" TEXT="HAProxy + Heartbeat">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1444702618280" ID="ID_1119367305" MODIFIED="1444702619178" TEXT="Solr"/>
<node CREATED="1457338634676" ID="ID_1542633884" LINK="https://goo.gl/HhULcc" MODIFIED="1457338748513" TEXT="Oracle Cold Failover Cluster"/>
<node CREATED="1457338748859" ID="ID_11980262" LINK="http://goo.gl/xzrhpv" MODIFIED="1457338758658" TEXT="IBM PowerHA"/>
<node CREATED="1457340650803" ID="ID_999665140" MODIFIED="1457340652108" TEXT="HPE Serviceguard for Linux (SGLX)"/>
</node>
<node CREATED="1457342121700" FOLDED="true" ID="ID_690695686" LINK="https://goo.gl/6C2ppu" MODIFIED="1460098808669" TEXT="How To Create a High Availability Setup with Heartbeat and Floating IPs on Ubuntu 14.04">
<node CREATED="1457342304212" ID="ID_166925949" LINK="#ID_925730373" MODIFIED="1457342346422" TEXT="Heartbeat"/>
<node CREATED="1457342291372" ID="ID_1095494423" MODIFIED="1457342294947" TEXT="DigitalOcean Floating IP">
<icon BUILTIN="help"/>
</node>
<node CREATED="1457342362860" FOLDED="true" ID="ID_1145207943" MODIFIED="1460098808668" TEXT="more robust HA setup">
<node CREATED="1457342376564" ID="ID_505323099" LINK="#ID_1599849031" MODIFIED="1457342393665" TEXT="using Corosync and Pacemaker"/>
<node CREATED="1457342385868" ID="ID_1715160709" LINK="#ID_888971428" MODIFIED="1457342420593" TEXT="Keepalived"/>
</node>
<node CREATED="1457342478148" FOLDED="true" ID="ID_1303041722" MODIFIED="1460098808669" TEXT="strategy">
<node CREATED="1457342472789" ID="ID_986842892" MODIFIED="1457342473859" TEXT="active/passive configuration"/>
</node>
</node>
<node CREATED="1460100225819" ID="ID_1653533582" LINK="#ID_1599849031" MODIFIED="1460100251180" TEXT="Pacemaker"/>
<node CREATED="1444702397985" ID="ID_881918740" MODIFIED="1536716918579" TEXT="CoroSync">
<icon BUILTIN="button_ok"/>
<node CREATED="1444702712000" LINK="http://goo.gl/WqgVvJ" MODIFIED="1444702723621" TEXT="Does not support unicast"/>
<node CREATED="1444703476208" LINK="http://goo.gl/mROqOB" MODIFIED="1444703488468" TEXT="will run on multiple servers"/>
<node CREATED="1444703510472" ID="ID_1370753509" LINK="http://goo.gl/mROqOB" MODIFIED="1444703529765" TEXT="it does support Unicast (UDPU) as of version 1.3.0 (from Nov, 2010)"/>
<node CREATED="1457623718921" ID="ID_1418173387" LINK="http://goo.gl/j25S5N" MODIFIED="1457623744135" TEXT=" (formerly also known as  openais)"/>
<node CREATED="1458011403279" ID="ID_143639234" LINK="#ID_881918740" MODIFIED="1458011438671" TEXT="CoroSync"/>
<node CREATED="1458011411538" ID="ID_1537625593" LINK="https://goo.gl/MT69nK" MODIFIED="1534149921109" TEXT="/etc/corosync/corosync.conf">
<node CREATED="1458011539538" ID="ID_1734571590" LINK="http://goo.gl/k14OoI" MODIFIED="1458011580311" TEXT="compatibility"/>
<node CREATED="1458012319235" ID="ID_1703735272" MODIFIED="1458012322112" TEXT="aisexec">
<icon BUILTIN="help"/>
</node>
<node CREATED="1458012335011" ID="ID_262452519" MODIFIED="1458012376469" TEXT="service">
<icon BUILTIN="help"/>
</node>
<node CREATED="1458012393083" ID="ID_1592544691" MODIFIED="1534144400024" TEXT="totem">
<icon BUILTIN="help"/>
<node CREATED="1458012438954" ID="ID_606575077" MODIFIED="1458012443411" TEXT="protocol">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1458012530882" ID="ID_1446509322" MODIFIED="1458012537329" TEXT="logger_subsys"/>
<node CREATED="1458012545762" ID="ID_1907818354" MODIFIED="1458012550916" TEXT="amf">
<icon BUILTIN="help"/>
</node>
<node CREATED="1484102059242" ID="ID_1380132777" MODIFIED="1484102066702" TEXT="secauth"/>
<node CREATED="1534150230613" FOLDED="true" ID="ID_458607319" MODIFIED="1536744128800" TEXT="token">
<node CREATED="1534144402333" ID="ID_1541973090" LINK="https://goo.gl/MT69nK" MODIFIED="1534144502567" TEXT="totem token default"/>
<node CREATED="1534149932532" ID="ID_240455744" LINK="https://goo.gl/FfgZ6Y" MODIFIED="1534149945602" TEXT="&#x5176;&#x4ed6;&#x53c3;&#x8003;&#x8a2d;&#x5b9a;: 17000"/>
<node CREATED="1534149959821" ID="ID_1725112902" LINK="https://goo.gl/W2S1AJ" MODIFIED="1534149977755" TEXT="&#x5176;&#x4ed6;&#x53c3;&#x8003;&#x8a2d;&#x5b9a;: 3000"/>
<node CREATED="1534149996588" ID="ID_586099359" LINK="https://goo.gl/Qpe1Jv" MODIFIED="1534150024499" TEXT="If you observe too much lost tokens, try increase token"/>
</node>
<node CREATED="1534150132311" ID="ID_471043297" MODIFIED="1534150133236" TEXT="consensus">
<node CREATED="1534150171517" ID="ID_410500628" MODIFIED="1534150175183" TEXT="This value will be automatically calculated at 1.2 * token"/>
</node>
<node CREATED="1534150221837" ID="ID_498764613" MODIFIED="1534150222781" TEXT="join timeout"/>
<node CREATED="1534150334941" ID="ID_273284514" MODIFIED="1534150335941" TEXT="retransmits_before_loss_const">
<node CREATED="1534150367389" ID="ID_1071301763" MODIFIED="1534150368203" TEXT="4 retransmissions"/>
</node>
<node CREATED="1458012476850" ID="ID_1860401138" MODIFIED="1536716941593" TEXT="logging">
<node CREATED="1458012503874" ID="ID_1425152936" LINK="http://goo.gl/k14OoI" MODIFIED="1458012516015" TEXT="3 options">
<node CREATED="1536717024993" ID="ID_635346248" MODIFIED="1536717025968" TEXT="/var/log/corosync.log"/>
</node>
<node CREATED="1536716947519" ID="ID_1082568460" MODIFIED="1536716948286" TEXT="to_syslog"/>
</node>
<node CREATED="1536744137000" ID="ID_1462791324" MODIFIED="1536744138955" TEXT="example">
<node CREATED="1536744140026" ID="ID_1518742201" LINK="https://goo.gl/9oqa8o" MODIFIED="1536744156473" TEXT="&#x8f38;&#x51fa;&#x5230;&#x7cfb;&#x7edf;&#x65e5;&#x8a8c;"/>
</node>
</node>
<node CREATED="1458013490587" ID="ID_580239939" MODIFIED="1458013590856" TEXT="/etc/corosync/authkey"/>
<node CREATED="1458036531132" ID="ID_222133241" LINK="http://goo.gl/gmY7eh" MODIFIED="1458036559201" TEXT="MySQL Group Replication: A small Corosync guide"/>
<node CREATED="1458179339708" FOLDED="true" ID="ID_262762445" MODIFIED="1484648763294" TEXT="version">
<node CREATED="1458179344540" ID="ID_1363295996" MODIFIED="1458179347088" TEXT="1.4.7"/>
</node>
<node CREATED="1484101172447" ID="ID_1959233350" MODIFIED="1484101177959" TEXT="cluster engine"/>
<node CREATED="1491448787286" ID="ID_1872548053" MODIFIED="1491448793177" TEXT="/usr/sbin/corosync"/>
<node CREATED="1491450280168" ID="ID_797505261" LINK="https://goo.gl/rjDLK3" MODIFIED="1491450296820" TEXT="Corosync uses UDP transport between ports 5404 and 5406"/>
<node CREATED="1491450510572" ID="ID_1137592656" LINK="https://goo.gl/grySK5" MODIFIED="1491450521961" TEXT=" Corosync port is the default 5405 "/>
<node CREATED="1534147289330" ID="ID_1309077129" MODIFIED="1534147294178" TEXT="ring status"/>
<node CREATED="1534147676405" ID="ID_427050805" LINK="https://goo.gl/K4HXuq" MODIFIED="1534147696478" TEXT="corosync-cfgtool"/>
<node CREATED="1534149523773" ID="ID_255978331" LINK="https://goo.gl/usLkxJ" MODIFIED="1534149538862" TEXT="&#x5fc3;&#x8df3;&#x673a;&#x5236;&#x4f7f;&#x7528;&#x7684;&#x662f;Totem&#x534f;&#x8bae;"/>
<node CREATED="1534149779497" ID="ID_1460678664" LINK="https://goo.gl/Ri6Xmh" MODIFIED="1534149899857" TEXT="How to tune corosync heartbeat timer"/>
</node>
<node CREATED="1458875841173" ID="ID_1834509245" LINK="#ID_1897443728" MODIFIED="1458875847549" TEXT="ClusterLabs stack"/>
<node CREATED="1457343721981" FOLDED="true" ID="ID_199193485" LINK="https://goo.gl/T1dGzv" MODIFIED="1484648763294" TEXT="Cluster Basics">
<node CREATED="1457344319981" ID="ID_1705965306" LINK="#ID_108396586" MODIFIED="1457344749511" TEXT="storage"/>
<node CREATED="1457344380461" ID="ID_1569911574" MODIFIED="1457344381221" TEXT="High availability"/>
<node CREATED="1457344391949" ID="ID_1206277537" MODIFIED="1457344392650" TEXT="Load balancing"/>
<node CREATED="1457344400621" ID="ID_1876590713" MODIFIED="1457344401442" TEXT="High performance"/>
</node>
<node CREATED="1443006183297" ID="ID_1537911653" MODIFIED="1443006190284" TEXT="virtualbox poc test"/>
</node>
<node CREATED="1442296493213" ID="ID_106839327" LINK="http://goo.gl/0HM0bp" MODIFIED="1442296505023" TEXT="User&#x2019;s Guide"/>
<node CREATED="1443838862336" FOLDED="true" ID="ID_255344009" LINK="../technologies.mm#ID_1522985402" MODIFIED="1486105908378" TEXT="virtualbox">
<node CREATED="1443838890265" FOLDED="true" ID="ID_533005610" MODIFIED="1466752398528" TEXT="export">
<node CREATED="1444189075214" MODIFIED="1444189082930" TEXT="OVF file"/>
</node>
<node CREATED="1444189091173" FOLDED="true" ID="ID_1296802193" MODIFIED="1466752398529" TEXT="vmware">
<node CREATED="1444189112173" FOLDED="true" ID="ID_1510717288" LINK="#ID_661863006" MODIFIED="1460098808706" TEXT="allow OVF file import">
<node CREATED="1444201502963" FOLDED="true" ID="ID_977989759" MODIFIED="1460098808706" TEXT="test failed">
<node CREATED="1444201509083" MODIFIED="1444201524168" TEXT="vmplayer 3.1.1 for w7-32bit"/>
</node>
</node>
</node>
</node>
<node CREATED="1445503741222" ID="ID_1287707380" LINK="freeswitch.mm#ID_1070142207" MODIFIED="1534474761240" TEXT="freeswitch">
<node CREATED="1445505837727" FOLDED="true" ID="ID_1991903932" LINK="http://goo.gl/7M3od" MODIFIED="1460098808709" TEXT="FreeSwitch + Bluebox High Availability (HA) Cluster using Heartbeat and DRBD">
<icon BUILTIN="info"/>
<node CREATED="1445505955791" MODIFIED="1445505961204" TEXT="install freeswitch"/>
<node CREATED="1445505851463" MODIFIED="1445505855984" TEXT="bluebox">
<icon BUILTIN="help"/>
</node>
<node CREATED="1445505972303" FOLDED="true" ID="ID_1071202973" MODIFIED="1460098808708" TEXT="Configuring DRBD">
<node CREATED="1445506024727" MODIFIED="1445506025500" TEXT="Make sure you have extra partition for DRBD"/>
<node CREATED="1445506101903" MODIFIED="1445506103492" TEXT="recommended that they&apos;re both have the same disk size."/>
</node>
<node CREATED="1445506129591" MODIFIED="1445506130246" TEXT="Bringing up DRBD."/>
<node CREATED="1445506214223" MODIFIED="1445506215036" TEXT="Installing and Configuring Heartbeat"/>
<node CREATED="1445506240335" MODIFIED="1445506241124" TEXT="have to configure FreeSwitch to use the DRBD"/>
</node>
<node CREATED="1445506651543" ID="ID_580468614" LINK="#ID_1264892827" MODIFIED="1445506656601" TEXT="FreeSwitch + Bluebox High Availability (HA) Cluster using Heartbeat and DRBD"/>
<node CREATED="1458522114036" ID="ID_854127386" LINK="http://goo.gl/OrKijV" MODIFIED="1458522127855" TEXT="High Availability and Failover options for SIP and Asterisk"/>
</node>
<node CREATED="1458521459174" FOLDED="true" ID="ID_904078471" MODIFIED="1489563720978" TEXT="failover seamless">
<node CREATED="1458521563020" ID="ID_1219334435" LINK="http://goo.gl/ZBPauE" MODIFIED="1458521576720" TEXT="Depends on the budget and importance of application"/>
<node CREATED="1458521599431" FOLDED="true" ID="ID_890591789" MODIFIED="1460098808710" TEXT="NEC offers fault tolerant servers where the HA is in mirrored hardware">
<node CREATED="1458521640826" ID="ID_1586901339" LINK="https://goo.gl/rlmyCU" MODIFIED="1458521662779" TEXT="Express5800/FT Series"/>
</node>
</node>
<node CREATED="1458521697552" FOLDED="true" ID="ID_578944" LINK="../tatung.mm" MODIFIED="1486105908379" TEXT="tatung">
<node CREATED="1458529822572" FOLDED="true" ID="ID_592881339" MODIFIED="1463383982145" TEXT="active/passive cluster">
<node CREATED="1460686504911" FOLDED="true" ID="ID_850138572" LINK="https://goo.gl/Ar9Jrt" MODIFIED="1463383982144" TEXT="AN ACTIVE/PASSIVE APACHE WEB SERVER">
<node CREATED="1460686925760" ID="ID_500078522" MODIFIED="1460686931905" TEXT="share storage"/>
</node>
</node>
</node>
<node CREATED="1458179732828" ID="ID_1897443728" MODIFIED="1519630758245" TEXT="ClusterLabs stack">
<node CREATED="1458011403279" FOLDED="true" ID="ID_451231241" LINK="#ID_881918740" MODIFIED="1491469117161" TEXT="CoroSync">
<node CREATED="1484102728930" ID="ID_1856313954" MODIFIED="1484102730591" TEXT=" messaging and membership services"/>
<node CREATED="1489024706613" ID="ID_499904667" MODIFIED="1489031634840" TEXT="cluster engine">
<icon BUILTIN="help"/>
</node>
<node CREATED="1489111446183" FOLDED="true" ID="ID_1731969486" LINK="pcs%20node%20offline%20alert" MODIFIED="1489376205410" TEXT="overview">
<node CREATED="1489116662644" ID="ID_1855297262" MODIFIED="1489116663488" TEXT="optionally encrypts all messages sent over the network using the SOBER-128 stream cipher."/>
</node>
<node CREATED="1489139904463" FOLDED="true" ID="ID_1381408207" LINK="https://goo.gl/6zIOKm" MODIFIED="1489376205410" TEXT="is the communication layer of modern open-source clusters.">
<node CREATED="1489139966348" ID="ID_868395196" MODIFIED="1489139967105" TEXT="also replaces the now-deprecated heartbeat cluster communication program."/>
</node>
<node CREATED="1489140887714" FOLDED="true" ID="ID_1338206736" LINK="https://goo.gl/6zIOKm" MODIFIED="1490169522446" TEXT="uses the totem protocol">
<node CREATED="1489141097724" ID="ID_1418334882" MODIFIED="1489141102817" TEXT="guorum"/>
<node CREATED="1489567110490" ID="ID_1914911039" LINK="https://goo.gl/tkQvwu" MODIFIED="1489567132761" TEXT=" if a token is not received from a node within a period of time,"/>
<node CREATED="1489567118330" ID="ID_1086943898" LINK="https://goo.gl/tkQvwu" MODIFIED="1489567134799" TEXT=" it is considered lost and a new token is sent."/>
</node>
<node CREATED="1489141231693" ID="ID_319762407" LINK="https://goo.gl/6zIOKm" MODIFIED="1489141511452" TEXT=" itself only cares about cluster membership, message passing and quorum">
<icon BUILTIN="info"/>
</node>
<node CREATED="1489141370797" FOLDED="true" ID="ID_842893104" LINK="https://goo.gl/MT69nK" MODIFIED="1491469117159" TEXT="corosync.conf(5)">
<node CREATED="1489141429293" ID="ID_1444988448" MODIFIED="1489141430257" TEXT="bindnetaddr"/>
</node>
</node>
<node CREATED="1458179759844" ID="ID_1832624086" LINK="pacemaker.mm" MODIFIED="1534471678503" TEXT="Pacemaker"/>
<node CREATED="1458196834094" ID="ID_878912311" LINK="http://goo.gl/1cipWm" MODIFIED="1519630760893" TEXT="Clusters from Scratch">
<icon BUILTIN="info"/>
<node CREATED="1458196880924" ID="ID_421404818" LINK="http://goo.gl/1cipWm" MODIFIED="1519630763999" TEXT="Edition 5">
<node CREATED="1458197677910" ID="ID_177886380" LINK="http://goo.gl/GoEHv2" MODIFIED="1458197693595" TEXT="Chapter 5. Creating an Active/Passive Cluster"/>
</node>
<node CREATED="1458197914429" ID="ID_1023288181" LINK="http://goo.gl/uS6hTl" MODIFIED="1519630762667" TEXT="Edition 9">
<node CREATED="1484113963599" FOLDED="true" ID="ID_541553972" MODIFIED="1484113973534" TEXT="Chapter 2. Installation">
<node CREATED="1458202238270" FOLDED="true" ID="ID_1717943475" LINK="http://goo.gl/eE2CRq" MODIFIED="1484648763296" TEXT="2.4.1. Configure Host Name Resolution">
<node CREATED="1458203064455" ID="ID_185078108" MODIFIED="1458212387424" TEXT="/etc/hosts"/>
<node CREATED="1484037911031" ID="ID_1923382902" LINK="https://goo.gl/St1UhD" MODIFIED="1484037934509" TEXT="How should the /etc/hosts file be set up on RHEL cluster nodes?"/>
</node>
<node CREATED="1458202886726" FOLDED="true" ID="ID_711467925" MODIFIED="1460096535202" TEXT="2.4.2. Configure SSH">
<node CREATED="1458202881791" ID="ID_655530085" MODIFIED="1458202882924" TEXT="Creating and Activating a new SSH Key"/>
</node>
<node CREATED="1458289685016" FOLDED="true" ID="ID_182048700" LINK="https://goo.gl/uPNw4y" MODIFIED="1484648763296" TEXT="2.6.2. Enable pcs Daemon">
<node CREATED="1458289676960" ID="ID_1150372636" MODIFIED="1458289677808" TEXT="installed packages will create a hacluster user with a disabled password"/>
<node CREATED="1484104571162" ID="ID_628811191" MODIFIED="1484104572007" TEXT="2.6.2. Enable pcs Daemon"/>
</node>
<node CREATED="1484104360378" FOLDED="true" ID="ID_1432322211" LINK="https://goo.gl/6wF5HD" MODIFIED="1484648763296" TEXT="2.6">
<node CREATED="1484104363706" ID="ID_1126609979" MODIFIED="1484104461824" TEXT="TCP ports 2224, 3121, and 21064, and UDP port 5405"/>
<node CREATED="1484104480434" ID="ID_335197790" MODIFIED="1484104481663" TEXT="might want to disable the firewall and SELinux entirely until you have everything working"/>
</node>
</node>
<node CREATED="1484113938875" ID="ID_1129016923" LINK="https://goo.gl/BNzIEo" MODIFIED="1484114003082" TEXT="Chapter 3. Pacemaker Tools"/>
<node CREATED="1484114646872" FOLDED="true" ID="ID_149785622" LINK="https://goo.gl/C4MVYP" MODIFIED="1484115526757" TEXT="Chapter 4. Start and Verify Cluster">
<node CREATED="1484114842104" FOLDED="true" ID="ID_915532160" MODIFIED="1484648763297" TEXT="4.2. Verify Corosync Installation">
<node CREATED="1484115163767" ID="ID_379846625" MODIFIED="1484115184473" TEXT="ring status">
<icon BUILTIN="help"/>
</node>
<node CREATED="1484115171177" ID="ID_1715076872" MODIFIED="1484115181001" TEXT="redundant ring protocol">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1458465626338" FOLDED="true" ID="ID_322863696" LINK="http://goo.gl/eE2CRq" MODIFIED="1486105908380" TEXT="Chapter 5. Create an Active/Passive Cluster">
<node CREATED="1458198024493" ID="ID_533620555" LINK="http://goo.gl/wnv9NM" MODIFIED="1458198036335" TEXT="5.1. Explore the Existing Configuration"/>
<node CREATED="1458198484229" ID="ID_1638261997" LINK="http://goo.gl/2E3ef1" MODIFIED="1458198504259" TEXT="5.2. Add a Resource"/>
<node CREATED="1458200535102" FOLDED="true" ID="ID_31643226" MODIFIED="1486105908380" TEXT="5.3. Perform a Failover">
<node CREATED="1458440919684" FOLDED="true" ID="ID_1937798358" MODIFIED="1486105908379" TEXT="quorum">
<node CREATED="1458440917695" ID="ID_1242887342" MODIFIED="1458440919056" TEXT=" prevent resources from starting on more nodes than desired"/>
<node CREATED="1459243205474" ID="ID_177411541" LINK="https://goo.gl/0BFUEJ" MODIFIED="1459243224457" TEXT="allow a single node to maintain quorum"/>
</node>
</node>
<node CREATED="1458441057271" ID="ID_470939715" MODIFIED="1458441058295" TEXT="5.4. Prevent Resources from Moving after Recovery"/>
</node>
<node CREATED="1458441458157" FOLDED="true" ID="ID_479549825" LINK="https://goo.gl/Hv12uL" MODIFIED="1488961488573" TEXT="Chapter 6. Add Apache as a Cluster Service">
<node CREATED="1458441504957" ID="ID_763004281" MODIFIED="1458441505721" TEXT="Do not enable the httpd service."/>
<node CREATED="1466739082525" ID="ID_1498114732" MODIFIED="1466739083454" TEXT="the resource agent used by Pacemaker assumes the server-status URL is available."/>
<node CREATED="1458441488759" ID="ID_851002024" MODIFIED="1458441489762" TEXT="Services that are intended to be managed via the cluster software should never be managed by the OS"/>
<node CREATED="1458442147899" ID="ID_1870858892" LINK="http://goo.gl/2hBj2c" MODIFIED="1458442202279" TEXT="6.5. Ensure Resources Run on the Same Host"/>
<node CREATED="1458441673550" ID="ID_963943439" LINK="#ID_745377106" MODIFIED="1458441682361" TEXT="6.6. Ensure Resources Start and Stop in Order"/>
<node CREATED="1458441660126" FOLDED="true" ID="ID_30838868" LINK="http://goo.gl/cO4ggZ" MODIFIED="1466752398531" TEXT="6.7. Prefer One Node Over Another">
<node CREATED="1458441959485" FOLDED="true" ID="ID_1287537132" MODIFIED="1460096535277" TEXT="crm_simulate">
<node CREATED="1458441975479" ID="ID_1057734771" MODIFIED="1458441977421" TEXT="see the current placement scores"/>
</node>
</node>
<node CREATED="1458442039696" ID="ID_277257946" MODIFIED="1458442040431" TEXT="6.8. Move Resources Manually"/>
</node>
<node CREATED="1458442321610" FOLDED="true" ID="ID_1586227799" LINK="http://goo.gl/reXdcx" MODIFIED="1484118036887" TEXT="Chapter 7. Replicate Storage Using DRBD">
<node CREATED="1458524944036" FOLDED="true" ID="ID_362027371" LINK="#ID_1285225582" MODIFIED="1459321449377" TEXT="DRBD">
<node CREATED="1458875345516" ID="ID_535270522" LINK="#ID_1449728282" MODIFIED="1458875351887" TEXT="drbdadm"/>
</node>
<node CREATED="1458629749650" ID="ID_1165391144" LINK="../technologies.mm#ID_771915814" MODIFIED="1458629787377" TEXT="LVM"/>
<node CREATED="1458465952340" FOLDED="true" ID="ID_1102554521" LINK="http://goo.gl/O8rso6" MODIFIED="1484648763297" TEXT="7.1. Install the DRBD Packages">
<node CREATED="1458466020035" ID="ID_1563151109" MODIFIED="1458466020774" TEXT="will not be able to run under the default SELinux security policies"/>
<node CREATED="1458528743619" ID="ID_1107701848" LINK="http://goo.gl/VOBtmQ" MODIFIED="1458529355695" TEXT="CentOS6.6&#x306e;Linux-HA&#x3067;DRBD&#x3092;&#x69cb;&#x7bc9;&#x3059;&#x308b;&#x624b;&#x9806;&#x3081;&#x3082;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1458529718841" ID="ID_1290736351" MODIFIED="1458529721343" TEXT="recommended to use a dedicated, isolated network for cluster-related traffic"/>
<node CREATED="1458531071092" ID="ID_666345506" MODIFIED="1458531076377" TEXT="1.4 MB"/>
</node>
<node CREATED="1458466162689" FOLDED="true" ID="ID_424453727" MODIFIED="1463383982147" TEXT="7.2. Allocate a Disk Volume for DRBD">
<node CREATED="1458531539516" FOLDED="true" ID="ID_858966136" MODIFIED="1463383982146" TEXT="need its own block device on each node">
<node CREATED="1458532045276" ID="ID_256593314" MODIFIED="1458532046379" TEXT="be a physical disk partition"/>
<node CREATED="1458532059916" ID="ID_1817000106" MODIFIED="1458532060801" TEXT="or logical volume"/>
</node>
<node CREATED="1458532069837" ID="ID_1879903844" MODIFIED="1458532072049" TEXT="of whatever size you need for your data"/>
<node CREATED="1458530692407" FOLDED="true" ID="ID_1291240424" MODIFIED="1463383982146" TEXT="what if partition not equal">
<node CREATED="1458530894268" ID="ID_449690023" LINK="http://goo.gl/jjzM6v" MODIFIED="1458530912571" TEXT="&quot;agrees&quot; to the minimum of the sizes of the lower level devices"/>
<node CREATED="1458530927748" ID="ID_434615544" LINK="http://goo.gl/jjzM6v" MODIFIED="1458530938912" TEXT="[DRBD-user] slightly different partition sizes"/>
</node>
</node>
<node CREATED="1458809223313" ID="ID_612571036" LINK="http://goo.gl/RNui63" MODIFIED="1462952967777" TEXT="7.3. Configure DRBD"/>
<node CREATED="1458809214201" FOLDED="true" ID="ID_1988801558" MODIFIED="1463383982148" TEXT="7.4. Initialize DRBD">
<node CREATED="1459303603396" ID="ID_846664732" MODIFIED="1459303609695" TEXT="create metadata"/>
<node CREATED="1458872898651" ID="ID_1053151282" MODIFIED="1458872929837" TEXT="must be unmounted partition"/>
<node CREATED="1458814533167" FOLDED="true" ID="ID_1634590206" LINK="https://goo.gl/5Kw8mq" MODIFIED="1460096535397" TEXT="&apos;r0&apos; not defined in your config (for this host).">
<node CREATED="1458814560411" ID="ID_1289607725" MODIFIED="1458814566145" TEXT="resource name"/>
<node CREATED="1458814566451" FOLDED="true" ID="ID_900421967" MODIFIED="1460096535387" TEXT="hostname">
<node CREATED="1458815511791" ID="ID_1278151255" MODIFIED="1458815515673" TEXT="uname -a"/>
</node>
</node>
<node CREATED="1458872679939" ID="ID_228067253" MODIFIED="1458872680729" TEXT="bring up the DRBD resource"/>
<node CREATED="1458874863135" ID="ID_319058069" MODIFIED="1458874873124" TEXT="tell which node has correct data"/>
<node CREATED="1458878512894" ID="ID_1530121359" MODIFIED="1458878513744" TEXT="modprobe drbd"/>
<node CREATED="1458878774614" ID="ID_1776096060" MODIFIED="1458878775236" TEXT="drbdadm up wwwdata"/>
</node>
<node CREATED="1458872956099" ID="ID_333905121" LINK="../tatung.mm#ID_1806850366" MODIFIED="1458872993386" TEXT="tatung"/>
<node CREATED="1458873206332" ID="ID_346649549" LINK="../mysql.mm" MODIFIED="1458873222051" TEXT="mysql"/>
<node CREATED="1458875993877" FOLDED="true" ID="ID_1153557295" MODIFIED="1463383982148" TEXT="7.5. Populate the DRBD Disk">
<node CREATED="1462959535015" ID="ID_636467200" MODIFIED="1462959536098" TEXT="creating and populating a filesystem"/>
<node CREATED="1458876056533" ID="ID_1984922878" MODIFIED="1458885612108" TEXT="create a filesystem on the &quot;primary node DRBD device&quot;">
<icon BUILTIN="yes"/>
</node>
</node>
<node CREATED="1458876640885" FOLDED="true" ID="ID_1132584625" LINK="http://goo.gl/l3fsSY" MODIFIED="1459321442472" TEXT="7.6. Configure the Cluster for the DRBD device">
<node CREATED="1458885908291" ID="ID_560195878" MODIFIED="1458885909052" TEXT="create a cluster resource for the DRBD device"/>
<node CREATED="1459304752321" ID="ID_1978157454" LINK="https://goo.gl/tcELs2" MODIFIED="1459304769443" TEXT="Table 8.1. Resource Clone Options"/>
<node CREATED="1459304813489" ID="ID_1984798111" LINK="https://goo.gl/BfK91e" MODIFIED="1459304827502" TEXT="Table 8.2. Properties of a Multi-State Resource"/>
</node>
<node CREATED="1458885942970" FOLDED="true" ID="ID_1784504813" LINK="http://goo.gl/IaZPWW" MODIFIED="1459321441006" TEXT="7.7. Configure the Cluster for the Filesystem">
<node CREATED="1459247460876" ID="ID_1707739299" MODIFIED="1459247461690" TEXT="a working DRBD device"/>
<node CREATED="1459247474676" ID="ID_582866698" MODIFIED="1459247475356" TEXT="mount its filesystem."/>
<node CREATED="1459247552132" ID="ID_1931947693" MODIFIED="1459247552865" TEXT="tell the cluster where it can be located"/>
<node CREATED="1459307526570" ID="ID_1882201446" LINK="https://goo.gl/mUKYjI" MODIFIED="1459307545192" TEXT="2.4. &#x900f;&#x904e; PCS &#x6307;&#x4ee4;&#x4f86;&#x5efa;&#x7acb;&#x8cc7;&#x6e90;&#x548c;&#x8cc7;&#x6e90;&#x7fa4;&#x7d44;"/>
<node CREATED="1459310617532" ID="ID_1364417456" LINK="https://goo.gl/PYDxOy" MODIFIED="1459310640098" TEXT="2.4. SAVING A CONFIGURATION CHANGE TO A FILE"/>
<node CREATED="1459317131085" ID="ID_299188660" LINK="https://goo.gl/iR2pvn" MODIFIED="1459317141456" TEXT="6.3. COLOCATION OF RESOURCES"/>
</node>
<node CREATED="1458885977650" FOLDED="true" ID="ID_543193617" LINK="http://goo.gl/UWg44I" MODIFIED="1463383982149" TEXT="7.8. Test Cluster Failover">
<node CREATED="1459318474447" ID="ID_1246939781" MODIFIED="1459318475628" TEXT="put the node into standby mode"/>
<node CREATED="1463383051073" ID="ID_1429121672" MODIFIED="1463383074997" TEXT="primary / secondary interchangably"/>
<node CREATED="1463383101137" ID="ID_1520475607" LINK="#ID_1564431385" MODIFIED="1463383123052" TEXT="pcs cluster standby"/>
</node>
</node>
<node CREATED="1458886001538" FOLDED="true" ID="ID_406466439" LINK="https://goo.gl/PUc1Az" MODIFIED="1489567104874" TEXT="Chapter 8. Configure STONITH">
<icon BUILTIN="help"/>
<node CREATED="1459318681129" FOLDED="true" ID="ID_1558766610" LINK="http://goo.gl/UgC59p" MODIFIED="1459330219532" TEXT="8.1. What is STONITH?">
<node CREATED="1459319441994" ID="ID_1200755128" MODIFIED="1459319443085" TEXT="the cluster uses STONITH to force the whole node offline"/>
<node CREATED="1458198283213" ID="ID_1972026292" LINK="#ID_150362768" MODIFIED="1459319686533" TEXT="a technique for NodeFencing"/>
</node>
<node CREATED="1459319470024" FOLDED="true" ID="ID_1299603130" MODIFIED="1459330218498" TEXT="8.2. Choose a STONITH Device">
<node CREATED="1459319551992" FOLDED="true" ID="ID_1553814554" MODIFIED="1459330217499" TEXT="allow the cluster to differentiate">
<node CREATED="1459319554096" ID="ID_382652409" MODIFIED="1459319558885" TEXT="node failure"/>
<node CREATED="1459319559400" ID="ID_1054162432" MODIFIED="1459319563583" TEXT="network failure"/>
</node>
</node>
<node CREATED="1459244612443" ID="ID_1086861008" MODIFIED="1459330047435" TEXT="8.2.3. Configuring CMAN Fencing"/>
<node CREATED="1459319943656" FOLDED="true" ID="ID_1311522698" LINK="http://goo.gl/pK9AXX" MODIFIED="1459330214518" TEXT="8.3. Configure the Cluster for STONITH">
<node CREATED="1459320243024" ID="ID_112346497" MODIFIED="1459320244281" TEXT="Install the STONITH agent(s)."/>
<node CREATED="1459322887569" ID="ID_1855432037" MODIFIED="1459322891298" TEXT="agent script">
<icon BUILTIN="help"/>
</node>
<node CREATED="1459323097705" ID="ID_210641091" MODIFIED="1459323098783" TEXT="4. Fencing: Configuring STONITH"/>
<node CREATED="1459324273277" ID="ID_1307621736" LINK="https://goo.gl/oXKtrp" MODIFIED="1459324289690" TEXT="4.2. General Properties of Fencing Devices"/>
<node CREATED="1459326902069" FOLDED="true" ID="ID_82086738" MODIFIED="1460096535398" TEXT="Create the fencing resource">
<node CREATED="1459326937707" ID="ID_965557818" MODIFIED="1459326945792" TEXT="what fencing resource">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1459327304715" FOLDED="true" ID="ID_825704543" MODIFIED="1489457758637" TEXT="8.4. Example">
<node CREATED="1459327316629" FOLDED="true" ID="ID_84162924" MODIFIED="1489457758637" TEXT="IPMI device">
<node CREATED="1459327519556" ID="ID_1257522783" LINK="http://goo.gl/x4VVQu" MODIFIED="1459327532027" TEXT="&#x8b93;&#x7cfb;&#x7d71;&#x7ba1;&#x7406;&#x8005;&#x80fd;&#x5920;&#x900f;&#x904e;&#x7db2;&#x8def;&#x6216;&#x8005;Serial&#x7684;&#x50b3;&#x8f38;&#x5f62;&#x5f0f;&#x4f86;&#x76e3;&#x63a7;&#x7cfb;&#x7d71;&#x4e0a;&#x5404;&#x7a2e;&#x5143;&#x4ef6;&#x7684;&#x5065;&#x5eb7;&#x72c0;&#x6cc1;"/>
<node CREATED="1459327457395" FOLDED="true" ID="ID_1358595096" LINK="https://goo.gl/5Gl1lk" MODIFIED="1460096535399" TEXT="IPMI wiki">
<node CREATED="1459328391746" ID="ID_821575188" LINK="http://goo.gl/d8Msk6" MODIFIED="1459328409671" TEXT="man 1 ipmitool"/>
</node>
<node CREATED="1459327325396" FOLDED="true" ID="ID_1333101776" LINK="../tatung.mm" MODIFIED="1460098808712" TEXT="tatung server support">
<node CREATED="1459327422291" ID="ID_517077455" MODIFIED="1459327423578" TEXT="[apexx@tt216 ~]$ dmesg | grep ipmi"/>
</node>
<node CREATED="1489384409572" ID="ID_141040931" LINK="#ID_507585418" MODIFIED="1489384424710" TEXT="linux"/>
<node CREATED="1489385962107" ID="ID_1445814292" LINK="https://goo.gl/Wvo8CX" MODIFIED="1489385973938" TEXT=" it&apos;s not the best fencing  device"/>
</node>
<node CREATED="1459327654995" ID="ID_888717695" MODIFIED="1459327656015" TEXT="Obtain the agent&#x2019;s possible parameters"/>
<node CREATED="1459329083036" ID="ID_1649701964" MODIFIED="1459329084763" TEXT="creating our STONITH resource"/>
<node CREATED="1459329311772" ID="ID_1312035109" MODIFIED="1459329312795" TEXT="Enable STONITH in the cluster"/>
<node CREATED="1459330026165" ID="ID_1219692746" MODIFIED="1459330050427" TEXT="Step 12: Test">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1459330132613" ID="ID_575807806" MODIFIED="1459330133600" TEXT="Chapter 9. Convert Cluster to Active/Active"/>
<node CREATED="1459330164452" ID="ID_1521106802" MODIFIED="1459330169951" TEXT="Configuration Recap">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1458289998000" FOLDED="true" ID="ID_62656536" MODIFIED="1493360593485" TEXT="pcsd">
<node CREATED="1458290001368" ID="ID_873354727" LINK="https://goo.gl/MbWSd4" MODIFIED="1458290029689" TEXT="Unfortunately pcsd is not supported on RHEL 6 (or CentOS 6)"/>
<node CREATED="1484118044620" ID="ID_1028012715" LINK="https://goo.gl/3ulUns" MODIFIED="1484118057801" TEXT="Chapter 3. Cluster Creation and Administration">
<icon BUILTIN="info"/>
</node>
<node CREATED="1484210499114" ID="ID_1904825494" LINK="https://goo.gl/9B1UH6" MODIFIED="1484210514859" TEXT="5.1. Resource Creation"/>
<node CREATED="1488962084602" FOLDED="true" ID="ID_1163633062" LINK="https://goo.gl/Lajip1" MODIFIED="1488963700520" TEXT="WEB GUI">
<node CREATED="1488962371906" ID="ID_1964051376" LINK="https://goo.gl/bq46Wq" MODIFIED="1488962379174" TEXT="port 2224"/>
<node CREATED="1488962844683" ID="ID_494164772" MODIFIED="1488962846078" TEXT="https://192.168.66.200:2224/login"/>
</node>
</node>
<node CREATED="1458886388325" FOLDED="true" ID="ID_695785460" MODIFIED="1491469117165" TEXT="cman">
<node CREATED="1458886393466" ID="ID_752243182" LINK="http://goo.gl/Glo3ax" MODIFIED="1458886424466" TEXT="When Pacemaker is used with cman, Pacemaker provides the fencing capabilities. "/>
<node CREATED="1489374682641" FOLDED="true" ID="ID_1966233218" LINK="https://goo.gl/n2pNBw" MODIFIED="1489374731853" TEXT="I do not  really understand what roles these three packages all play">
<node CREATED="1489373104787" ID="ID_1131330481" LINK="https://goo.gl/8axx3x" MODIFIED="1489373139637" TEXT="This is from a 6.4 system using cman and pacemaker."/>
<node CREATED="1489373886606" ID="ID_526786765" LINK="https://goo.gl/2QJ9A3" MODIFIED="1489373900119" TEXT="cman can do this (quorum handling) very well (mature code)"/>
<node CREATED="1489373953248" ID="ID_931829767" LINK="https://goo.gl/2QJ9A3" MODIFIED="1489374216100" TEXT="is doing this in the lower layers  (extending corosync)"/>
<node CREATED="1489374201905" ID="ID_732398348" LINK="https://goo.gl/2QJ9A3" MODIFIED="1489374214230" TEXT="is part of the RH cluster suite"/>
<node CREATED="1458886402842" ID="ID_691114663" LINK="http://goo.gl/Glo3ax" MODIFIED="1458886422394" TEXT="Also, CMAN&apos;s fenced is not very good at shutting down cleanly. "/>
</node>
<node CREATED="1489374786425" FOLDED="true" ID="ID_379976131" LINK="https://goo.gl/h2gFXi" MODIFIED="1489374863398" TEXT="cman and corosync the Yin &amp; Yang of cluster.conf">
<node CREATED="1489374857370" ID="ID_434935996" MODIFIED="1489374858149" TEXT=" describes the strange relationship between cman and corosync as regards configuration. "/>
</node>
<node CREATED="1491430632222" ID="ID_1300614583" LINK="http://tinyurl.com/mmnw8jh" MODIFIED="1491430648590" TEXT="The CMAN configuration lives in /etc/cluster/cluster.conf."/>
<node CREATED="1491459207690" ID="ID_622755099" MODIFIED="1491459208606" TEXT="cmannotifyd daemon talks to CMAN"/>
<node CREATED="1458034269541" FOLDED="true" ID="ID_1052652715" LINK="http://clusterlabs.org/quickstart-redhat-6.html" MODIFIED="1491469117163" TEXT="RHEL 6.4 onwards">
<icon BUILTIN="button_ok"/>
<icon BUILTIN="info"/>
<node CREATED="1458034245205" ID="ID_1485183232" LINK="http://goo.gl/qQoKa2" MODIFIED="1491459129337" TEXT="The supported stack on RHEL6 is based on CMAN">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1458123252902" FOLDED="true" ID="ID_1535566587" MODIFIED="1484648763317" TEXT="Configure Cluster Membership and Messaging">
<node CREATED="1458123217207" ID="ID_152482092" LINK="#ID_111050881" MODIFIED="1459244480094" TEXT="/etc/cluster/cluster.conf"/>
</node>
<node CREATED="1458123269005" ID="ID_1377403286" MODIFIED="1458123269876" TEXT="Start the Cluster"/>
<node CREATED="1458183153805" FOLDED="true" ID="ID_998092571" MODIFIED="1484648763318" TEXT="Add a Resource">
<node CREATED="1458183138150" ID="ID_1288806864" MODIFIED="1458183139723" TEXT="my_first_svc"/>
<node CREATED="1458183246141" FOLDED="true" ID="ID_910645938" MODIFIED="1459326861299" TEXT="ocf">
<node CREATED="1458183243205" FOLDED="true" ID="ID_437249589" LINK="http://goo.gl/bO54e3" MODIFIED="1459326861299" TEXT="5.2.1. Open Cluster Framework">
<node CREATED="1458183297286" ID="ID_440186916" LINK="http://goo.gl/bO54e3" MODIFIED="1458183309581" TEXT="OCF standard [9] is basically an extension of the Linux Standard Base conventions"/>
</node>
</node>
</node>
<node CREATED="1458196226234" ID="ID_1700391950" MODIFIED="1458196227425" TEXT="Configure Fencing"/>
</node>
<node CREATED="1491459432880" ID="ID_396802150" MODIFIED="1491459433716" TEXT="cmannotifyd"/>
</node>
<node CREATED="1487673302544" ID="ID_278760522" LINK="https://github.com/ClusterLabs/resource-agents/tree/master/heartbeat" MODIFIED="1487673309315" TEXT="resource-agents"/>
<node CREATED="1521510555763" ID="ID_1579425880" LINK="drbd.mm" MODIFIED="1521510555767" TEXT="DRBD">
<node CREATED="1534471796568" ID="ID_1741107239" LINK="https://goo.gl/3tFcSy" MODIFIED="1534471810534" TEXT="man page"/>
</node>
</node>
<node CREATED="1463118531585" ID="ID_517331688" LINK="pacemaker.mm" MODIFIED="1534471682815" TEXT="Pacemaker"/>
<node CREATED="1463132543053" FOLDED="true" ID="ID_1532343477" MODIFIED="1486105908380" TEXT="Networking, Firewall and SELinux Configuration">
<node CREATED="1463132546125" ID="ID_941505723" LINK="https://goo.gl/cjzVU6" MODIFIED="1463132579649" TEXT="good configuration example - for demonstration">
<icon BUILTIN="idea"/>
</node>
</node>
<node CREATED="1463118545569" ID="ID_1634800994" LINK="drbd.mm" MODIFIED="1534474734594" TEXT="DRBD"/>
<node CREATED="1463119039145" ID="ID_1561434437" MODIFIED="1536114467569" TEXT="reference articles">
<node CREATED="1463119453506" FOLDED="true" ID="ID_67666792" LINK="http://goo.gl/4oPRSy" MODIFIED="1486105908381" TEXT="MySQL HA &#x9ad8;&#x53ef;&#x7528;&#x6027;&#xff0c;DRBD &#x8207; Heartbeat">
<icon BUILTIN="info"/>
<node CREATED="1463119468889" ID="ID_298719174" MODIFIED="1463119472833" TEXT="centos 6.6"/>
<node CREATED="1463119486194" ID="ID_1423930836" MODIFIED="1463119486786" TEXT=".x86_64"/>
<node CREATED="1463125357862" ID="ID_483316109" MODIFIED="1463125359355" TEXT="&#x7576; node1 &#x639b;&#x8f09;&#x6642;&#xff0c; node2 &#x662f;&#x4e0d;&#x80fd;&#x639b;&#x8f09;&#x7684;&#xff0c;&#x9700;&#x8981; node1 umount &#x5f8c;&#xff0c; node2 &#x5207;&#x63db;&#x70ba; primary &#x624d;&#x884c; "/>
</node>
<node CREATED="1444482208046" ID="ID_1296688835" LINK="http://goo.gl/gk9vYY" MODIFIED="1444484950036" TEXT="Linux HA - DRBD &amp; Heartbeat"/>
<node CREATED="1444483941154" FOLDED="true" ID="ID_695010851" LINK="http://goo.gl/ZHOlbo" MODIFIED="1484121655997" TEXT="CentOS 6 DRBD&#x5b89;&#x88dd;">
<icon BUILTIN="info"/>
<node CREATED="1444484244471" ID="ID_379858256" MODIFIED="1444484254670" TEXT="build DRBD from source"/>
<node CREATED="1463133586693" ID="ID_319328914" MODIFIED="1463133592965" TEXT=" chkconfig --add drbd, not by pcs"/>
<node CREATED="1463133631798" ID="ID_1900349212" MODIFIED="1463133632484" TEXT="x86_64/"/>
<node CREATED="1463133660325" ID="ID_196085411" MODIFIED="1463133687721" TEXT="dd if=/dev/zero of=/dev/sdb1 bs=1M count=100"/>
<node CREATED="1463133689373" ID="ID_1102138995" MODIFIED="1463133690235" TEXT="&#x585e;&#x5165;&#x4e00;&#x4e9b;&#x8cc7;&#x6599;&#x5230;/dev/sdb1&#x5426;&#x5247;&#x6709;&#x6642;create-md&#x6642;&#x6703;&#x51fa;&#x73fe;&#x932f;&#x8aa4;&#x3002;"/>
<node CREATED="1463133793037" ID="ID_1098061238" MODIFIED="1463133793708" TEXT="&#x56e0;Secondary Node&#x5728;DRBD&#x4ecd;&#x555f;&#x52d5;&#x7684;&#x72c0;&#x614b;&#x4e0b;&#x662f;&#x7121;&#x6cd5;&#x639b;&#x8f09;&#x8cc7;&#x6599;&#x593e;&#x300e;backup&#x300f;&#x7684;&#xff0c;&#x6240;&#x4ee5;&#x5fc5;&#x9808;&#x5148;&#x505c;&#x6b62;&#x624d;&#x80fd;&#x639b;&#x8f09;&#x3002;"/>
<node CREATED="1463134011949" ID="ID_1652248724" MODIFIED="1463134012867" TEXT="C. &#x624b;&#x52d5;&#x5207;&#x63db;"/>
<node CREATED="1463370582827" ID="ID_1780625024" MODIFIED="1463370587113" TEXT="drbd 8.4"/>
</node>
<node CREATED="1445538092083" FOLDED="true" ID="ID_731673093" LINK="http://goo.gl/syjQy7" MODIFIED="1463383982165" TEXT="DRBD: Redundant NFS Storage on CentOS 6">
<node CREATED="1444484879688" FOLDED="true" ID="ID_1656472378" LINK="http://goo.gl/syjQy7" MODIFIED="1463383982164" TEXT="Install EL Repository">
<icon BUILTIN="info"/>
<node CREATED="1444485748271" ID="ID_1428491891" LINK="#ID_1599849031" MODIFIED="1458812081848" TEXT="Pacemaker"/>
</node>
<node CREATED="1447931718414" ID="ID_581050448" LINK="#ID_1656472378" MODIFIED="1447931723639" TEXT="Install EL Repository"/>
</node>
<node CREATED="1445540850243" FOLDED="true" ID="ID_966608161" LINK="https://goo.gl/tPqbG7" MODIFIED="1460098808718" TEXT="DRBD &#x2013; How to configure DRBD on CentOS 6">
<node CREATED="1445540819647" ID="ID_1571458625" LINK="http://goo.gl/iRQQAk" MODIFIED="1445540867245" TEXT="CentOS High Availability Paperback &#x2013; April 28, 2015">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1463120983932" FOLDED="true" ID="ID_127311798" LINK="http://goo.gl/0a0VZ5" MODIFIED="1463383982166" TEXT="DRBD master/slave setup">
<node CREATED="1463121034050" ID="ID_1713779877" MODIFIED="1463121035295" TEXT="DRBD is like RAID 1 over network"/>
</node>
<node CREATED="1463126941597" ID="ID_1074829615" LINK="https://goo.gl/HZL56X" MODIFIED="1463126951001" TEXT="Axigen with Pacemaker, Corosync and DRBD - Solution Deployment on CentOS 7"/>
<node CREATED="1463134506637" FOLDED="true" ID="ID_1113711001" LINK="http://goo.gl/Z7dMv7" MODIFIED="1463383982167" TEXT="How to: Install and configure DRBD on CentOS 6">
<node CREATED="1463134537357" ID="ID_1907913922" MODIFIED="1463134540205" TEXT="drbd 8.4"/>
<node CREATED="1463134767719" ID="ID_644440248" MODIFIED="1463134771154" TEXT="Make sure that both machines are using NTP for time synchronization! "/>
<node CREATED="1463134825501" ID="ID_1125857305" MODIFIED="1463134826203" TEXT="* * * * root ntpdate your.ntp.server"/>
</node>
<node CREATED="1463136755701" FOLDED="true" ID="ID_1693884634" LINK="https://goo.gl/Bx1V55" MODIFIED="1463383982167" TEXT="How To Configure Data Replication/Synchronize on CentOS 6 Using DRBD">
<node CREATED="1463136781102" ID="ID_311529395" MODIFIED="1463136782330" TEXT="The systems using CentOS 6 64 Bit"/>
<node CREATED="1463136811165" ID="ID_655208538" MODIFIED="1463136815362" TEXT="drbd 8.4.5"/>
</node>
<node CREATED="1443006161465" FOLDED="true" ID="ID_107683204" LINK="tux/centos.mm" MODIFIED="1491469117171" TEXT="centos">
<node CREATED="1458180889524" FOLDED="true" ID="ID_1967568931" MODIFIED="1491469117170" TEXT="6">
<node CREATED="1460103012588" FOLDED="true" ID="ID_257185855" LINK="#ID_1599849031" MODIFIED="1491469117169" TEXT="Pacemaker">
<node CREATED="1457660759086" FOLDED="true" ID="ID_942425597" LINK="https://goo.gl/Wq6bqc" MODIFIED="1463383982170" TEXT="Linux Cluster Part 1 &#x2013; Install Corosync and Pacemaker on CentOS 6">
<node CREATED="1458024708145" ID="ID_30715944" MODIFIED="1458024710318" TEXT="centos"/>
<node CREATED="1457664041487" ID="ID_1700103672" LINK="http://goo.gl/fkIf6S" MODIFIED="1457665047247" TEXT="dns resolution"/>
<node CREATED="1457664348214" ID="ID_92792155" LINK="http://goo.gl/ithdN" MODIFIED="1457664686894" TEXT="NTP time synchronization"/>
<node CREATED="1457666913229" FOLDED="true" ID="ID_1596133684" MODIFIED="1460098808695" TEXT="4. Create configuration">
<node CREATED="1457666947311" ID="ID_43159069" MODIFIED="1457666948157" TEXT="sudo touch /etc/corosync/corosync.conf"/>
<node CREATED="1457666958440" ID="ID_1466213985" MODIFIED="1457666959166" TEXT="sudo vi /etc/corosync/corosync.conf"/>
</node>
<node CREATED="1458013318571" FOLDED="true" ID="ID_1022062070" MODIFIED="1460098808695" TEXT="5. Generate Auth Key">
<node CREATED="1458013421691" ID="ID_522739596" MODIFIED="1458013508600" TEXT="sudo corosync-keygen"/>
<node CREATED="1458013490587" ID="ID_1033591875" MODIFIED="1458013590856" TEXT="/etc/corosync/authkey"/>
<node CREATED="1458013814467" ID="ID_196227359" MODIFIED="1458013815584" TEXT="Transfer the &#x201c;/etc/corosync/authkey&#x201d; file to the second Linux Cluster node."/>
</node>
<node CREATED="1458021965399" ID="ID_1372770679" MODIFIED="1458021966433" TEXT="6. Start Corosync service on both nodes"/>
<node CREATED="1458024069068" ID="ID_1115503411" MODIFIED="1458024070728" TEXT="7. Start Pacemaker service on both nodes"/>
<node CREATED="1458024650169" FOLDED="true" ID="ID_331308754" MODIFIED="1463383982169" TEXT="8. Check cluster status">
<node CREATED="1458024633657" FOLDED="true" ID="ID_1259195051" MODIFIED="1463383932781" TEXT="CRM Shell">
<node CREATED="1458024220988" ID="ID_787790262" LINK="https://goo.gl/UiwDi2" MODIFIED="1458024279708" TEXT="RHEL 6.6 doesn&apos;t have crm utility anymore. Now it has crm_mon"/>
<node CREATED="1458024253601" ID="ID_1444016476" LINK="#ID_397691262" MODIFIED="1458197612920" TEXT="crm_mon"/>
<node CREATED="1458024881544" FOLDED="true" ID="ID_762230966" LINK="http://goo.gl/D96By4" MODIFIED="1463383982168" TEXT="Red Hat has switched to use pcs (Pacemaker Configuration System)">
<icon BUILTIN="info"/>
<node CREATED="1458025175734" ID="ID_430411125" MODIFIED="1458025183071" TEXT="crm shell now has its own project"/>
<node CREATED="1458026448803" ID="ID_648062749" LINK="#ID_931109728" MODIFIED="1458026455860" TEXT="The CRM Shell"/>
</node>
<node CREATED="1458024922880" FOLDED="true" ID="ID_1743688306" LINK="#ID_1679354590" MODIFIED="1463383982168" TEXT="pcs">
<node CREATED="1458024925473" ID="ID_1910290205" MODIFIED="1458024926131" TEXT="is a corosync and pacemaker configuration tool"/>
<node CREATED="1458033654022" ID="ID_159503322" LINK="http://goo.gl/JKZeRB" MODIFIED="1458033673292" TEXT="pcs is now also available on RHEL-6."/>
</node>
<node CREATED="1458032893996" ID="ID_174629155" LINK="http://goo.gl/fCzHvS" MODIFIED="1458033053627" TEXT="#745219 - crmsh should depends on python-yaml "/>
</node>
<node CREATED="1458025622353" FOLDED="true" ID="ID_931109728" LINK="http://goo.gl/OuShqG" MODIFIED="1460098808700" TEXT="The CRM Shell">
<node CREATED="1458025669634" FOLDED="true" ID="ID_1835442066" LINK="https://goo.gl/IZ5QmZ" MODIFIED="1460098808697" TEXT="packages">
<node CREATED="1458026661113" ID="ID_55769722" MODIFIED="1458026664614" TEXT="2.x"/>
</node>
<node CREATED="1458026413817" ID="ID_514602907" LINK="http://goo.gl/yN1GxQ" MODIFIED="1458026432222" TEXT="Install CRMSH on CentOS 6">
<icon BUILTIN="info"/>
</node>
<node CREATED="1458026597946" ID="ID_185292496" MODIFIED="1458026600517" TEXT="howto"/>
<node CREATED="1458026621521" FOLDED="true" ID="ID_109833855" LINK="http://goo.gl/WtD73r" MODIFIED="1460098808700" TEXT="Documentation">
<node CREATED="1458026691145" FOLDED="true" ID="ID_1020160735" LINK="http://goo.gl/0UDVNF" MODIFIED="1460098808699" TEXT="Getting Started">
<node CREATED="1458027345369" ID="ID_613607407" LINK="http://goo.gl/kxLgBc" MODIFIED="1458027373776" TEXT="does this by invoking ssh"/>
<node CREATED="1458029976243" FOLDED="true" ID="ID_1160892021" LINK="http://goo.gl/kxLgBc" MODIFIED="1460098808698" TEXT="enables SSH to connect without prompting for a password between the nodes. ">
<node CREATED="1458031094260" ID="ID_1771422951" MODIFIED="1458031098536" TEXT="steps"/>
</node>
<node CREATED="1458030332603" FOLDED="true" ID="ID_1371121346" MODIFIED="1460098808698" TEXT="quorum">
<icon BUILTIN="help"/>
<node CREATED="1458030384843" ID="ID_451299240" MODIFIED="1458030386057" TEXT="to manage quorum"/>
</node>
</node>
</node>
<node CREATED="1458036979775" ID="ID_788735041" LINK="http://goo.gl/KjZsff" MODIFIED="1458036997352" TEXT="man"/>
<node CREATED="1458037920535" ID="ID_605275048" LINK="https://goo.gl/3B46kE" MODIFIED="1458037933235" TEXT="crmsh does not install on red hat.  "/>
<node CREATED="1458123823790" ID="ID_1735848367" LINK="http://goo.gl/qQoKa2" MODIFIED="1458123847004" TEXT="make the transition there is a quick reference guide"/>
</node>
</node>
</node>
<node CREATED="1457661195301" ID="ID_429341993" LINK="https://goo.gl/SAa6bo" MODIFIED="1458185075938" TEXT="Linux Cluster Part 2 &#x2013; Adding and Deleting Cluster Resources"/>
<node CREATED="1458125149676" FOLDED="true" ID="ID_984055762" LINK="http://goo.gl/JKZeRB" MODIFIED="1491469117167" TEXT="Pacemaker on RHEL6.4">
<icon BUILTIN="button_ok"/>
<node CREATED="1458125136527" ID="ID_546211822" MODIFIED="1458125137633" TEXT="Everyone is highly encouraged to switch to CMAN-based Pacemaker clusters"/>
<node CREATED="1458180735597" ID="ID_1697951622" LINK="http://goo.gl/JKZeRB" MODIFIED="1458180745902" TEXT="Status of the Plugin"/>
</node>
<node CREATED="1457690472016" ID="ID_264572168" LINK="http://goo.gl/BIY8r4" MODIFIED="1458006594453" TEXT="Install Corosync and Pacemaker On CentOS 6.5"/>
<node CREATED="1463383938492" ID="ID_1918474942" LINK="https://goo.gl/5Zy7J7" MODIFIED="1463383960919" TEXT="Configuring the Red Hat High Availability Add-On with Pacemaker">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1460103084429" FOLDED="true" ID="ID_240110358" MODIFIED="1460360674408" TEXT="mysql">
<node CREATED="1460103088717" ID="ID_1388806801" MODIFIED="1460103092076" TEXT="InnoDB"/>
</node>
<node CREATED="1458186723509" ID="ID_245665227" LINK="https://goo.gl/kyyWpN" MODIFIED="1458187293545" TEXT="Red Hat Enterprise Linux 6 Cluster Administration">
<icon BUILTIN="info"/>
</node>
<node CREATED="1458296986936" ID="ID_392731785" LINK="https://goo.gl/mJPM2K" MODIFIED="1458297002095" TEXT="Docs/howto/high availability on Centos 6.x"/>
<node CREATED="1458873865532" ID="ID_680775940" LINK="http://goo.gl/YJ2pPA" MODIFIED="1460102884961" TEXT="&#x8001;&#x7070;&#x9d28;&#x7684;&#x7b46;&#x8a18;&#x672c;: &#x3010;CentOS 6.2&#x3011;DRBD &#x5efa;&#x7acb;MySQL server HA"/>
<node CREATED="1458875727797" ID="ID_1498675153" LINK="https://goo.gl/nXZZdQ" MODIFIED="1458875740520" TEXT="Let&#x2019;s start with DRBD Management on CentOS 6 guide!">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1458180897685" FOLDED="true" ID="ID_1065610388" MODIFIED="1484016255988" TEXT="7">
<node CREATED="1458180862508" FOLDED="true" ID="ID_958831945" LINK="https://goo.gl/nlAfLJ" MODIFIED="1484648763301" TEXT="How To Set Up an Apache Active-Passive Cluster Using Pacemaker on CentOS 7">
<node CREATED="1463383797865" ID="ID_1014552449" MODIFIED="1463383800659" TEXT="centos7"/>
<node CREATED="1458181022197" ID="ID_82360027" LINK="#ID_388660941" MODIFIED="1458181351259" TEXT="pcs cluster shell"/>
<node CREATED="1463383757657" ID="ID_555424695" LINK="https://goo.gl/dNM3Ed" MODIFIED="1463383794538" TEXT="ensure at boot"/>
</node>
<node CREATED="1458873523260" ID="ID_791386929" LINK="https://goo.gl/KtwzXV" MODIFIED="1458873534749" TEXT="Active/Passive MySQL High Availability Pacemaker Cluster with DRBD on CentOS 7"/>
</node>
</node>
<node CREATED="1458872022923" ID="ID_987617484" LINK="http://goo.gl/ygsE20" MODIFIED="1458872045542" TEXT="Active/Passive Cluster with Pacemaker, Corosync"/>
</node>
</node>
<node CREATED="1486104119792" FOLDED="true" ID="ID_205075432" LINK="../networking.mm#ID_252046688" MODIFIED="1486105908382" POSITION="left" TEXT="ntpd">
<node CREATED="1486104360000" ID="ID_1612972189" LINK="https://goo.gl/T9ha6L" MODIFIED="1486104461662" TEXT=" much better to have a specified set of servers"/>
<node CREATED="1486104378944" ID="ID_694435531" LINK="https://goo.gl/T9ha6L" MODIFIED="1486104459636" TEXT="each with their own unique IP address,"/>
<node CREATED="1486104387031" ID="ID_646914530" LINK="https://goo.gl/T9ha6L" MODIFIED="1486104457738" TEXT=" and configure the clients to connect to multiple servers in this set"/>
<node CREATED="1486104410327" ID="ID_1718817702" LINK="https://goo.gl/T9ha6L" MODIFIED="1486104454975" TEXT="and then let the clients deal with the issues of what happens"/>
<node CREATED="1486104422655" ID="ID_825537126" LINK="https://goo.gl/T9ha6L" MODIFIED="1486104452421" TEXT=" when one or more of their servers becomes unreachable or unreliable"/>
</node>
<node CREATED="1464234806717" ID="ID_895802505" MODIFIED="1534474740068" POSITION="left" TEXT="labs / instances">
<node CREATED="1443754201378" FOLDED="true" ID="ID_409860252" MODIFIED="1486105908414" TEXT="32 bit centos67 minimal">
<node CREATED="1443754212759" MODIFIED="1443755243186" TEXT="root / apexx1234"/>
<node CREATED="1464234576861" ID="ID_1303238287" LINK="#ID_1190703486" MODIFIED="1464234585096" TEXT="instances"/>
</node>
<node CREATED="1443755280240" ID="ID_1190703486" MODIFIED="1534474741609" TEXT="instances">
<node CREATED="1443755252208" FOLDED="true" ID="ID_1020100087" MODIFIED="1484648763311" TEXT="c67minimal32bit">
<node CREATED="1443755296919" MODIFIED="1443755302342" TEXT="original"/>
<node CREATED="1444188074126" LINK="http://goo.gl/7EjAIO" MODIFIED="1444188090909" TEXT="Ethernet interfaces are not enabled by default."/>
<node CREATED="1449214683842" ID="ID_136481554" LINK="#ID_280523684" MODIFIED="1449214688992" TEXT="c67minimal32bit"/>
</node>
<node CREATED="1443756664450" FOLDED="true" ID="ID_1391524246" MODIFIED="1483929770313" TEXT="cent66clone">
<node CREATED="1443756735784" FOLDED="true" ID="ID_1884022288" MODIFIED="1484648763312" TEXT="networking">
<node CREATED="1443757388200" LINK="http://goo.gl/bguXQ9" MODIFIED="1443757401353" TEXT="configure manually"/>
<node CREATED="1443757821057" LINK="https://goo.gl/vE33U6" MODIFIED="1443757835703" TEXT="Edit /etc/resolv.conf and add the line `nameserver 8.8.8.8`"/>
</node>
<node CREATED="1443756672416" LINK="http://goo.gl/ithdN" MODIFIED="1443757847294" TEXT="ntp"/>
<node CREATED="1465352040128" FOLDED="true" ID="ID_165180473" MODIFIED="1484648763312" TEXT="user">
<node CREATED="1465352043196" ID="ID_1161475089" MODIFIED="1465352049747" TEXT="root/apexx1234"/>
<node CREATED="1444121411373" FOLDED="true" ID="ID_244985544" MODIFIED="1484648763312" TEXT="add user apexx">
<node CREATED="1444480394000" MODIFIED="1444480394973" TEXT="Add a User and Grant Root Privileges on CentOS 6.5"/>
<node CREATED="1444480402385" LINK="tux/centos.mm" MODIFIED="1444480419444" TEXT="add as sudoer"/>
</node>
</node>
<node CREATED="1443758018266" ID="ID_987099161" MODIFIED="1444122889301" TEXT="ssh"/>
<node CREATED="1444123317438" FOLDED="true" ID="ID_766426139" LINK="../networking.mm" MODIFIED="1484648763312" TEXT="httpd">
<node CREATED="1444123857159" LINK="http://goo.gl/h2K99H" MODIFIED="1444190315952" TEXT="fully qualified domain name"/>
<node CREATED="1444190316997" MODIFIED="1444190323688" TEXT="service iptables stop"/>
</node>
<node CREATED="1444188784920" FOLDED="true" ID="ID_913840763" MODIFIED="1484648763313" TEXT="mysql">
<node CREATED="1444190617462" LINK="https://goo.gl/iJdH7z" MODIFIED="1444190626653" TEXT="start at boot"/>
</node>
<node CREATED="1444190672925" MODIFIED="1444190676827" TEXT="iptables"/>
<node CREATED="1444190677165" FOLDED="true" ID="ID_269308223" MODIFIED="1484648763313" TEXT="selinux">
<node CREATED="1444190681157" LINK="https://goo.gl/rxlEQo" MODIFIED="1444190696831" TEXT="status"/>
<node CREATED="1444190723149" FOLDED="true" ID="ID_1759744985" MODIFIED="1484648763313" TEXT="disable at boot">
<node CREATED="1444190772773" LINK="http://goo.gl/nzjqyL" MODIFIED="1444190783731" TEXT="set it in /etc/selinux/config"/>
</node>
</node>
<node CREATED="1445571383866" FOLDED="true" ID="ID_1843947128" MODIFIED="1466752398539" TEXT="notes">
<node CREATED="1445571387533" FOLDED="true" ID="ID_122861584" MODIFIED="1466752398539" TEXT="release to tatung as 20151030 ha base">
<node CREATED="1445571827805" LINK="#ID_1381132607" MODIFIED="1445571834736" TEXT="tt206"/>
<node CREATED="1445571623307" LINK="tatung.mm" MODIFIED="1446088974786" TEXT="tt206ha"/>
<node CREATED="1445571629629" LINK="tatung.mm#ID_1866268440" MODIFIED="1445571762531" TEXT="tt207"/>
<node CREATED="1445571798861" LINK="#ID_513723159" MODIFIED="1445571803760" TEXT="tt207"/>
</node>
<node CREATED="1446436947017" LINK="ippbx.mm#ID_1098372858" MODIFIED="1446436983126" TEXT="auto - installation development"/>
</node>
<node CREATED="1445571426341" ID="ID_572963030" LINK="#ID_432067421" MODIFIED="1445571463184" TEXT="cent66clone"/>
<node CREATED="1470194813407" FOLDED="true" ID="ID_1884803648" MODIFIED="1484648763314" TEXT="c6x32b-dev.ova">
<node CREATED="1470194817877" ID="ID_1242228267" LINK="../tatung.mm" MODIFIED="1470194843886" TEXT="release to tatung as development environment"/>
<node CREATED="1470194942532" ID="ID_435662157" LINK="#ID_1884803648" MODIFIED="1470194947085" TEXT="c6x32b-dev.ova"/>
</node>
</node>
<node CREATED="1444620119167" ID="ID_1806350964" MODIFIED="1536114475981" TEXT="c67_32b_drbd_1012">
<node CREATED="1444618495099" MODIFIED="1444618506676" TEXT="20151012"/>
<node CREATED="1444618508547" MODIFIED="1444618510268" TEXT="231"/>
<node CREATED="1444484088090" FOLDED="true" ID="ID_1886989764" MODIFIED="1460098808677" TEXT="version">
<node CREATED="1445394904093" LINK="#ID_323780272" MODIFIED="1445394910775" TEXT="heartbeat 3.0.4"/>
</node>
</node>
<node CREATED="1445279341176" ID="ID_1988017981" MODIFIED="1536114477766" TEXT="heartbeat 3.0.4">
<node CREATED="1444618250842" MODIFIED="1444618271724" TEXT="development machine vs release template?">
<icon BUILTIN="idea"/>
<icon BUILTIN="help"/>
</node>
<node CREATED="1444618273763" FOLDED="true" ID="ID_1730508740" MODIFIED="1465351521791" TEXT="231">
<node CREATED="1445281727577" LINK="tux/centos.mm#ID_155048549" MODIFIED="1445399831971" TEXT="alias ip / virtual ip"/>
<node CREATED="1444479610049" FOLDED="true" ID="ID_1179403200" LINK="http://goo.gl/SCvZHF" MODIFIED="1460098808677" TEXT="&#x4f7f;&#x7528;heartbeat&#x5f8c;&#xff0c;&#x6211;&#x5011;&#x5c07;&#x6703;&#x6709;&#x4e00;&#x500b;&#x63d0;&#x4f9b;&#x670d;&#x52d9;&#x7684;&#x865b;&#x64ec;IP">
<node CREATED="1445078915673" MODIFIED="1445078922877" TEXT="alias ip"/>
</node>
</node>
<node CREATED="1445078720582" FOLDED="true" ID="ID_263858611" MODIFIED="1466752398540" TEXT="232">
<node CREATED="1445278853407" FOLDED="true" ID="ID_1778226088" MODIFIED="1465352094494" TEXT="n1">
<node CREATED="1445917883041" FOLDED="true" ID="ID_896863429" LINK="#ID_1286022566" MODIFIED="1460098808678" TEXT="/dev/sdb added">
<node CREATED="1447985528328" MODIFIED="1447985533471" TEXT="/dev/sdb1"/>
<node CREATED="1447985536632" LINK="http://goo.gl/tTZsbQ" MODIFIED="1447985558126" TEXT="mkfs.ext4"/>
</node>
<node CREATED="1447931718414" FOLDED="true" ID="ID_1564251262" LINK="tux/centos.mm#ID_1656472378" MODIFIED="1460098808679" TEXT="Install EL Repository">
<node CREATED="1447986126551" MODIFIED="1447986127637" TEXT="/etc/drbd.conf"/>
</node>
</node>
</node>
<node CREATED="1445078722528" FOLDED="true" ID="ID_612755067" MODIFIED="1466752398541" TEXT="233">
<node CREATED="1445278857626" FOLDED="true" ID="ID_1869807269" MODIFIED="1465352092528" TEXT="n2">
<node CREATED="1445280194701" FOLDED="true" ID="ID_235586829" LINK="https://goo.gl/d6ckqa" MODIFIED="1460098808680" TEXT="Switch eth1 and eth0">
<node CREATED="1445281207860" MODIFIED="1445281214698" TEXT="mac address as well"/>
</node>
<node CREATED="1445280658787" FOLDED="true" ID="ID_154514887" LINK="http://goo.gl/3Gj7uh" MODIFIED="1460098808681" TEXT="change hostname">
<node CREATED="1445278955317" FOLDED="true" ID="ID_31248727" MODIFIED="1460098808681" TEXT="hostname n2.apexx.com.tw">
<node CREATED="1445280462923" MODIFIED="1445280464690" TEXT="reboot"/>
</node>
<node CREATED="1445280653487" MODIFIED="1445280654399" TEXT="/etc/sysconfig/network "/>
</node>
<node CREATED="1445281059670" FOLDED="true" ID="ID_1099439306" MODIFIED="1460098808682" TEXT="change ip permanently">
<node CREATED="1445281117182" LINK="https://goo.gl/K6prpw" MODIFIED="1445281127772" TEXT="How To Configure Static IP On CentOS 6"/>
</node>
<node CREATED="1445281205208" FOLDED="true" ID="ID_273340688" MODIFIED="1460098808682" TEXT="/etc/sysconfig/network-scripts/ifcfg-eth0">
<node CREATED="1445281207860" MODIFIED="1445281214698" TEXT="mac address as well"/>
<node CREATED="1445281288416" MODIFIED="1445281291390" TEXT="change uuid"/>
</node>
<node CREATED="1445917883041" FOLDED="true" ID="ID_1439587880" LINK="#ID_1286022566" MODIFIED="1466752398541" TEXT="/dev/sdb added">
<node CREATED="1447985528328" MODIFIED="1447985533471" TEXT="/dev/sdb1"/>
<node CREATED="1447985536632" LINK="http://goo.gl/tTZsbQ" MODIFIED="1447985558126" TEXT="mkfs.ext4"/>
</node>
<node CREATED="1447931718414" LINK="tux/centos.mm#ID_1656472378" MODIFIED="1447931791771" TEXT="Install EL Repository"/>
</node>
</node>
<node CREATED="1445406966702" FOLDED="true" ID="ID_517618597" MODIFIED="1460098808686" TEXT="POC tests">
<node CREATED="1445406986739" LINK="http://goo.gl/rrHH7D" MODIFIED="1445406999645" TEXT="&#x628a;A&#x4e3b;&#x6a5f;&#x7db2;&#x8def;&#x7dda;&#x62d4;&#x6389;&#x5f8c; &#x904e;&#x5e7e;&#x5206;&#x9418; B&#x4e3b;&#x6a5f;&#x4e5f;&#x6703;&#x4e3b;&#x52d5;&#x6a21;&#x64ec;IP 192.168.1.205"/>
<node CREATED="1445407281251" FOLDED="true" ID="ID_273558724" MODIFIED="1460098808685" TEXT="start n1 only">
<node CREATED="1445407369722" MODIFIED="1445412062292" TEXT="OK"/>
</node>
<node CREATED="1445407297866" FOLDED="true" ID="ID_1676331463" MODIFIED="1460098808685" TEXT="start n2 only">
<node CREATED="1445407359939" MODIFIED="1445407362611" TEXT="NG"/>
</node>
</node>
</node>
<node CREATED="1444479689114" FOLDED="true" ID="ID_581524948" LINK="tux/centos.mm#ID_1772640511" MODIFIED="1486105908414" TEXT="drbd">
<node CREATED="1447986345256" ID="ID_1784048279" LINK="tux/centos.mm#ID_1656472378" MODIFIED="1447987917819" TEXT="DRBD: Redundant NFS Storage on CentOS 6"/>
<node CREATED="1448878922019" FOLDED="true" ID="ID_430466488" MODIFIED="1460098808687" TEXT="configure">
<node CREATED="1448878945664" ID="ID_1741326685" MODIFIED="1448878959447" TEXT="c6732n2-1130.ova"/>
<node CREATED="1448878959856" MODIFIED="1448878963339" TEXT="c6732n1-1130.ova"/>
</node>
<node CREATED="1457129673299" FOLDED="true" ID="ID_1479481670" LINK="https://goo.gl/dHn34q" MODIFIED="1460098808693" TEXT="user guide">
<node CREATED="1449542004785" FOLDED="true" ID="ID_662187818" LINK="https://goo.gl/P7Db0U" MODIFIED="1460098808692" TEXT="DRBD Features">
<icon BUILTIN="info"/>
<node CREATED="1457131285519" FOLDED="true" ID="ID_1273930119" MODIFIED="1460098808688" TEXT="operating modes">
<node CREATED="1457128537152" FOLDED="true" ID="ID_1740032955" MODIFIED="1460098808687" TEXT="single-primary mode">
<node CREATED="1457128644163" ID="ID_1974163939" MODIFIED="1457128647276" TEXT="default"/>
</node>
<node CREATED="1457128635166" FOLDED="true" ID="ID_1626972101" MODIFIED="1460098808688" TEXT="Dual-primary mode">
<node CREATED="1457129308905" ID="ID_190730960" MODIFIED="1457129312028" TEXT="preferred approach for load-balancing"/>
</node>
<node CREATED="1457129387551" ID="ID_671642050" MODIFIED="1457129389215" TEXT="Replication modes"/>
</node>
<node CREATED="1457131275490" FOLDED="true" ID="ID_635617799" MODIFIED="1460098808689" TEXT="protocols">
<icon BUILTIN="help"/>
<node CREATED="1457131333158" ID="ID_1029495393" MODIFIED="1457131334329" TEXT="A"/>
<node CREATED="1457131334880" ID="ID_1288482946" MODIFIED="1457131335816" TEXT="B"/>
<node CREATED="1457131338654" ID="ID_1013449489" MODIFIED="1457131339466" TEXT="C"/>
</node>
<node CREATED="1457130029694" ID="ID_1265200389" MODIFIED="1457130040499" TEXT="replication vs. synchronization"/>
<node CREATED="1457130145014" FOLDED="true" ID="ID_385779957" MODIFIED="1460098808689" TEXT="On-line device verification">
<node CREATED="1457130167423" ID="ID_1216540994" MODIFIED="1457130180187" TEXT="block by block integrity check"/>
<node CREATED="1457130149709" ID="ID_1116738713" MODIFIED="1457130157436" TEXT="digest"/>
</node>
<node CREATED="1457130941978" FOLDED="true" ID="ID_487877495" MODIFIED="1460098808691" TEXT="network">
<node CREATED="1457130340244" ID="ID_575209106" MODIFIED="1457130371625" TEXT="message transmission using digest algorithms"/>
<node CREATED="1457130437596" FOLDED="true" ID="ID_1602323009" MODIFIED="1460098808690" TEXT="Split brain">
<node CREATED="1457130455292" ID="ID_977224914" LINK="https://goo.gl/GVk0AI" MODIFIED="1457130517491" TEXT="both nodes switched to the primary role while disconnected."/>
<node CREATED="1457130564742" ID="ID_913177932" MODIFIED="1457130565614" TEXT="automatic operator notification"/>
<node CREATED="1457130689440" FOLDED="true" ID="ID_614650970" MODIFIED="1460098808690" TEXT="recovery">
<node CREATED="1457130694500" ID="ID_1725306968" MODIFIED="1457130695437" TEXT="younger primary"/>
<node CREATED="1457130695838" ID="ID_1748344786" MODIFIED="1457130702236" TEXT="older primary"/>
<node CREATED="1457130703660" ID="ID_434490413" MODIFIED="1457130708238" TEXT="fewer change"/>
<node CREATED="1457130708527" ID="ID_256804623" MODIFIED="1457130711926" TEXT="no change"/>
</node>
</node>
</node>
<node CREATED="1457130960500" FOLDED="true" ID="ID_1368072842" MODIFIED="1460098808691" TEXT="disk">
<node CREATED="1457130815799" ID="ID_807425213" MODIFIED="1457130816549" TEXT="disk flushes"/>
<node CREATED="1457130934085" ID="ID_848591106" MODIFIED="1457130935123" TEXT="Disk error handling"/>
</node>
<node CREATED="1457131182832" FOLDED="true" ID="ID_387683530" MODIFIED="1460098808691" TEXT="data">
<node CREATED="1457131186526" ID="ID_1146774752" MODIFIED="1457131191550" TEXT="inconsistent"/>
<node CREATED="1457131191848" ID="ID_1790402775" MODIFIED="1457131195543" TEXT="outdated"/>
</node>
</node>
<node CREATED="1457131437646" ID="ID_539309422" LINK="https://goo.gl/G72lpB" MODIFIED="1457131456118" TEXT="Building, installing and configuring"/>
</node>
</node>
<node CREATED="1465352422237" FOLDED="true" ID="ID_623047125" MODIFIED="1491469117178" TEXT="ippbx/ha combo ( standalone ) version">
<node CREATED="1465352459148" ID="ID_634502139" LINK="#ID_1391524246" MODIFIED="1465352466053" TEXT="cent66clone"/>
</node>
</node>
</node>
<node CREATED="1489644075549" ID="ID_1439766358" LINK="https://goo.gl/Abc7z6" MODIFIED="1489644316021" POSITION="left" TEXT="Alert Agent7.6. Writing an Alert Agent">
<icon BUILTIN="help"/>
</node>
<node CREATED="1486104106856" ID="ID_413159171" MODIFIED="1486104108534" POSITION="right" TEXT="5.3.6. High Availability"/>
<node CREATED="1487646348689" FOLDED="true" ID="ID_71470920" MODIFIED="1492670575338" POSITION="right" TEXT="crmd">
<node CREATED="1487646460223" FOLDED="true" ID="ID_1785420805" MODIFIED="1488961488598" TEXT="source">
<node CREATED="1487646465882" ID="ID_580731784" LINK="https://goo.gl/GHFH1v" MODIFIED="1487646481766" TEXT="failed to retrieve meta-data"/>
</node>
</node>
<node CREATED="1489113723028" ID="ID_1158441882" MODIFIED="1489113732692" POSITION="right" TEXT="classification"/>
<node CREATED="1491430807300" FOLDED="true" ID="ID_1620532020" LINK="http://tinyurl.com/lkd5rn2" MODIFIED="1491469117191" POSITION="right" TEXT="&#x5df2;&#x7d93;&#x52a0;&#x5165;&#x4e86;cluster &#x7684;node &#x662f;&#x6700;&#x597d;&#x4e0d;&#x8981;&#x4fee;&#x6539;&#x540d;&#x7a31;, ">
<node CREATED="1491430819345" ID="ID_1571163126" LINK="http://tinyurl.com/lkd5rn2" MODIFIED="1491430833712" TEXT="&#x56e0;&#x70ba;hostname &#x662f;&#x6709;&#x642d;&#x914d;public key/private key &#x5efa;&#x5236;&#x7684;"/>
</node>
<node CREATED="1498789943921" ID="ID_504390736" MODIFIED="1498789948628" POSITION="left" TEXT="best practice">
<icon BUILTIN="idea"/>
<icon BUILTIN="help"/>
</node>
</node>
</map>

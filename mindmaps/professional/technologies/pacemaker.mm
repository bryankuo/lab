<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1444702383592" ID="ID_1501151182" LINK="ha.mm" MODIFIED="1521438330783" TEXT="Pacemaker">
<node CREATED="1457401477770" FOLDED="true" LINK="http://goo.gl/TgLRqs" MODIFIED="1486105908415" POSITION="right" TEXT="Pacemaker &#x2013; The Open Source, High Availability Cluster">
<node CREATED="1457401520654" MODIFIED="1457401521667" TEXT="an overview of Pacemaker and a tutorial on how to setup a two-node"/>
</node>
<node CREATED="1458180979181" ID="ID_997228248" MODIFIED="1534139231130" POSITION="right" TEXT="is">
<node CREATED="1458180981444" MODIFIED="1458180984348" TEXT="a cluster resource manager"/>
<node CREATED="1457340786516" MODIFIED="1457340796138" TEXT="Open Source"/>
<node CREATED="1444702687528" LINK="http://goo.gl/WqgVvJ" MODIFIED="1444702698506" TEXT="Impossible to configure automatically"/>
<node CREATED="1458195603235" ID="ID_681463666" LINK="http://goo.gl/zZvt5k" MODIFIED="1534139234792" TEXT="built on five core components">
<node CREATED="1458195612924" MODIFIED="1458195614002" TEXT="libQB"/>
<node CREATED="1458195626619" ID="ID_1655906142" MODIFIED="1458195627602" TEXT="Corosync">
<node CREATED="1534140389896" ID="ID_1094958343" LINK="https://goo.gl/i77p8V" MODIFIED="1534140410086" TEXT="to provide messaging and membership services"/>
</node>
<node CREATED="1458195683419" MODIFIED="1458195684483" TEXT="Resource agents"/>
<node CREATED="1458195693867" MODIFIED="1458195694866" TEXT="Fencing agents"/>
<node CREATED="1458195704260" MODIFIED="1458195705082" TEXT="Pacemaker itself"/>
</node>
<node CREATED="1458196508156" MODIFIED="1458196509490" TEXT="pacemakerd"/>
<node CREATED="1457338487987" LINK="http://goo.gl/BgTblB" MODIFIED="1457338517046" TEXT="SUSE is the main developer on Pacemaker High Availability"/>
</node>
<node CREATED="1458441127395" FOLDED="true" MODIFIED="1490252213016" POSITION="right" TEXT="concepts">
<node CREATED="1458441134035" FOLDED="true" LINK="http://goo.gl/NHNcpR" MODIFIED="1488961488579" TEXT="resource stickiness">
<node CREATED="1458441174681" MODIFIED="1458441176777" TEXT="controls how strongly a service prefers to stay running where it is"/>
</node>
<node CREATED="1490235138823" FOLDED="true" LINK="https://goo.gl/cmKw0Q" MODIFIED="1490252213015" TEXT="Pacemaker command line interface and GUI">
<node CREATED="1490235253664" MODIFIED="1490235262274" TEXT="written in python">
<icon BUILTIN="help"/>
</node>
<node CREATED="1490235926144" MODIFIED="1490235959265" TEXT="how pcs parsing command? can we learn from it?">
<icon BUILTIN="help"/>
<icon BUILTIN="idea"/>
</node>
</node>
</node>
<node CREATED="1457575844869" ID="ID_1381938145" LINK="http://goo.gl/zZvt5k" MODIFIED="1534140263494" POSITION="right" TEXT="features">
<node CREATED="1490237186904" ID="ID_291397862" LINK="https://goo.gl/NJXMGg" MODIFIED="1490237201245" TEXT="Pacemaker, Heartbeat, Corosync, WTF?"/>
<node CREATED="1445505402490" LINK="https://goo.gl/6gQcy3" MODIFIED="1445505455197" TEXT=" to monitor and move resources"/>
<node CREATED="1457576291179" LINK="https://goo.gl/dTuabT" MODIFIED="1457576304203" TEXT="cluster management"/>
<node CREATED="1458026770537" LINK="http://goo.gl/0UDVNF" MODIFIED="1458026783267" TEXT="main component of the stack"/>
<node CREATED="1458026820297" LINK="http://goo.gl/0UDVNF" MODIFIED="1458026841871" TEXT="allocating them to cluster nodes"/>
<node CREATED="1458026831241" FOLDED="true" LINK="http://goo.gl/0UDVNF" MODIFIED="1486105908416" TEXT="according to the rules specified in the CIB">
<node CREATED="1458026902146" FOLDED="true" MODIFIED="1484636630226" TEXT="CIB">
<icon BUILTIN="help"/>
<node CREATED="1458026919594" LINK="http://goo.gl/0UDVNF" MODIFIED="1458026928967" TEXT="an XML document maintained by Pacemaker"/>
<node CREATED="1458026940121" MODIFIED="1458026940748" TEXT="describes all cluster resources"/>
<node CREATED="1458026948521" MODIFIED="1458026949082" TEXT="their configuration"/>
<node CREATED="1458026961585" MODIFIED="1458026962199" TEXT="the constraints that decide where and how they are managed"/>
<node CREATED="1463132317614" LINK="https://goo.gl/DmW21E" MODIFIED="1463132337847" TEXT="Cluster Information Base"/>
</node>
</node>
<node CREATED="1460100793739" LINK="http://goo.gl/vihwlt" MODIFIED="1460100824027" TEXT="1.4. Types of Pacemaker Clusters"/>
<node CREATED="1490234983252" LINK="https://goo.gl/qGBSd6" MODIFIED="1490235012519" TEXT="It supports &quot;N-node&quot; clusters"/>
</node>
<node CREATED="1458196598276" FOLDED="true" MODIFIED="1487560138419" POSITION="right" TEXT="version">
<node CREATED="1458196603099" MODIFIED="1458196604234" TEXT="rpm -qi pacemaker"/>
<node CREATED="1458196617540" MODIFIED="1458196618353" TEXT="1.1.12"/>
</node>
<node CREATED="1458181728541" ID="ID_1976506080" MODIFIED="1534139225609" POSITION="right" TEXT="consists of">
<node CREATED="1457340934988" ID="ID_1304028158" MODIFIED="1534139227158" TEXT="a few components">
<node CREATED="1457340945148" MODIFIED="1457340945902" TEXT="clustering"/>
<node CREATED="1457340952948" FOLDED="true" MODIFIED="1489481944924" TEXT="fence agents">
<node CREATED="1457341401268" LINK="https://goo.gl/JeFJTp" MODIFIED="1457341481194" TEXT="split brain"/>
</node>
<node CREATED="1457340961420" FOLDED="true" MODIFIED="1466752398548" TEXT="resource agents">
<node CREATED="1457341824500" LINK="http://goo.gl/qLONhD" MODIFIED="1457341835509" TEXT="supports three types of Resource Agents">
<icon BUILTIN="help"/>
</node>
<node CREATED="1457581439893" LINK="https://goo.gl/fDmWSL" MODIFIED="1457581459589" TEXT="LVM resource agent">
<icon BUILTIN="help"/>
</node>
<node CREATED="1459246322091" MODIFIED="1459246327202" TEXT="what is it">
<icon BUILTIN="help"/>
</node>
<node CREATED="1459247306252" LINK="http://goo.gl/IaZPWW" MODIFIED="1459247369051" TEXT="should load the DRBD module when needed if it&#x2019;s not already loaded."/>
</node>
<node CREATED="1458011403279" ID="ID_979006112" LINK="#ID_881918740" MODIFIED="1458011438671" TEXT="CoroSync"/>
<node CREATED="1458185495542" LINK="http://goo.gl/QiMrbC" MODIFIED="1458194413469" TEXT="crm_resource"/>
</node>
<node CREATED="1460100884024" LINK="http://goo.gl/HqYZOn" MODIFIED="1460100921902" TEXT="1.3.1. Internal Components"/>
</node>
<node CREATED="1459246289044" FOLDED="true" MODIFIED="1486105908417" POSITION="right" TEXT="supports">
<node CREATED="1459246294139" MODIFIED="1459246294978" TEXT="supports several classes of agents"/>
<node CREATED="1463129707670" MODIFIED="1466736341547" TEXT="three types of Resource Agents,"/>
</node>
<node CREATED="1457338502355" LINK="http://goo.gl/BgTblB" MODIFIED="1457338519420" POSITION="right" TEXT="the standard tool for high-availability clusters in all current Linux distributions"/>
<node CREATED="1458181711133" LINK="http://goo.gl/qQoKa2" MODIFIED="1458181722635" POSITION="right" TEXT="One of the most common ways to deploy Pacemaker is in a 2-node configuration."/>
<node CREATED="1457341627556" FOLDED="true" MODIFIED="1486105908418" POSITION="right" TEXT="depends on">
<node CREATED="1457341623188" LINK="#ID_235655891" MODIFIED="1457341641016" TEXT="Cluster Glue"/>
</node>
<node CREATED="1463132416373" LINK="https://goo.gl/cjzVU6" MODIFIED="1463132504686" POSITION="right" TEXT="is built on five core components"/>
<node CREATED="1457344794247" ID="ID_1948967293" LINK="http://goo.gl/MEgybR" MODIFIED="1534140266575" POSITION="right" TEXT="Clustering with DRBD, Corosync and Pacemaker">
<icon BUILTIN="info"/>
<node CREATED="1457344806013" LINK="#ID_1285225582" MODIFIED="1463111506053" TEXT="DRBD"/>
</node>
<node CREATED="1489141189413" LINK="https://goo.gl/6zIOKm" MODIFIED="1489141205211" POSITION="right" TEXT="cluster resource managers "/>
<node CREATED="1457574278977" FOLDED="true" MODIFIED="1486105908418" POSITION="right" TEXT="configuration">
<node CREATED="1458518207377" FOLDED="true" LINK="http://goo.gl/NrxL1K" MODIFIED="1484648763317" TEXT="Configuration Explained ">
<node CREATED="1458518233387" FOLDED="true" MODIFIED="1484648763317" TEXT="Ed. 6">
<node CREATED="1458518264735" LINK="http://goo.gl/LmGDWY" MODIFIED="1458518271641" TEXT="internal"/>
</node>
</node>
</node>
<node CREATED="1457571318261" LINK="http://goo.gl/8rkuQo" MODIFIED="1457571332454" POSITION="right" TEXT="FAQ"/>
<node CREATED="1457668675172" FOLDED="true" LINK="https://goo.gl/dTuabT" MODIFIED="1486105908418" POSITION="right" TEXT="HA Cluster with Linux Containers based on Heartbeat, Pacemaker, DRBD and LXC">
<node CREATED="1458181507525" MODIFIED="1458181509771" TEXT="Ubuntu 12.04 LTS"/>
</node>
<node CREATED="1458034414789" FOLDED="true" LINK="http://goo.gl/59qLB3" MODIFIED="1491469117179" POSITION="right" TEXT="QUICKSTART">
<node CREATED="1458185110078" FOLDED="true" LINK="http://goo.gl/hcE8P3" MODIFIED="1484648763318" TEXT="Add Apache as a Cluster Service">
<node CREATED="1458185208814" MODIFIED="1458185209795" TEXT=" the resource agent used by Pacemaker assumes the server-status URL is available."/>
<node CREATED="1484636836177" LINK="https://goo.gl/WRgZij" MODIFIED="1484636860365" TEXT="server-status"/>
<node CREATED="1458185739438" LINK="http://goo.gl/tKGjL9" MODIFIED="1458185757717" TEXT=" Enable the Apache status URL"/>
<node CREATED="1458193007355" LINK="http://goo.gl/aNqbkd" MODIFIED="1458193026949" TEXT=" Configure the Cluster"/>
</node>
</node>
<node CREATED="1458179137453" FOLDED="true" LINK="#ID_878912311" MODIFIED="1488961488580" POSITION="right" TEXT="Clusters from Scratch guide">
<node CREATED="1458179165172" MODIFIED="1458179166154" TEXT="General Concepts"/>
</node>
<node CREATED="1458197719221" FOLDED="true" MODIFIED="1492670575330" POSITION="right" TEXT="tools">
<node CREATED="1458024251152" FOLDED="true" MODIFIED="1492670575330" TEXT="crm">
<icon BUILTIN="help"/>
<node CREATED="1458030228995" MODIFIED="1458030232346" TEXT="--version"/>
<node CREATED="1458030232731" MODIFIED="1458032742042" TEXT="cluster init nodes=tt207,n1"/>
<node CREATED="1458032725967" MODIFIED="1458032730082" TEXT="status"/>
<node CREATED="1492669914186" MODIFIED="1492669920072" TEXT="crm shell vs pcs"/>
</node>
<node CREATED="1458197583515" MODIFIED="1458197588212" TEXT="crm_mon"/>
<node CREATED="1458199980525" FOLDED="true" MODIFIED="1484648763321" TEXT="Two popular command-line shells are pcs and crmsh">
<node CREATED="1458199985941" LINK="#ID_1259195051" MODIFIED="1458199996752" TEXT="crmsh"/>
<node CREATED="1458200006613" LINK="#ID_1679354590" MODIFIED="1458200047446" TEXT="pcs"/>
</node>
<node CREATED="1458202019358" FOLDED="true" MODIFIED="1491469117183" TEXT="ccs">
<node CREATED="1458202041678" MODIFIED="1458202042868" TEXT="Cluster Configuration System"/>
<node CREATED="1458202044342" LINK="http://goo.gl/TrGcbt" MODIFIED="1458202054794" TEXT="man page"/>
<node CREATED="1458123217207" FOLDED="true" MODIFIED="1491469117180" TEXT="/etc/cluster/cluster.conf">
<node CREATED="1459244523867" LINK="https://goo.gl/mwGBC2" MODIFIED="1459244538118" TEXT="--setfencedaemon post_join_delay"/>
</node>
<node CREATED="1491430694065" LINK="http://tinyurl.com/lwqwuek" MODIFIED="1491430709623" TEXT="ccsd - manages the /etc/cluster/cluster.conf file "/>
<node CREATED="1491430084220" FOLDED="true" LINK="http://tinyurl.com/mtpsw43" MODIFIED="1491469117180" TEXT="Re: [Linux-cluster] Two clusters in the network with same &quot;name&quot; in cluster.conf">
<node CREATED="1491430102832" LINK="http://tinyurl.com/mtpsw43" MODIFIED="1491430151305" TEXT="RAELLY need two clusters with the same name on the same subnet"/>
<node CREATED="1491430118846" LINK="http://tinyurl.com/mtpsw43" MODIFIED="1491430149220" TEXT="/Multicast network configuration/"/>
<node CREATED="1491430129029" LINK="http://tinyurl.com/mtpsw43" MODIFIED="1491430147185" TEXT="/Cluster ID/"/>
</node>
<node CREATED="1491451071492" FOLDED="true" LINK="https://goo.gl/7yzwcI" MODIFIED="1491469117181" TEXT="[Pacemaker] Multiple independent two-node clusters side-by-side?">
<node CREATED="1491451114096" MODIFIED="1491451114905" TEXT="You need to specify different multicast sockets for this to work"/>
</node>
<node CREATED="1491459374321" FOLDED="true" MODIFIED="1491469117182" TEXT="cman_tool">
<node CREATED="1491459380128" MODIFIED="1491459381956" TEXT="status"/>
<node CREATED="1491459891640" LINK="https://goo.gl/0lk0LF" MODIFIED="1491459934492" TEXT="cluster ID"/>
<node CREATED="1491459918608" LINK="https://goo.gl/0lk0LF" MODIFIED="1491459931291" TEXT="6.14.2. Multicast Configuration"/>
</node>
</node>
</node>
<node CREATED="1463384447077" MODIFIED="1463384457736" POSITION="right" TEXT="Receiving Notification for Cluster Events">
<icon BUILTIN="help"/>
</node>
<node CREATED="1484115698496" ID="ID_1739837213" MODIFIED="1534497424517" POSITION="right" TEXT="the default for STONITH [6] in Pacemaker is enabled">
<node CREATED="1488961617709" LINK="https://goo.gl/EgSC6I" MODIFIED="1488961633913" TEXT="Define stonith (Shoot The Other Node In The Head) fencing device"/>
<node CREATED="1489566759765" FOLDED="true" LINK="https://goo.gl/Y1kuA7" MODIFIED="1489567104879" TEXT="to avoid">
<node CREATED="1489566802971" MODIFIED="1489566803639" TEXT=" shared memory corruption"/>
<node CREATED="1489566776202" MODIFIED="1489566776904" TEXT="split brain status"/>
</node>
<node CREATED="1489566793978" MODIFIED="1489566795981" TEXT="and most make sure that your cluster does not get stuck in recovery or crash"/>
</node>
<node CREATED="1484641196034" MODIFIED="1484641196802" POSITION="right" TEXT=" Additional logging available in /var/log/pacemaker.log"/>
<node CREATED="1484646287253" ID="ID_1390593885" MODIFIED="1537934909768" POSITION="right" TEXT="ocf:pacemaker:ClusterMon">
<node CREATED="1484646314549" ID="ID_252776406" LINK="https://goo.gl/2kjj0l" MODIFIED="1484646326010" TEXT="monitor your Pacemaker cluster status and get alerted in real time on any cluster transition"/>
<node CREATED="1484646479012" LINK="https://goo.gl/ubEugn" MODIFIED="1484646489476" TEXT="8.3. Event Notification with Monitoring Resources"/>
<node CREATED="1484646639437" FOLDED="true" LINK="https://goo.gl/A4t7mZ" MODIFIED="1484648763323" TEXT="By making smart usage of these variables in your external-agent code, ">
<node CREATED="1484646649276" LINK="https://goo.gl/A4t7mZ" MODIFIED="1484646662672" TEXT="you can trigger any action."/>
</node>
<node CREATED="1488963717030" LINK="https://goo.gl/1kHgbv" MODIFIED="1488963787335" TEXT="This resource is created as a clone so that it will run on every node in the cluster."/>
<node CREATED="1488967869712" LINK="https://goo.gl/VXMA4g" MODIFIED="1488967881746" TEXT="Configuring Email Notifications"/>
</node>
<node CREATED="1484794595530" FOLDED="true" MODIFIED="1491532103531" POSITION="right" TEXT="Pacemaker 1.1">
<node CREATED="1484794605825" FOLDED="true" LINK="https://goo.gl/q5J4wZ" MODIFIED="1489563720987" TEXT="Configuration Explained">
<node CREATED="1484794664929" MODIFIED="1484794665878" TEXT="2.3. How Should the Configuration be Updated?"/>
<node CREATED="1484794685713" MODIFIED="1484794686526" TEXT="cibadmin"/>
<node CREATED="1489542941025" LINK="https://goo.gl/8vU4Tc" MODIFIED="1489544977011" TEXT="Chapter 7. Alerts ">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1486103264247" LINK="https://goo.gl/tyZuCn" MODIFIED="1486103279856" POSITION="right" TEXT="Pacemaker &#x7684;&#x8d44;&#x6e90;&#x4e3b;&#x8981;&#x6709;&#x4e24;&#x7c7b;&#xff0c;&#x5373; LSB &#x548c; OCF"/>
<node CREATED="1487314135397" MODIFIED="1487314136616" POSITION="right" TEXT="Pacemaker comes with a tool called &quot;ocf-tester&quot;"/>
<node CREATED="1487822188061" LINK="https://goo.gl/Ao3YMt" MODIFIED="1487822200592" POSITION="right" TEXT=" Pacemaker provides the brain that processes and reacts to events regarding"/>
<node CREATED="1487921408368" FOLDED="true" LINK="https://goo.gl/7DcYnu" MODIFIED="1490252213016" POSITION="right" TEXT="pacemaker pcs split brain tips best practice">
<node CREATED="1487921558047" LINK="https://goo.gl/BhDpmJ" MODIFIED="1487921568185" TEXT="Split-brain, Quorum, and Fencing - updated"/>
<node CREATED="1490177379971" LINK="https://goo.gl/xrSGwh" MODIFIED="1490177420422" TEXT="prevent split brain in the first place: use redundant  heartbeat links, "/>
<node CREATED="1490177407275" LINK="https://goo.gl/xrSGwh" MODIFIED="1490177418306" TEXT="(read: use a crossover cable), use dopd. "/>
</node>
<node CREATED="1487921505592" FOLDED="true" LINK="https://goo.gl/EdYskh" MODIFIED="1488961488582" POSITION="right" TEXT="Resource is Too Active">
<node CREATED="1487921956523" FOLDED="true" LINK="https://goo.gl/z7Gvq2" MODIFIED="1488961488582" TEXT="Real problem is that resource is *NOT* too  active, ">
<node CREATED="1487923435617" MODIFIED="1487923440757" TEXT="adding to group"/>
</node>
</node>
<node CREATED="1484632918297" FOLDED="true" LINK="https://goo.gl/EgSC6I" MODIFIED="1493360593476" POSITION="right" TEXT="Pacemaker GUI">
<icon BUILTIN="help"/>
<node CREATED="1488961726564" MODIFIED="1488961727766" TEXT="https://192.168.66.200:2224/login"/>
<node CREATED="1488961739193" FOLDED="true" MODIFIED="1490169522456" TEXT="PCSD GUI is disabled">
<node CREATED="1488961787857" LINK="https://goo.gl/sqVFuX" MODIFIED="1488961802794" TEXT="pcsd disable web gui default"/>
<node CREATED="1490000960306" LINK="https://goo.gl/PagrkF" MODIFIED="1490001027251" TEXT="Web UI is disabled by default in CentOS 6 rpm package."/>
</node>
<node CREATED="1489543956416" LINK="https://goo.gl/HnSZoi" MODIFIED="1489543979295" TEXT="steps to compile install and configure pacemaker-mgmtd on Centos6.X">
<icon BUILTIN="help"/>
</node>
<node CREATED="1490000332616" LINK="https://goo.gl/bjCqi8" MODIFIED="1490000345030" TEXT="RHEL 7 &#x2013; Accessing the Pacemaker WEB UI (GUI) &#x2013; Part 11"/>
<node CREATED="1490000609794" MODIFIED="1490000897435" TEXT="pacemaker-pygui/mgmt">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1489481935906" MODIFIED="1489481941640" POSITION="right" TEXT="advanced configuration"/>
<node CREATED="1489543292071" FOLDED="true" MODIFIED="1491469117184" POSITION="right" TEXT="C API access">
<node CREATED="1489544644667" LINK="https://goo.gl/A0J12M" MODIFIED="1489544660934" TEXT="C: Run a System Command and Get Output?"/>
</node>
<node CREATED="1490866576252" LINK="https://goo.gl/pqlazI" MODIFIED="1490866588125" POSITION="right" TEXT="Linux-HA with Pacemaker"/>
<node CREATED="1491469125864" ID="ID_1768474547" MODIFIED="1491469167656" POSITION="right" TEXT="duplicate cluster - do remember cleanup configuration">
<icon BUILTIN="idea"/>
</node>
<node CREATED="1521438337864" ID="ID_1680178440" LINK="https://goo.gl/ecDVCw" MODIFIED="1521438359243" POSITION="right" TEXT="High Availability Add-On Overview"/>
<node CREATED="1521438450741" ID="ID_819772055" LINK="https://goo.gl/CoCcjb" MODIFIED="1521438477949" POSITION="right" TEXT="High Availability Add-On Administration"/>
<node CREATED="1521440235689" ID="ID_86507220" LINK="https://goo.gl/AXivrf" MODIFIED="1521440249287" POSITION="right" TEXT="ClusterLabs  RHEL 7 Quickstart ">
<node CREATED="1521440360116" ID="ID_201028704" MODIFIED="1521440366073" TEXT="create resource"/>
</node>
<node CREATED="1521527470179" ID="ID_949318046" LINK="https://goo.gl/wsJ5ic" MODIFIED="1521527485508" POSITION="right" TEXT="pcsd WEBUi"/>
<node CREATED="1530589014365" ID="ID_1371636115" MODIFIED="1530589027202" POSITION="right" TEXT="preallocation failed"/>
<node CREATED="1531770634864" ID="ID_251221550" LINK="https://goo.gl/TDpSc7" MODIFIED="1531770687355" POSITION="right" TEXT="Can in be fixed that the drbd is entering split brain after cluster node recovery?">
<node CREATED="1531770703352" ID="ID_1322097427" MODIFIED="1531770705725" TEXT="you need to configure">
<node CREATED="1531770721359" ID="ID_1559269607" MODIFIED="1531770722985" TEXT="cluster fencing"/>
<node CREATED="1531770738185" ID="ID_1509935910" MODIFIED="1531770739691" TEXT="and drbd fencing handler,"/>
<node CREATED="1531770751922" ID="ID_934217190" MODIFIED="1531770753234" TEXT="in this way, the cluster can recevory without manual intervention."/>
</node>
</node>
<node CREATED="1534130602823" ID="ID_157199548" MODIFIED="1534130603674" POSITION="right" TEXT=" [TOTEM ] A processor failed, forming new configuration.">
<node CREATED="1534130572485" ID="ID_68079132" LINK="https://goo.gl/5oLx49" MODIFIED="1534130586119" TEXT="a node was declared lost and was removed from the cluster."/>
</node>
<node CREATED="1534143050883" ID="ID_1543866810" LINK="https://goo.gl/hAZLM2" MODIFIED="1534143067865" POSITION="right" TEXT="Configuration Explained"/>
<node CREATED="1458181316566" ID="ID_1679354590" LINK="https://goo.gl/EwTCxp" MODIFIED="1534471630469" POSITION="left" TEXT="pcs">
<node CREATED="1463132483053" ID="ID_1261267846" LINK="https://goo.gl/hzS8HJ" MODIFIED="1534473450006" TEXT="Pacemaker/Corosync Configuration System"/>
<node CREATED="1484101431705" ID="ID_423063294" MODIFIED="1484101433022" TEXT="Control and configure pacemaker and corosync"/>
<node CREATED="1486003134721" FOLDED="true" ID="ID_607696054" LINK="https://goo.gl/cmKw0Q" MODIFIED="1499844888656" TEXT="pacemaker configuration system">
<node CREATED="1488881544692" ID="ID_1504422417" LINK="https://goo.gl/XKIFdK" MODIFIED="1488881557300" TEXT="pcs - pacemaker/corosync configuration system"/>
</node>
<node CREATED="1458193523619" FOLDED="true" ID="ID_24707154" MODIFIED="1484648763319" TEXT="options">
<node CREATED="1458183427926" FOLDED="true" ID="ID_1817221625" MODIFIED="1459326861303" TEXT="version">
<node CREATED="1458183430624" ID="ID_192643003" MODIFIED="1458183431619" TEXT="1.1.11-97629de"/>
</node>
</node>
<node CREATED="1458184064614" ID="ID_1769737373" LINK="https://goo.gl/D8SQ0U" MODIFIED="1458184074164" TEXT="CHAPTER 2. THE PCS COMMAND LINE INTERFACE"/>
<node CREATED="1458193467827" ID="ID_1729799432" MODIFIED="1534497419589" TEXT="Commands">
<node CREATED="1458192930355" FOLDED="true" ID="ID_354408022" LINK="https://goo.gl/EhIXKJ" MODIFIED="1499844888656" TEXT="resource">
<node CREATED="1458193683419" ID="ID_1106662437" MODIFIED="1458193687519" TEXT="has a name"/>
<node CREATED="1458192941426" ID="ID_1447301116" MODIFIED="1458192943392" TEXT="create"/>
<node CREATED="1458286441247" FOLDED="true" ID="ID_1837667095" MODIFIED="1466752398556" TEXT="delete">
<node CREATED="1458286445023" ID="ID_778433819" MODIFIED="1458286445811" TEXT="sudo pcs resource delete WebSite"/>
</node>
<node CREATED="1458286306631" ID="ID_389470468" MODIFIED="1458286308267" TEXT="show"/>
<node CREATED="1458193401167" ID="ID_1877163184" LINK="https://goo.gl/4ZrHkv" MODIFIED="1458193414040" TEXT="enable / disable / ban"/>
<node CREATED="1458199042493" ID="ID_1979546032" MODIFIED="1458199048317" TEXT="standards"/>
<node CREATED="1458199313693" ID="ID_225245693" MODIFIED="1458199314837" TEXT="providers"/>
<node CREATED="1458199315222" ID="ID_1033846786" MODIFIED="1458199317482" TEXT="agents"/>
<node CREATED="1458441338258" FOLDED="true" ID="ID_1110167068" MODIFIED="1490252213017" TEXT="defaults">
<node CREATED="1458441341530" FOLDED="true" ID="ID_854287285" MODIFIED="1490252213017" TEXT="resource-stickiness">
<node CREATED="1458441383308" ID="ID_784628427" LINK="#ID_480037589" MODIFIED="1458441395024" TEXT="resource stickiness"/>
<node CREATED="1490171549769" ID="ID_1580470682" LINK="https://goo.gl/OeCXS7" MODIFIED="1490171568087" TEXT="How can I set resource stickiness in pacemaker?"/>
</node>
</node>
<node CREATED="1459246818172" FOLDED="true" ID="ID_1132786375" LINK="https://goo.gl/3efpoG" MODIFIED="1490252213018" TEXT="5.4. Resource Meta Options">
<icon BUILTIN="info"/>
<node CREATED="1459246782860" ID="ID_423778926" MODIFIED="1459246783965" TEXT="resource-specific parameters"/>
<node CREATED="1459246807036" ID="ID_1491086251" MODIFIED="1459246807865" TEXT="configure additional resource options"/>
</node>
<node CREATED="1459304605481" ID="ID_1753557902" LINK="https://goo.gl/tcELs2" MODIFIED="1459304650864" TEXT="Table 8.1, &#x201c;Resource Clone Options&#x201d;."/>
<node CREATED="1459304084706" FOLDED="true" ID="ID_1789324070" MODIFIED="1466752398557" TEXT="master">
<node CREATED="1459304518226" ID="ID_1006021678" LINK="https://goo.gl/BoCzgu" MODIFIED="1459304540506" TEXT="8.2. Multi-State Resources: Resources That Have Multiple Modes"/>
</node>
<node CREATED="1458194206971" FOLDED="true" ID="ID_987874803" MODIFIED="1484640955433" TEXT="constraint">
<node CREATED="1458194315924" FOLDED="true" ID="ID_292506386" MODIFIED="1459326861312" TEXT="location">
<node CREATED="1458441722578" FOLDED="true" ID="ID_1009462663" LINK="#ID_30838868" MODIFIED="1459326861311" TEXT="prefers">
<node CREATED="1458442039696" ID="ID_1219267341" LINK="#ID_277257946" MODIFIED="1458442258281" TEXT="6.8. Move Resources Manually"/>
</node>
</node>
<node CREATED="1458441586275" FOLDED="true" ID="ID_1830701584" MODIFIED="1459326861312" TEXT="order">
<node CREATED="1458441616313" ID="ID_745377106" LINK="http://goo.gl/LkWBLT" MODIFIED="1458441636485" TEXT="6.6. Ensure Resources Start and Stop in Order"/>
</node>
<node CREATED="1458442128220" FOLDED="true" ID="ID_591726726" MODIFIED="1484648763319" TEXT="colocation">
<node CREATED="1458442129997" ID="ID_1080330436" MODIFIED="1458442133186" TEXT="add"/>
<node CREATED="1458442147899" ID="ID_77020582" LINK="#ID_1870858892" MODIFIED="1458442173324" TEXT="6.5. Ensure Resources Run on the Same Host"/>
</node>
<node CREATED="1458442292477" ID="ID_103955769" MODIFIED="1458442293251" TEXT="--full"/>
</node>
<node CREATED="1484640925098" ID="ID_1656086279" LINK="https://goo.gl/veh3kB" MODIFIED="1484640952625" TEXT="ocf_heartbeat_apache"/>
</node>
<node CREATED="1458198151733" FOLDED="true" ID="ID_156020021" MODIFIED="1463383982178" TEXT="cluster">
<node CREATED="1459247187932" ID="ID_1321057814" LINK="https://goo.gl/3shnjS" MODIFIED="1459247206668" TEXT="CHAPTER 3. CLUSTER CREATION AND ADMINISTRATION">
<icon BUILTIN="info"/>
</node>
<node CREATED="1458288680703" ID="ID_833090531" MODIFIED="1458288683501" TEXT="create"/>
<node CREATED="1458288683936" ID="ID_1790531314" MODIFIED="1458288686561" TEXT="destroy"/>
<node CREATED="1458183966190" FOLDED="true" ID="ID_1356448875" LINK="https://goo.gl/JhHf7p" MODIFIED="1459326861307" TEXT="status">
<node CREATED="1458184024406" ID="ID_1795002004" LINK="https://goo.gl/JhHf7p" MODIFIED="1458184031910" TEXT="HIGH AVAILABILITY ADD-ON ADMINISTRATION"/>
</node>
<node CREATED="1460099155228" ID="ID_820658155" MODIFIED="1460099156912" TEXT="cib"/>
<node CREATED="1459316371846" FOLDED="true" ID="ID_386216148" MODIFIED="1463383982177" TEXT="cib_push">
<node CREATED="1458198157597" FOLDED="true" ID="ID_1256090144" LINK="http://goo.gl/Uq3VxO" MODIFIED="1460360674423" TEXT="CIB">
<node CREATED="1459245958971" ID="ID_67524909" MODIFIED="1459245960072" TEXT="drbd_cfg"/>
<node CREATED="1459247021498" ID="ID_306533308" LINK="http://goo.gl/Uq3VxO" MODIFIED="1459247044440" TEXT="Cluster Information Base">
<icon BUILTIN="help"/>
</node>
<node CREATED="1459247077828" ID="ID_647835260" LINK="http://goo.gl/Uq3VxO" MODIFIED="1459247091724" TEXT="is a set of instructions coded in XML which is synchronized across the cluster"/>
</node>
<node CREATED="1459316383519" ID="ID_1329919148" LINK="https://goo.gl/PYDxOy" MODIFIED="1459316399632" TEXT="push the current content of testfile to the CIB"/>
<node CREATED="1463378181303" ID="ID_909749470" LINK="https://goo.gl/PYDxOy" MODIFIED="1463378192432" TEXT="2.4. SAVING A CONFIGURATION CHANGE TO A FILE"/>
</node>
<node CREATED="1458199863814" FOLDED="true" ID="ID_595668669" MODIFIED="1463383982177" TEXT="start / stop">
<node CREATED="1458288104503" ID="ID_1690439394" MODIFIED="1458288107802" TEXT="start on boot?">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1460100215659" ID="ID_320390002" MODIFIED="1460100217501" TEXT="kill"/>
<node CREATED="1458288051456" ID="ID_1358289209" LINK="http://goo.gl/z0n6o4" MODIFIED="1458288075503" TEXT="auth">
<icon BUILTIN="help"/>
</node>
<node CREATED="1458288123759" ID="ID_36314482" MODIFIED="1458288125502" TEXT="setup"/>
<node CREATED="1458288616714" ID="ID_433358760" MODIFIED="1458288620120" TEXT="enable"/>
<node CREATED="1458288654184" ID="ID_1564431385" MODIFIED="1463382965009" TEXT="standby"/>
<node CREATED="1463382965481" ID="ID_1055381845" MODIFIED="1463382966895" TEXT="unstandby"/>
</node>
<node CREATED="1458193494323" FOLDED="true" ID="ID_679121558" MODIFIED="1486100843800" TEXT="property">
<node CREATED="1459324357138" ID="ID_987212668" MODIFIED="1459324357983" TEXT="stonith-enabled"/>
<node CREATED="1459324370266" ID="ID_293497928" MODIFIED="1459324371108" TEXT="no-quorum-policy"/>
<node CREATED="1459324372561" ID="ID_602529353" MODIFIED="1459324374439" TEXT="set"/>
<node CREATED="1459324603859" ID="ID_505351390" LINK="https://goo.gl/P2LQCR" MODIFIED="1459324625345" TEXT="10.3. Querying Cluster Property Settings"/>
<node CREATED="1459324762554" ID="ID_286309623" MODIFIED="1459324764111" TEXT="show"/>
</node>
<node CREATED="1458183375421" ID="ID_1966270800" MODIFIED="1458183378187" TEXT="status"/>
<node CREATED="1458292552250" FOLDED="true" ID="ID_1534647332" MODIFIED="1499844888657" TEXT="config show">
<node CREATED="1459324401386" ID="ID_644725888" LINK="http://goo.gl/hKRZ3J" MODIFIED="1459324412366" TEXT="To show the full cluster configuration"/>
</node>
<node CREATED="1463378273655" ID="ID_1353130916" LINK="https://goo.gl/D8SQ0U" MODIFIED="1463378289004" TEXT="2. THE PCS COMMAND LINE INTERFACE"/>
<node CREATED="1463378908791" ID="ID_1086375118" LINK="https://goo.gl/SXCeNO" MODIFIED="1463378931708" TEXT="ClusterLabs/pacemaker quick reference">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1463128913695" FOLDED="true" ID="ID_1003796350" MODIFIED="1466752398558" TEXT="One handy feature pcs has">
<node CREATED="1463128928758" ID="ID_1866789419" LINK="http://goo.gl/l3fsSY" MODIFIED="1463128975475" TEXT=" is the ability to queue up several changes into a file and commit those changes atomically."/>
</node>
<node CREATED="1484104188883" FOLDED="true" ID="ID_1652995589" MODIFIED="1493360661430" TEXT="cluster">
<node CREATED="1484793967571" ID="ID_52669823" MODIFIED="1484793968510" TEXT="cluster management"/>
<node CREATED="1484104242850" ID="ID_596255093" LINK="http://clusterlabs.org/doc/en-US/Pacemaker/1.1-pcs/html-single/Clusters_from_Scratch/index.html#_login_remotely#_configure_the_cluster_software" MODIFIED="1484104285042" TEXT="alternatives, such as crmsh"/>
<node CREATED="1484214297539" FOLDED="true" ID="ID_1242681693" MODIFIED="1486024217312" TEXT="sync">
<node CREATED="1484214305571" ID="ID_1048060775" LINK="https://goo.gl/nHmevp" MODIFIED="1484214316330" TEXT="Syncing the Configuration"/>
</node>
<node CREATED="1484793983186" FOLDED="true" ID="ID_576241408" MODIFIED="1488961488587" TEXT="cib">
<node CREATED="1484794009657" ID="ID_1974570911" LINK="https://goo.gl/EwTCxp" MODIFIED="1484794039868" TEXT="&#x5c07;&#x539f;&#x751f;&#x53e2;&#x96c6;&#x914d;&#x7f6e;&#x5132;&#x5b58;&#x81f3;&#x4e00;&#x500b;&#x6307;&#x5b9a;&#x7684;&#x6a94;&#x6848;&#x4e2d;"/>
<node CREATED="1484794879137" FOLDED="true" ID="ID_561739986" MODIFIED="1486024217313" TEXT="uses XML to represent">
<node CREATED="1484794895281" ID="ID_405103673" MODIFIED="1484794908270" TEXT=" both the cluster&#x2019;s configuration"/>
<node CREATED="1484794908730" ID="ID_1454356808" MODIFIED="1484794909493" TEXT="and current state of all resources in the cluster"/>
</node>
<node CREATED="1484794945729" ID="ID_1366171937" MODIFIED="1484794946622" TEXT="used by the PEngine to compute the ideal state of the cluste"/>
<node CREATED="1488880676868" FOLDED="true" ID="ID_1918307605" LINK="https://goo.gl/PYDxOy" MODIFIED="1488961488585" TEXT="previously configured a cluster">
<node CREATED="1488880688347" ID="ID_854187193" MODIFIED="1488880689064" TEXT="there is already an active CIB"/>
<node CREATED="1488880702308" ID="ID_680128636" MODIFIED="1488880703344" TEXT="to save the raw xml a file"/>
</node>
</node>
<node CREATED="1484274905693" ID="ID_1644832406" MODIFIED="1484274912077" TEXT="cib-push"/>
<node CREATED="1484797151555" ID="ID_1396930342" LINK="https://goo.gl/g8YbXk" MODIFIED="1484797184184" TEXT=" 3.8. Backing Up and Restoring a Cluster Configuration"/>
<node CREATED="1484804744414" ID="ID_1452712074" MODIFIED="1484804746435" TEXT="stop"/>
<node CREATED="1485250940033" ID="ID_206276296" MODIFIED="1485250941818" TEXT="reload"/>
<node CREATED="1486100928536" ID="ID_482838609" MODIFIED="1486100930331" TEXT="setup"/>
<node CREATED="1489564849745" FOLDED="true" ID="ID_1494233913" MODIFIED="1489567104898" TEXT="options">
<node CREATED="1489564853201" ID="ID_106188376" LINK="https://goo.gl/rNdaUM" MODIFIED="1489564864327" TEXT="no-quorum-policy"/>
<node CREATED="1489565357777" ID="ID_796394641" LINK="https://goo.gl/rNdaUM" MODIFIED="1489565368294" TEXT="3.2. Cluster Options"/>
</node>
<node CREATED="1489654807676" ID="ID_1768087000" LINK="https://goo.gl/BjyWwt" MODIFIED="1489654820807" TEXT="3.2.2. Enabling and Disabling Cluster Services"/>
<node CREATED="1484804723920" FOLDED="true" ID="ID_1693578281" LINK="https://goo.gl/f48jax" MODIFIED="1491469117186" TEXT="destroy">
<node CREATED="1491460633097" ID="ID_333159337" LINK="https://goo.gl/f48jax" MODIFIED="1491460662287" TEXT="4.6. REMOVING THE CLUSTER CONFIGURATION"/>
</node>
</node>
<node CREATED="1484213722310" FOLDED="true" ID="ID_1156180754" MODIFIED="1518158664858" TEXT="resource">
<node CREATED="1489563903408" ID="ID_239771430" LINK="https://goo.gl/3efpoG" MODIFIED="1489563917581" TEXT="5.4. Resource Meta Options"/>
<node CREATED="1484214281579" ID="ID_534390107" LINK="https://goo.gl/nHmevp" MODIFIED="1484214319376" TEXT="group"/>
<node CREATED="1484215066724" ID="ID_723241856" LINK="https://goo.gl/Bhh12o" MODIFIED="1484215080261" TEXT="5.3. Resource-Specific Parameters"/>
<node CREATED="1484215365877" FOLDED="true" ID="ID_934562883" MODIFIED="1484648763320" TEXT="master">
<node CREATED="1484215493060" ID="ID_994075268" LINK="https://goo.gl/BoCzgu" MODIFIED="1484215505561" TEXT="8.2. Multi-State Resources"/>
</node>
<node CREATED="1484215369428" ID="ID_1300618928" MODIFIED="1484215370392" TEXT="clone"/>
<node CREATED="1484215871508" ID="ID_1291337992" LINK="https://goo.gl/8adH5a" MODIFIED="1484215884137" TEXT="However we also need to manage configuration files instead of data"/>
<node CREATED="1484276309570" ID="ID_922998656" LINK="https://goo.gl/s3Zl3T" MODIFIED="1484276498536" TEXT="delete orphan resource"/>
<node CREATED="1484293923074" FOLDED="true" ID="ID_1786339307" MODIFIED="1484648763320" TEXT="filesystem">
<node CREATED="1484293936146" FOLDED="true" ID="ID_346252380" MODIFIED="1484648763320" TEXT="mount options">
<node CREATED="1484293940922" ID="ID_761058275" LINK="https://goo.gl/EZLvtN" MODIFIED="1484293946494" TEXT="defaults"/>
</node>
</node>
<node CREATED="1458875791732" ID="ID_614370246" MODIFIED="1458875797410" TEXT="enable/disable"/>
<node CREATED="1458875797700" ID="ID_1836645934" MODIFIED="1458875806762" TEXT="connect/disconnect"/>
<node CREATED="1463123223275" ID="ID_1243512007" MODIFIED="1463123225297" TEXT="role"/>
<node CREATED="1485245835299" FOLDED="true" ID="ID_496277982" MODIFIED="1486024217328" TEXT="enumeration">
<node CREATED="1484215571228" ID="ID_1243039820" LINK="https://goo.gl/YbAhG1" MODIFIED="1484215581530" TEXT="ocf:heartbeat:IPaddr2"/>
<node CREATED="1484213726763" ID="ID_529762028" LINK="https://goo.gl/ps0ywD" MODIFIED="1484213963943" TEXT="apache"/>
<node CREATED="1485245801116" ID="ID_1386951761" LINK="https://goo.gl/OlSrR2" MODIFIED="1485245824500" TEXT="ocf_heartbeat_mysql"/>
<node CREATED="1485250407835" FOLDED="true" ID="ID_3750915" LINK="https://goo.gl/nHmevp" MODIFIED="1486003053073" TEXT="Create a MySQL Resource">
<node CREATED="1485316003730" ID="ID_1377375418" LINK="https://goo.gl/OlSrR2" MODIFIED="1485316037329" TEXT="ocf_heartbeat_mysql &#x2014; Manages a MySQL database instance  "/>
<node CREATED="1484214186451" ID="ID_1026297209" LINK="https://goo.gl/nHmevp" MODIFIED="1484214198618" TEXT="Create a MySQL Resource"/>
<node CREATED="1485251094429" ID="ID_535849704" LINK="https://goo.gl/kh8zfU" MODIFIED="1485251096516" TEXT=""/>
<node CREATED="1485252285950" ID="ID_65302222" LINK="https://goo.gl/QABCwp" MODIFIED="1485252301318" TEXT="Since RHEL 6.5 does not ship with an Active/Active version of MySQL"/>
<node CREATED="1485252491790" ID="ID_998045907" LINK="https://goo.gl/Zg7elS" MODIFIED="1485252504187" TEXT="mysql startup debugging tip"/>
<node CREATED="1485310401247" ID="ID_1191219412" LINK="https://goo.gl/jONyLZ" MODIFIED="1485310438136" TEXT="MySQL (resource agent)"/>
<node CREATED="1485310612337" ID="ID_1714358801" LINK="https://goo.gl/LpgH57" MODIFIED="1485310624759" TEXT="With an Active/Passive configuration"/>
<node CREATED="1485328278001" ID="ID_524995606" LINK="https://goo.gl/KtwzXV" MODIFIED="1485328291503" TEXT="Active/Passive MySQL High Availability Pacemaker Cluster with DRBD on CentOS 7"/>
</node>
</node>
<node CREATED="1486002307011" FOLDED="true" ID="ID_1013524454" LINK="https://goo.gl/EhIXKJ" MODIFIED="1488961488589" TEXT="debug-start">
<node CREATED="1487919812461" ID="ID_729122378" MODIFIED="1487919830694" TEXT="note: the pcs status is different when disable/enable"/>
<node CREATED="1487919832288" ID="ID_169718578" MODIFIED="1487919841023" TEXT="display purpose"/>
</node>
<node CREATED="1486027662684" ID="ID_108054400" MODIFIED="1486027666945" TEXT="unmanaged"/>
<node CREATED="1458875787797" ID="ID_1924014970" LINK="#ID_1156180754" MODIFIED="1486027694705" TEXT="resource"/>
<node CREATED="1484705627457" FOLDED="true" ID="ID_234060833" LINK="https://goo.gl/f1rFB9" MODIFIED="1488961488590" TEXT="groups">
<node CREATED="1484705763008" ID="ID_750351548" LINK="https://goo.gl/6iKdxM" MODIFIED="1484705777519" TEXT="options"/>
<node CREATED="1485422502184" ID="ID_693161105" LINK="https://goo.gl/5Cwmgd" MODIFIED="1485422517172" TEXT="Groups imply both ordering and location"/>
<node CREATED="1487744898846" FOLDED="true" ID="ID_1021408450" MODIFIED="1488961488589" TEXT="create">
<node CREATED="1487744952023" ID="ID_1069050539" LINK="https://goo.gl/0xVm7o" MODIFIED="1487744966386" TEXT="The resources will start in the order you specify"/>
</node>
<node CREATED="1487745605375" ID="ID_1202718467" MODIFIED="1487745609330" TEXT="remove"/>
<node CREATED="1487745641216" ID="ID_867204998" MODIFIED="1487745643316" TEXT="list"/>
</node>
<node CREATED="1487915461711" FOLDED="true" ID="ID_660051980" MODIFIED="1488961488591" TEXT="cleanup">
<node CREATED="1487915467078" ID="ID_1175715653" LINK="https://goo.gl/se4PaJ" MODIFIED="1487915476242" TEXT="failed actions"/>
</node>
<node CREATED="1489563730577" ID="ID_1363364549" MODIFIED="1489563733245" TEXT="meta"/>
<node CREATED="1489564540001" FOLDED="true" ID="ID_1458872846" MODIFIED="1518158664857" TEXT="failcount">
<icon BUILTIN="help"/>
<node CREATED="1508739543739" ID="ID_518089490" LINK="https://goo.gl/Twwnzw" MODIFIED="1508739559819" TEXT="migration-threshold"/>
<node CREATED="1508739830063" ID="ID_1705235084" MODIFIED="1508739831139" TEXT="failure-timeout"/>
<node CREATED="1508739869614" ID="ID_1682353157" MODIFIED="1508739873995" TEXT="stickness"/>
<node CREATED="1508739890006" ID="ID_1172910468" MODIFIED="1508739895514" TEXT="constraint scores"/>
</node>
</node>
<node CREATED="1484648817824" FOLDED="true" ID="ID_60250822" MODIFIED="1487833118918" TEXT="constraints">
<node CREATED="1484648852710" ID="ID_1232025868" LINK="https://goo.gl/zFRaaA" MODIFIED="1484648864663" TEXT="Chapter 6. Resource Constraints"/>
<node CREATED="1484806163807" ID="ID_944501338" LINK="https://goo.gl/xbDTmq" MODIFIED="1484806179078" TEXT="show"/>
<node CREATED="1485161165775" ID="ID_1463601051" LINK="https://goo.gl/3LEjlb" MODIFIED="1485161169642" TEXT="remove"/>
<node CREATED="1487733388844" ID="ID_890366398" LINK="https://goo.gl/Odw0WC" MODIFIED="1487733409490" TEXT="multistate"/>
<node CREATED="1487749458234" FOLDED="true" ID="ID_256304544" MODIFIED="1488961488593" TEXT="order">
<node CREATED="1487749461978" ID="ID_830332414" MODIFIED="1487749463901" TEXT="action"/>
</node>
<node CREATED="1487751952038" ID="ID_668975000" MODIFIED="1487751956465" TEXT="colocation"/>
</node>
<node CREATED="1486016659793" ID="ID_148203254" LINK="https://goo.gl/KtwzXV" MODIFIED="1486016676341" TEXT="Active/Passive MySQL High Availability Pacemaker Cluster with DRBD on CentOS 7"/>
<node CREATED="1487056485601" FOLDED="true" ID="ID_1141840013" LINK="https://goo.gl/g8YbXk" MODIFIED="1499844888658" TEXT="config">
<node CREATED="1487670004568" ID="ID_21287850" LINK="https://goo.gl/JWORT0" MODIFIED="1488880932144" TEXT="export / import configuration"/>
<node CREATED="1487833126407" FOLDED="true" ID="ID_1160358079" LINK="https://goo.gl/g8YbXk" MODIFIED="1491469117188" TEXT="backup">
<node CREATED="1488938626983" ID="ID_1636369964" MODIFIED="1488938637382" TEXT="lab on VM">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1487833129032" ID="ID_1714154309" MODIFIED="1487833131132" TEXT="restore"/>
</node>
<node CREATED="1487643584334" ID="ID_1232228789" LINK="https://goo.gl/cmKw0Q" MODIFIED="1487643590500" TEXT="source code"/>
<node CREATED="1487747159960" ID="ID_1117185411" LINK="https://goo.gl/L4NAhP" MODIFIED="1487747177022" TEXT="command references"/>
<node CREATED="1459323005865" FOLDED="true" ID="ID_1785908793" LINK="#ID_1846799934" MODIFIED="1537944331160" TEXT="stonith">
<node CREATED="1459323010233" FOLDED="true" ID="ID_1541452342" MODIFIED="1460360674424" TEXT="describe">
<node CREATED="1459324813754" FOLDED="true" ID="ID_1604457487" MODIFIED="1459326861314" TEXT="fence_apc">
<node CREATED="1459325062596" ID="ID_1885444505" MODIFIED="1459325065134" TEXT="I/O Fencing agent"/>
</node>
</node>
<node CREATED="1459323017977" ID="ID_424560093" MODIFIED="1459323019365" TEXT="list"/>
<node CREATED="1459328523684" ID="ID_90490162" MODIFIED="1459328525153" TEXT="show"/>
<node CREATED="1489049669123" ID="ID_1154078587" MODIFIED="1489049671415" TEXT="create"/>
<node CREATED="1489051939123" ID="ID_1450667501" MODIFIED="1489051942480" TEXT="level"/>
<node CREATED="1489052293395" ID="ID_1572371394" MODIFIED="1489052295249" TEXT="fence">
<node CREATED="1536056517744" ID="ID_50844650" LINK="https://goo.gl/qwdk6a" MODIFIED="1536056535870" TEXT="Fencing is a requirement of almost any cluster"/>
</node>
<node CREATED="1489052452139" ID="ID_1474988338" LINK="https://goo.gl/4EsrHI" MODIFIED="1489052584673" TEXT="confirm"/>
<node CREATED="1489470891670" ID="ID_1989587792" MODIFIED="1489470893093" TEXT="delay"/>
<node CREATED="1489485644860" ID="ID_547752491" LINK="https://goo.gl/Z4eVSC" MODIFIED="1489485656587" TEXT="CHAPTER 5. FENCING: CONFIGURING STONITH"/>
</node>
<node CREATED="1487319352027" ID="ID_652014085" LINK="https://goo.gl/Amr3YD" MODIFIED="1536053135574" TEXT="property">
<node CREATED="1489390567461" ID="ID_1847436431" LINK="https://goo.gl/7lEK2K" MODIFIED="1489390576754" TEXT="10.1. Summary of Cluster Properties and Options"/>
<node CREATED="1489386938492" FOLDED="true" ID="ID_363030029" MODIFIED="1489457758646" TEXT="set">
<node CREATED="1489390473701" ID="ID_1787159401" LINK="https://goo.gl/Amr3YD" MODIFIED="1489390488690" TEXT="10.2. Setting and Removing Cluster Properties"/>
<node CREATED="1489390514261" ID="ID_1575636615" MODIFIED="1489390517079" TEXT="symmetic-cluster">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1534471724703" ID="ID_23090007" LINK="https://www.mankier.com/8/pcs" MODIFIED="1534471733609" TEXT="man page"/>
<node CREATED="1537934918527" FOLDED="true" ID="ID_412954987" LINK="https://goo.gl/fmJtR1" MODIFIED="1537944357174" TEXT="alert">
<node CREATED="1537940919054" ID="ID_849753159" MODIFIED="1537940919800" TEXT="alerts interface is designed to be backward compatible with the external scripts interface"/>
<node CREATED="1537934958115" ID="ID_550416378" MODIFIED="1537934959060" TEXT="Pacemaker Alert Agents (Red Hat Enterprise Linux 7.3 and later)">
<node CREATED="1537940745663" ID="ID_1213746215" MODIFIED="1537940748717" TEXT="install"/>
<node CREATED="1537940750879" ID="ID_1550973402" MODIFIED="1537940753616" TEXT="each node"/>
</node>
</node>
<node CREATED="1537944340423" ID="ID_1204771005" LINK="https://goo.gl/14xFZL" MODIFIED="1537944354867" TEXT="ocf:pacemaker:ClusterMon resource, which is now deprecated. "/>
</node>
<node CREATED="1534497558228" FOLDED="true" ID="ID_1691067859" MODIFIED="1537934901763" POSITION="left" TEXT="stonith">
<node CREATED="1534497563844" ID="ID_1860885775" LINK="https://goo.gl/TjNLkB" MODIFIED="1534497576899" TEXT="pacemaker and pcs on Linux example, Fencing"/>
<node CREATED="1534497627978" ID="ID_688590792" LINK="https://goo.gl/JKMfX2" MODIFIED="1534497650194" TEXT="stonith_admin"/>
<node CREATED="1534497720446" ID="ID_1396321372" LINK="https://goo.gl/hqaatR" MODIFIED="1534497731055" TEXT="Create fence">
<node CREATED="1534497854898" ID="ID_829518729" LINK="https://goo.gl/hqaatR" MODIFIED="1534497868506" TEXT="High availability cluster in linux"/>
</node>
<node CREATED="1458198287604" ID="ID_207028264" MODIFIED="1535090935145" TEXT="is">
<node CREATED="1458198283213" ID="ID_150362768" LINK="http://goo.gl/92ml5I" MODIFIED="1458198318783" TEXT="a technique for NodeFencing"/>
</node>
<node CREATED="1458198416861" ID="ID_878303152" LINK="http://goo.gl/wnv9NM" MODIFIED="1458198431548" TEXT="the default for STONITH [6] in Pacemaker is enabled"/>
<node CREATED="1460099292170" ID="ID_596177123" LINK="http://goo.gl/wnv9NM" MODIFIED="1460099309371" TEXT="the default for STONITH [6] in Pacemaker is enabled"/>
<node CREATED="1535093144642" ID="ID_1602544898" MODIFIED="1535093147499" TEXT="agent">
<node CREATED="1535093148706" ID="ID_235812280" MODIFIED="1535093154735" TEXT="ipmilan">
<node CREATED="1535093316710" ID="ID_1419914995" LINK="https://goo.gl/SojqAy" MODIFIED="1535093323891" TEXT="&#x7b2c;3&#x56de; Pacemaker&#x3067;&#x3044;&#x308d;&#x3044;&#x308d;&#x8a2d;&#x5b9a;&#x3057;&#x3066;&#x307f;&#x3088;&#x3046;&#xff01;&#xff3b;&#x69cb;&#x7bc9;&#x5fdc;&#x7528;&#x7de8;&#xff3d;"/>
<node CREATED="1535093179926" ID="ID_1237513458" LINK="https://goo.gl/SojqAy" MODIFIED="1535093202789" TEXT="yum - y install OpenIPMI - tools"/>
<node CREATED="1535093355404" ID="ID_1804918859" MODIFIED="1535093359536" TEXT="5.12. CONFIGURING ACPI FOR USE WITH INTEGRATED FENCE DEVICES"/>
</node>
<node CREATED="1535093155986" ID="ID_1885558341" MODIFIED="1535093158604" TEXT="acpi"/>
<node CREATED="1536133043486" ID="ID_654337696" LINK="https://goo.gl/qwdk6a" MODIFIED="1536133074726" TEXT="sbd.service">
<icon BUILTIN="info"/>
<node CREATED="1536133123980" ID="ID_1683654406" MODIFIED="1536133125189" TEXT="software watchdog"/>
<node CREATED="1536133135132" ID="ID_1395371252" LINK="../tux.mm" MODIFIED="1536133182871" TEXT="kernel&#x2019;s softdog module"/>
<node CREATED="1536216369221" ID="ID_1649303675" LINK="https://goo.gl/GsnEAU" MODIFIED="1536216392664" TEXT="Create HA Cluster with SBD and Softdog">
<node CREATED="1536216464179" ID="ID_1288505241" MODIFIED="1536216464893" TEXT="&#x2018;SBD&#x2019; mean &#x2018;storage-based death&#x2019;"/>
<node CREATED="1536216449010" ID="ID_339746230" MODIFIED="1536216449837" TEXT="nodes using SBD should share the same storage device"/>
</node>
<node CREATED="1536216901783" ID="ID_1551751263" LINK="https://goo.gl/UmMOX" MODIFIED="1536216913331" TEXT="SBD Fencing">
<node CREATED="1536216951622" ID="ID_69320547" MODIFIED="1536216952592" TEXT="The SBD devices must not reside on a DRBD instance"/>
</node>
<node CREATED="1536217101587" ID="ID_368834706" LINK="https://goo.gl/ZpsqR1" MODIFIED="1536217118060" TEXT="sbd_configure.sh (github)"/>
</node>
</node>
</node>
<node CREATED="1534497916067" ID="ID_1095570116" MODIFIED="1534497919265" POSITION="left" TEXT="fencing">
<node CREATED="1534497920102" ID="ID_1163023353" LINK="https://goo.gl/F5RiUJ" MODIFIED="1534497947231" TEXT="type of fencing available in pacemaker">
<node CREATED="1534497924851" ID="ID_1587943236" MODIFIED="1534497928424" TEXT="node level"/>
<node CREATED="1534497928794" ID="ID_372308748" MODIFIED="1534497933689" TEXT="resource level"/>
</node>
<node CREATED="1534499333721" ID="ID_1668535420" LINK="https://goo.gl/BbPzp8" MODIFIED="1534499346616" TEXT="&#x5229;&#x7528; fence &#x529f;&#x80fd;&#xff0c;&#x53ef;&#x8b93;&#x67d0;&#x4e00;&#x500b; node &#xff0c;&#x91cd;&#x958b;&#x6a5f;"/>
<node CREATED="1534500547137" ID="ID_553295855" LINK="https://goo.gl/AcQwS6" MODIFIED="1534500556619" TEXT="Configure IPMI fencing"/>
</node>
</node>
</map>

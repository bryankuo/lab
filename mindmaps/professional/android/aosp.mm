<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1357217106082" ID="ID_835538187" LINK="../android.mm" MODIFIED="1419042917218" TEXT="AOSP">
<node CREATED="1450539254133" ID="ID_1770146490" LINK="http://tinyurl.com/obf8sfw" MODIFIED="1450539271177" POSITION="left" TEXT="Requirements"/>
<node CREATED="1367833473859" ID="ID_1522803072" LINK="http://iserveandroid.blogspot.tw/2011/01/important-framework-structuresdirectori.html" MODIFIED="1408739161324" POSITION="left" TEXT="Important framework structures/directories in android">
<icon BUILTIN="info"/>
</node>
<node CREATED="1408736558863" FOLDED="true" ID="ID_179252748" MODIFIED="1412242748274" POSITION="left" TEXT="log">
<icon BUILTIN="help"/>
<node CREATED="1408741429393" LINK="http://goo.gl/cEJf4P" MODIFIED="1408741446727" TEXT="showcommands"/>
<node CREATED="1408741633637" LINK="http://goo.gl/jcrw9P" MODIFIED="1408741646508" TEXT="&#x4fdd;&#x5b58;Build log &#x5230;&#x6587;&#x4ef6;"/>
</node>
<node CREATED="1420166312726" ID="ID_642585840" MODIFIED="1420166315309" POSITION="left" TEXT="sdcard.img">
<icon BUILTIN="help"/>
</node>
<node CREATED="1408737730864" ID="ID_447562922" MODIFIED="1408737741107" POSITION="left" TEXT="device configuration">
<icon BUILTIN="help"/>
</node>
<node CREATED="1408580500033" FOLDED="true" ID="ID_1744622979" LINK="http://goo.gl/APjGNc" MODIFIED="1412232095305" POSITION="left" TEXT="Media">
<node CREATED="1408580603804" LINK="http://goo.gl/QNrN5s" MODIFIED="1408580652039" TEXT="Implementing Custom Codecs"/>
<node CREATED="1408580914581" FOLDED="true" MODIFIED="1412232095304" TEXT="Exposing Codecs to the Framework">
<node CREATED="1408580799673" LINK="#ID_1780097135" MODIFIED="1408580958882" TEXT="android.media.MediaCodecList"/>
<node CREATED="1408580828665" LINK="#ID_1745771604" MODIFIED="1408580965217" TEXT="android.media.CamcorderProfile "/>
</node>
<node CREATED="1408739209148" LINK="#ID_1478445389" MODIFIED="1408739224038" TEXT="Building only an individual program or module"/>
</node>
<node CREATED="1418716811197" FOLDED="true" ID="ID_1268312002" MODIFIED="1418717166631" POSITION="left" TEXT="Get the code using the Manifest and Repo tool">
<node CREATED="1418716767173" LINK="#ID_1999426516" MODIFIED="1418717058958" TEXT="Folders structure">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1418692534822" FOLDED="true" ID="ID_1665937770" LINK="http://goo.gl/Ii56pA" MODIFIED="1447557645327" POSITION="left" TEXT="Developing Efficiently">
<node CREATED="1418700142237" FOLDED="true" LINK="http://goo.gl/Ii56pA" MODIFIED="1418713996346" TEXT="making it &#x201c;our own&#x201d;">
<node CREATED="1418699772546" MODIFIED="1418699773636" TEXT=".repo/manifest.xml ">
<node CREATED="1418699837509" LINK="http://goo.gl/Ii56pA" MODIFIED="1418699850865" TEXT="the manifest file relevant for this version"/>
</node>
<node CREATED="1418699985605" MODIFIED="1418699986410" TEXT="created a separate branch for the updated manifest "/>
<node CREATED="1418700096581" MODIFIED="1418700098139" TEXT="being able to &#x201c;edit&#x201d; an AOSP repository."/>
<node CREATED="1418700002325" MODIFIED="1418700003142" TEXT="that&#x2019;s the first step you need to do ">
<node CREATED="1418700013557" MODIFIED="1418700014255" TEXT=" in order to apply those updates on your codebase."/>
</node>
</node>
<node CREATED="1418700248253" FOLDED="true" MODIFIED="1418713997894" TEXT="frameworks/base project.">
<node CREATED="1418700262431" MODIFIED="1418700263867" TEXT="contains the entire Android framework code"/>
</node>
<node CREATED="1418713846188" MODIFIED="1418713847418" TEXT="adb reboot bootloader"/>
<node CREATED="1418713991564" MODIFIED="1418713992685" TEXT="do we really need to run make and flash it for every simple change we make?!"/>
<node CREATED="1418714032763" FOLDED="true" ID="ID_424176668" MODIFIED="1447557411123" TEXT="no, we have options">
<node CREATED="1418714044987" MODIFIED="1418714045657" TEXT="to make the process more efficient and much shorter."/>
</node>
<node CREATED="1418714067555" LINK="http://goo.gl/Ii56pA" MODIFIED="1418714082037" TEXT="understand how things are structured within the build system."/>
<node CREATED="1418715238516" LINK="http://goo.gl/Ii56pA" MODIFIED="1418715275651" TEXT="Modules in the AOSP system"/>
<node CREATED="1418715290396" ID="ID_1043867315" MODIFIED="1418715291273" TEXT="Building specific modules">
<node CREATED="1418715330013" MODIFIED="1418715330789" TEXT="Since the vast majority of them haven&#x2019;t changed"/>
</node>
<node CREATED="1418715407172" ID="ID_989420820" MODIFIED="1418715427642" TEXT="a list of functions useful function for our day-to-day development"/>
<node CREATED="1418715611756" FOLDED="true" ID="ID_1574639861" MODIFIED="1447557413498" TEXT="Updating the device">
<node CREATED="1418715625380" MODIFIED="1418715626034" TEXT="Recreating the system image files"/>
<node CREATED="1418715635748" MODIFIED="1418715636370" TEXT="Syncing the changes directly"/>
</node>
<node CREATED="1418715883973" ID="ID_590089721" MODIFIED="1418715884642" TEXT="Restarting the Shell ">
<node CREATED="1420166793643" ID="ID_1151771386" LINK="#ID_1755350318" MODIFIED="1420166801677" TEXT="must invoke the envsetup.sh script and the lunch commands again "/>
</node>
</node>
<node CREATED="1418692567416" ID="ID_520714261" LINK="http://goo.gl/TGKxii" MODIFIED="1418692587928" POSITION="left" TEXT="A practical approach">
<icon BUILTIN="help"/>
</node>
<node CREATED="1418698513962" LINK="http://goo.gl/PHbBE7" MODIFIED="1418698536425" POSITION="left" TEXT="GPU&#x5e73;&#x884c;&#x5316;&#x7684;&#x7a0b;&#x5f0f;(CUDA)">
<icon BUILTIN="help"/>
</node>
<node CREATED="1451100214784" ID="ID_1527012153" MODIFIED="1451100220308" POSITION="right" TEXT="environment">
<node CREATED="1428330671287" ID="ID_80471418" LINK="../os.mm#ID_1684530633" MODIFIED="1428330926848" TEXT="ubuntu"/>
<node CREATED="1450918798752" ID="ID_1224510711" LINK="http://tinyurl.com/obf8sfw" MODIFIED="1450918812291" TEXT="requirements">
<node CREATED="1450918962714" ID="ID_457910845" LINK="../../orion.mm" MODIFIED="1451004735351" TEXT="200GB or more for multiple builds."/>
<node CREATED="1451101828838" FOLDED="true" ID="ID_27876146" LINK="#ID_532174235" MODIFIED="1451216888417" TEXT="Repo">
<node CREATED="1451101752853" ID="ID_270922750" LINK="http://tinyurl.com/olpoqjq" MODIFIED="1451101804617" TEXT="In order to use repo, please install Python 2.x"/>
<node CREATED="1451200129842" ID="ID_1305665154" LINK="http://tinyurl.com/zmxjb5q" MODIFIED="1451200153483" TEXT="a &quot;repo&quot; consists of 176 &quot;projects&quot;"/>
<node CREATED="1451200287102" ID="ID_89830285" LINK="http://tinyurl.com/q8spwex" MODIFIED="1451200301921" TEXT="sync one or two projects at a time"/>
<node CREATED="1451215745489" ID="ID_1247036579" LINK="http://tinyurl.com/pv3ctsz" MODIFIED="1451215753114" TEXT="command"/>
</node>
<node CREATED="1450878662556" ID="ID_703136791" LINK="../java.mm#ID_693973213" MODIFIED="1451480602916" TEXT="jdk">
<node CREATED="1451524058898" ID="ID_828915599" LINK="https://goo.gl/4D5S9c" MODIFIED="1451524104827" TEXT="The master branch of Android in the Android Open Source Project (AOSP) requires Java 7.">
<icon BUILTIN="info"/>
</node>
<node CREATED="1451524074023" ID="ID_723634500" LINK="https://goo.gl/4D5S9c" MODIFIED="1451524101408" TEXT=" On Ubuntu, use OpenJDK.">
<icon BUILTIN="info"/>
</node>
</node>
</node>
<node CREATED="1357217123400" ID="ID_1632523017" LINK="http://source.android.com/source/initializing.html" MODIFIED="1451221459847" TEXT="Initializing a Build Environment">
<node CREATED="1408054654243" ID="ID_673700769" MODIFIED="1408054671726" TEXT="under root console"/>
<node CREATED="1407978130391" ID="ID_1410045577" LINK="http://tinyurl.com/okamzh3" MODIFIED="1451306048963" TEXT="Configuring USB Access">
<icon BUILTIN="help"/>
</node>
<node CREATED="1408054208672" FOLDED="true" ID="ID_1682526136" MODIFIED="1451306051025" TEXT="Setting up ccache">
<node CREATED="1359292926004" FOLDED="true" ID="ID_158051678" LINK="professional.mm#ID_1094144699" MODIFIED="1451305913179" TEXT="ccache">
<node CREATED="1418438490562" FOLDED="true" ID="ID_2449996" LINK="http://goo.gl/0k61Oj" MODIFIED="1451184309359" TEXT="install">
<node CREATED="1418438497569" MODIFIED="1418438499976" TEXT="sudo apt-get install ccache"/>
<node CREATED="1418438519303" MODIFIED="1418438520698" TEXT="Using colorgcc to colorize output"/>
<node CREATED="1418438693439" MODIFIED="1418438717425" TEXT="already in the downloaded source"/>
</node>
<node CREATED="1359292934083" LINK="http://source.android.com/source/initializing.html#setting-up-ccache" MODIFIED="1359292990982" TEXT="help to speedup rebuild"/>
<node CREATED="1408054023953" ID="ID_660428310" MODIFIED="1408054024895" TEXT=" This works very well if you do &quot;make clean&quot; often"/>
<node CREATED="1408054037276" ID="ID_1300778879" MODIFIED="1408054038230" TEXT="or if you frequently switch between different build products."/>
<node CREATED="1418439012045" ID="ID_1233360994" MODIFIED="1418439013126" TEXT="prebuilts/misc/linux-x86/ccache$ ccache -M 10G"/>
<node CREATED="1451221470714" ID="ID_1220554914" LINK="http://tinyurl.com/c34jq4s" MODIFIED="1451221475312" TEXT="man page"/>
<node CREATED="1450539405768" ID="ID_1509996968" LINK="http://tinyurl.com/oxgzokv" MODIFIED="1450539424127" TEXT="setup"/>
<node CREATED="1450542887387" ID="ID_1428883014" LINK="http://tinyurl.com/zx4qkp8" MODIFIED="1450542903828" TEXT="If you want to speed up ccache, mount a reiserfs partition to that ccache directory"/>
<node CREATED="1450543798188" ID="ID_1377100538" MODIFIED="1450543799014" TEXT="It uses ~/.ccache as its storage place.">
<node CREATED="1450543916954" ID="ID_976363297" LINK="http://tinyurl.com/j5nznxd" MODIFIED="1450543968936" TEXT="the  CCACHE_DIR environment variable specifies"/>
<node CREATED="1450543939644" ID="ID_348617279" LINK="http://tinyurl.com/j5nznxd" MODIFIED="1450543972296" TEXT="where ccache will keep its cached compiler output."/>
<node CREATED="1450543950118" ID="ID_273847151" LINK="http://tinyurl.com/j5nznxd" MODIFIED="1450543974320" TEXT="The default is &quot;$HOME/.ccache&quot;"/>
</node>
<node CREATED="1451281821563" ID="ID_1478000938" LINK="#ID_158051678" MODIFIED="1451281838179" TEXT="ccache"/>
<node CREATED="1451305466980" ID="ID_492257300" MODIFIED="1451305467953" TEXT="-s"/>
<node CREATED="1451305690437" ID="ID_981365435" MODIFIED="1451305692105" TEXT="~/source/prebuilts/misc/linux-x86/ccache$ sudo ccache -M 16G"/>
</node>
<node CREATED="1418717395333" ID="ID_1349021093" LINK="http://goo.gl/WhSc9F" MODIFIED="1418717410713" TEXT="How faster can it take us?"/>
<node CREATED="1418717688173" ID="ID_1179034464" LINK="http://goo.gl/WhSc9F" MODIFIED="1418717721955" TEXT="Using a &#x201c;warm&#x201d; ccache, the process is a third of the original time! "/>
<node CREATED="1451180292998" ID="ID_1173388481" LINK="#ID_1682526136" MODIFIED="1451180301898" TEXT="Setting up ccache"/>
<node CREATED="1451264004838" ID="ID_1671353202" MODIFIED="1451264012838" TEXT="prebuilts/misc/linux-x86/ccache/ccache -M 16G">
<node CREATED="1451264029028" ID="ID_565592728" MODIFIED="1451264030002" TEXT="Could not set cache size limit."/>
<node CREATED="1451305698222" ID="ID_228013276" MODIFIED="1451305705594" TEXT="root access"/>
<node CREATED="1451305970078" ID="ID_1941513980" MODIFIED="1451305971253" TEXT="sudo ccache -M 16G"/>
</node>
</node>
<node CREATED="1418438844829" ID="ID_27970838" MODIFIED="1451306053480" TEXT="builds are faster">
<node CREATED="1418438788936" ID="ID_159945283" LINK="http://goo.gl/0spSRv" MODIFIED="1418438843120" TEXT="when storing the source files and the output on separate volumes"/>
<node CREATED="1451187056707" ID="ID_928749690" MODIFIED="1451187058791" TEXT="source"/>
<node CREATED="1451187059093" ID="ID_208110977" MODIFIED="1451187059979" TEXT="out">
<node CREATED="1451187061953" ID="ID_147267781" MODIFIED="1451187083498" TEXT="verify auto mounted after download">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1408054237001" FOLDED="true" ID="ID_1241533048" LINK="http://tinyurl.com/zzz557u" MODIFIED="1451181297089" TEXT="Using a separate output directory">
<node CREATED="1408738895257" ID="ID_431038559" MODIFIED="1451179766284" TEXT="multiple source trees ">
<node CREATED="1408738917031" MODIFIED="1408738918148" TEXT="/source/master1"/>
<node CREATED="1408738932420" MODIFIED="1408738933192" TEXT="/source/master2 "/>
</node>
<node CREATED="1408061352618" FOLDED="true" ID="ID_874712431" MODIFIED="1428330528567" TEXT="~/output">
<node CREATED="1408738947929" MODIFIED="1408738948737" TEXT="/output/master1"/>
<node CREATED="1408738958841" MODIFIED="1408738959689" TEXT="/output/master2"/>
</node>
<node CREATED="1408739012303" MODIFIED="1408739013072" TEXT="4.1) and newer, including the master branch."/>
<node CREATED="1408663298202" ID="ID_956189599" MODIFIED="1451180706979" TEXT="output">
<node CREATED="1408738422777" LINK="http://goo.gl/8JkmGy" MODIFIED="1408738451191" TEXT="output of each build"/>
<node CREATED="1408739178937" ID="ID_229570509" LINK="#ID_926796166" MODIFIED="1408739186063" TEXT="separate output directory"/>
</node>
</node>
</node>
<node CREATED="1451614677328" ID="ID_132422676" MODIFIED="1451614684765" TEXT="root">
<icon BUILTIN="yes"/>
</node>
</node>
<node CREATED="1451181086679" ID="ID_450582305" MODIFIED="1451181088658" POSITION="right" TEXT="source">
<node CREATED="1451181058766" FOLDED="true" ID="ID_1524109251" MODIFIED="1451216865574" TEXT="code">
<node CREATED="1451181048401" ID="ID_944018540" MODIFIED="1451181048401" TEXT="Source code size AOSP 5.1.1">
<node CREATED="1451181146200" ID="ID_1468477060" LINK="http://tinyurl.com/om86qa5" MODIFIED="1451181242890" TEXT="is close to 20GB"/>
</node>
<node CREATED="1412300690037" ID="ID_147966190" LINK="http://goo.gl/kqOEZx" MODIFIED="1451216440590" TEXT="folders">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1408738778354" ID="ID_519366067" MODIFIED="1451181084961" TEXT="tree">
<node CREATED="1408738792882" ID="ID_548175386" LINK="http://goo.gl/zAoaDY" MODIFIED="1408738811450" TEXT="change location"/>
<node CREATED="1412301120797" ID="ID_1401979505" LINK="#ID_1872819300" MODIFIED="1412301127064" TEXT="Describing the Folders"/>
<node CREATED="1451216293227" ID="ID_523849898" LINK="How to understand the directory structure of android root tree" MODIFIED="1451216352815" TEXT="understand the structure">
<icon BUILTIN="info"/>
<node CREATED="1421370463465" FOLDED="true" ID="ID_722983096" MODIFIED="1451216876650" TEXT="System">
<node CREATED="1421370480826" ID="ID_495324306" LINK="http://goo.gl/6R87Xj" MODIFIED="1421370527033" TEXT="source code files for the core Android system"/>
<node CREATED="1421370488315" ID="ID_1018329914" LINK="http://goo.gl/6R87Xj" MODIFIED="1421370529386" TEXT=". That is the minimal Linux system that is started before"/>
<node CREATED="1421370496200" ID="ID_110075486" MODIFIED="1421370496841" TEXT=" the Dalvik VM and any java based services are enabled."/>
</node>
</node>
</node>
<node CREATED="1366534073364" ID="ID_150358119" LINK="http://source.android.com/source/downloading.html" MODIFIED="1451263011947" TEXT="Downloading">
<node CREATED="1367765079022" FOLDED="true" ID="ID_1626787705" MODIFIED="1451216870405" TEXT="Installing Repo">
<node CREATED="1408062132640" ID="ID_1299532871" MODIFIED="1408062133472" TEXT="Make sure you have a bin/ directory "/>
<node CREATED="1408062136798" MODIFIED="1408062139644" TEXT="~/bin"/>
</node>
<node CREATED="1367765099396" FOLDED="true" ID="ID_532174235" MODIFIED="1451483741443" TEXT="Initializing a Repo client">
<node CREATED="1418566835783" ID="ID_1148260972" MODIFIED="1418566841078" TEXT="buildname">
<node CREATED="1451182627585" ID="ID_342695623" LINK="http://tinyurl.com/prbr8cg" MODIFIED="1451182830360" TEXT="android-6.0.0_r1"/>
<node CREATED="1451216720194" ID="ID_147081953" MODIFIED="1451216721084" TEXT="gpg --import">
<node CREATED="1451263035349" ID="ID_1452826713" LINK="../technologies.mm" MODIFIED="1451263102436" TEXT="GnuPG key database">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1408061862193" ID="ID_589649374" MODIFIED="1418699799488" TEXT="Verifying Git Tags">
<node CREATED="1451263171626" ID="ID_1722550511" LINK="../git.mm" MODIFIED="1451263212119" TEXT="git tag -v android-6.0.0_r1"/>
</node>
</node>
<node CREATED="1408061793349" ID="ID_798682462" MODIFIED="1408061795572" TEXT="master">
<node CREATED="1376872035913" ID="ID_1756235917" LINK="http://www.elinux.org/index.php?title=Master-android&amp;oldid=280304" MODIFIED="1376872065938" TEXT=" outlines Android source code in &apos;master&apos; branch"/>
</node>
<node CREATED="1408061796031" ID="ID_1247906487" MODIFIED="1408061804774" TEXT="other branch"/>
<node CREATED="1451182870755" ID="ID_847430705" MODIFIED="1451182877980" TEXT="1st download">
<node CREATED="1451182901674" ID="ID_1677025804" MODIFIED="1451182920441" TEXT="repo init -u https://android.googlesource.com/platform/manifest.git -b android-6.0.0_r1"/>
<node CREATED="1451215965134" ID="ID_39456614" MODIFIED="1451215965931" TEXT="https://android.googlesource.com/platform/manifest.git">
<node CREATED="1451215952083" ID="ID_1987869033" LINK="http://tinyurl.com/kuhuqxd" MODIFIED="1451215982483" TEXT="point to a Manifest repository that describes the whole sources."/>
</node>
</node>
<node CREATED="1451182879031" ID="ID_1202217853" MODIFIED="1451182890594" TEXT="already have AOSP">
<node CREATED="1451182788405" ID="ID_1061623013" LINK="http://tinyurl.com/plugv82" MODIFIED="1451182813739" TEXT="repo init -b android-6.0.0_r1"/>
</node>
</node>
<node CREATED="1408061401232" ID="ID_299527858" LINK="#ID_27970838" MODIFIED="1453608355564" TEXT="working directory">
<node CREATED="1408061366318" ID="ID_1263942317" MODIFIED="1451181994804" TEXT="~/source"/>
<node CREATED="1451183188043" ID="ID_1094349284" MODIFIED="1451183194702" TEXT="specify git user info"/>
<node CREATED="1408061476653" ID="ID_264832014" MODIFIED="1408061477264" TEXT="Downloading the Android Source Tree">
<node CREATED="1451183295645" ID="ID_1966024745" MODIFIED="1451183299680" TEXT="repo sync"/>
</node>
</node>
</node>
</node>
<node CREATED="1408736968884" ID="ID_719023044" LINK="http://goo.gl/2exQv" MODIFIED="1451184497885" POSITION="right" TEXT="build system">
<icon BUILTIN="info"/>
<node CREATED="1408495497996" FOLDED="true" ID="ID_458501631" LINK="http://goo.gl/RjDOF" MODIFIED="1451612318449" TEXT="Building for devices">
<icon BUILTIN="help"/>
<node CREATED="1408495876068" ID="ID_1421484513" MODIFIED="1408495877109" TEXT="fastboot and adb can be built with the regular build system."/>
<node CREATED="1408495917665" ID="ID_1495498414" LINK="http://goo.gl/U8NAOE" MODIFIED="1419058261597" TEXT="Building fastboot and adb">
<node CREATED="1417601266383" LINK="http://goo.gl/31shM" MODIFIED="1417601288701" TEXT="fastboot devices command"/>
<node CREATED="1418368932163" FOLDED="true" ID="ID_1980493445" MODIFIED="1419058296849" TEXT="fastboot">
<node CREATED="1418368927523" MODIFIED="1418368929849" TEXT="a tool used to manipulate the flash partitions of the Android developer phone."/>
</node>
</node>
<node CREATED="1419058265745" ID="ID_1651675662" MODIFIED="1419058270731" TEXT="make fastboot"/>
<node CREATED="1419058284862" ID="ID_315225268" MODIFIED="1419058287499" TEXT="make adb"/>
<node CREATED="1408496697983" ID="ID_1416978862" MODIFIED="1408496703962" TEXT="~/vendor"/>
<node CREATED="1408496773693" LINK="http://goo.gl/v1Jwd" MODIFIED="1408496784770" TEXT="Factory Images for Nexus Devices"/>
</node>
<node CREATED="1418566841592" ID="ID_1261291418" MODIFIED="1451182631912" TEXT="buildtype">
<node CREATED="1418566850575" LINK="http://goo.gl/VnueR8" MODIFIED="1418567636402" TEXT="difference"/>
</node>
<node CREATED="1408737362838" ID="ID_1523373262" LINK="http://goo.gl/2pAQC5" MODIFIED="1408737393123" TEXT="NATIVE DEVELOPMENT USING THE AOSP">
<icon BUILTIN="info"/>
</node>
<node CREATED="1408737410310" ID="ID_998674094" LINK="http://goo.gl/d9OCR" MODIFIED="1408737422795" TEXT="kernel compile and test with Android Emulator">
<icon BUILTIN="info"/>
</node>
<node CREATED="1408737548436" MODIFIED="1408737549437" TEXT="Helper macros and functions"/>
<node CREATED="1408737584430" FOLDED="true" ID="ID_1887489425" MODIFIED="1451216898959" TEXT="Building only an individual program or module">
<node CREATED="1408737551652" MODIFIED="1408737554639" TEXT="mm"/>
<node CREATED="1408737554962" MODIFIED="1408737556001" TEXT="mmm"/>
</node>
<node CREATED="1408741551965" ID="ID_1668181652" LINK="http://goo.gl/54LxYX" MODIFIED="1451524832444" TEXT="FAQ "/>
<node CREATED="1419045444157" FOLDED="true" ID="ID_1669708114" LINK="http://goo.gl/iqJpl2" MODIFIED="1451618955789" TEXT="make">
<node CREATED="1419045447954" ID="ID_227319760" MODIFIED="1419045450704" TEXT="targets"/>
<node CREATED="1419041214575" ID="ID_228494888" MODIFIED="1451306521841" TEXT="make -j10 showcommands">
<node CREATED="1419041243106" MODIFIED="1419041245362" TEXT="Seeing the actual commands used"/>
</node>
<node CREATED="1451306574637" ID="ID_1719530770" MODIFIED="1451306694252" TEXT="sudo make -j10 showcommands 2&gt;&amp;1 | tee build.log"/>
<node CREATED="1451480231986" ID="ID_145448005" LINK="https://goo.gl/YqM70q" MODIFIED="1451524173053" TEXT="Failing to install the correct JDK"/>
<node CREATED="1451438799266" FOLDED="true" ID="ID_1776838751" MODIFIED="1451614971980" TEXT="as root">
<icon BUILTIN="info"/>
<icon BUILTIN="yes"/>
<node CREATED="1451481923055" ID="ID_1674511590" LINK="http://goo.gl/qFhf0R" MODIFIED="1451524191269" TEXT="add to sudo group">
<icon BUILTIN="info"/>
</node>
<node CREATED="1451438814519" ID="ID_1419940891" MODIFIED="1451438817842" TEXT="setenv"/>
<node CREATED="1451438825976" ID="ID_1842281462" MODIFIED="1451438827489" TEXT="make -j10 showcommands 2&gt;&amp;1 | tee build.log"/>
<node CREATED="1408736975133" ID="ID_751540760" MODIFIED="1428333226734" TEXT="build/envsetup.sh">
<node CREATED="1419041135184" MODIFIED="1419041137183" TEXT="Specifying what to build"/>
</node>
<node CREATED="1412242821966" ID="ID_1929077968" MODIFIED="1451306241200" TEXT="lunch">
<node CREATED="1412242832366" LINK="http://goo.gl/TGKxii" MODIFIED="1412242845690" TEXT="select target"/>
<node CREATED="1451306243436" ID="ID_706301142" MODIFIED="1451306244460" TEXT="lunch aosp_arm-eng"/>
</node>
</node>
<node CREATED="1451485145434" ID="ID_558960943" MODIFIED="1451485147647" TEXT="clean"/>
<node CREATED="1419045487523" FOLDED="true" ID="ID_244960969" MODIFIED="1451485139616" TEXT="speed up">
<node CREATED="1419045347170" ID="ID_1355765649" LINK="http://elinux.org/Android_Build_System#Speeding_up_the_build" MODIFIED="1419045397757" TEXT="should specify about 2 more threads">
<node CREATED="1419045362717" ID="ID_1421021706" MODIFIED="1419045365011" TEXT=" than you have processors on your machine."/>
</node>
<node CREATED="1419045436010" ID="ID_1811926811" MODIFIED="1419045436877" TEXT="specify to use the &apos;ccache&apos; compiler cache"/>
</node>
<node CREATED="1419045541271" ID="ID_1059895036" LINK="http://elinux.org/Android_Build_System#Building_only_an_individual_program_or_module" MODIFIED="1419045566401" TEXT="only an individual program or module"/>
<node CREATED="1419045596731" ID="ID_1868852176" LINK="http://goo.gl/Ii56pA" MODIFIED="1419045609484" TEXT="Building specific modules"/>
<node CREATED="1408736563160" ID="ID_380095104" MODIFIED="1451612333646" TEXT="rebuild">
<node CREATED="1419041533113" MODIFIED="1419041536491" TEXT="make clean"/>
</node>
<node CREATED="1451483779738" ID="ID_433718238" MODIFIED="1451483780419" TEXT="sudo make -j10 showcommands 2&gt;&amp;1 | tee build.log">
<node CREATED="1451484450642" ID="ID_1845031818" MODIFIED="1451484458582" TEXT="sudo make -j10 2&gt;&amp;1 | tee build.log"/>
<node CREATED="1451524878963" ID="ID_1218829330" MODIFIED="1451524885651" TEXT="sudo time make -j10 2&gt;&amp;1 | tee build.log"/>
</node>
<node CREATED="1451483758883" ID="ID_1124945280" MODIFIED="1451483759463" TEXT="watch -n1 -d prebuilts/misc/linux-x86/ccache/ccache -s">
<node CREATED="1451612346179" ID="ID_1662940590" MODIFIED="1451612360727" TEXT="not utilized">
<icon BUILTIN="help"/>
</node>
<node CREATED="1451615148556" ID="ID_1591454164" LINK="#ID_1776838751" MODIFIED="1451615154438" TEXT="as root"/>
</node>
</node>
<node CREATED="1420165500798" FOLDED="true" ID="ID_360480104" MODIFIED="1451614953679" TEXT="output">
<node CREATED="1420165506367" ID="ID_450435263" MODIFIED="1420165507667" TEXT="system.img"/>
<node CREATED="1420166345767" ID="ID_1202846439" MODIFIED="1420166346467" TEXT="userdata.img"/>
<node CREATED="1420166358426" ID="ID_751568390" MODIFIED="1420166359012" TEXT="ramdisk.img"/>
<node CREATED="1420165033122" ID="ID_1163457717" MODIFIED="1420166373935" TEXT="initial system image"/>
<node CREATED="1420165636882" ID="ID_9366838" LINK="http://goo.gl/JDAJAv" MODIFIED="1420165657035" TEXT="out/target/product/generic/system.img"/>
<node CREATED="1408739516634" ID="ID_1385225962" MODIFIED="1428333225138" TEXT="staging &quot;object&quot; files">
<node CREATED="1408739525951" MODIFIED="1408739525951" TEXT="&apos;out/target/product/&lt;platform-name&gt;/obj&apos;"/>
</node>
<node CREATED="1451614157520" ID="ID_255493604" LINK="http://goo.gl/IiFj8n" MODIFIED="1451614178220" TEXT="&#x5982;&#x679c;&#x7f16;&#x8bd1;&#x6210;&#x529f;&#x4e86;&#xff0c;&#x5728;./out/target/product/generic/&#x76ee;&#x5f55;&#x4e0b;&#x4f1a;&#x6709;system.img&#x6587;&#x4ef6;"/>
</node>
<node CREATED="1418717169637" FOLDED="true" ID="ID_155992048" LINK="http://goo.gl/WhSc9F" MODIFIED="1453608196970" TEXT="Build variants">
<node CREATED="1418717201197" MODIFIED="1418717202023" TEXT="Build targets"/>
<node CREATED="1418717211925" MODIFIED="1418717212654" TEXT="Build flash-able images"/>
<node CREATED="1418717222509" MODIFIED="1418717223365" TEXT="Building for actual devices">
<node CREATED="1418717234189" MODIFIED="1418717234978" TEXT="Drivers"/>
</node>
<node CREATED="1418717665869" ID="ID_1318559849" LINK="http://goo.gl/WhSc9F" MODIFIED="1418717727210" TEXT="highly recommend using the ccache for your builds."/>
</node>
<node CREATED="1408740091694" ID="ID_157732508" LINK="http://goo.gl/65auFY" MODIFIED="1453607252696" TEXT="Building Kernels">
<node CREATED="1453607813467" ID="ID_887743674" LINK="http://goo.gl/TGKxii" MODIFIED="1453607828860" TEXT="The Android kernel is not a part of the AOSP, and must be built separately."/>
<node CREATED="1453607318708" ID="ID_642833793" LINK="https://goo.gl/g2qytp" MODIFIED="1453608235735" TEXT="Figuring out which kernel to build">
<node CREATED="1419352251099" ID="ID_1275033038" LINK="http://goo.gl/xTtuIq" MODIFIED="1419352263482" TEXT="really important you have a kernel for your type of device"/>
<node CREATED="1419042986090" FOLDED="true" ID="ID_1941131002" LINK="http://goo.gl/iqJpl2" MODIFIED="1453608239981" TEXT="kernel is &quot;outside&quot; of the normal Android build system">
<node CREATED="1419060649245" ID="ID_1503291664" LINK="http://goo.gl/d9OCR" MODIFIED="1419060665335" TEXT="Since August 2009 the kernel is no longer part of the standard repo manifest"/>
<node CREATED="1419063807304" ID="ID_120401047" LINK="http://goo.gl/aHw8El" MODIFIED="1419063863269" TEXT="for two reasons">
<node CREATED="1419063828616" ID="ID_1684345776" MODIFIED="1419063831296" TEXT="takes a lot of bandwith"/>
<node CREATED="1419063850311" ID="ID_1122632788" MODIFIED="1419063852095" TEXT="kernel is built with the kernel build system"/>
</node>
</node>
<node CREATED="1419062342544" ID="ID_1723077786" LINK="http://goo.gl/LAR6Hb" MODIFIED="1453617112631" TEXT="goldfish project">
<node CREATED="1419062371666" ID="ID_524232182" MODIFIED="1419062380419" TEXT="contains the kernel sources for the emulated platforms"/>
<node CREATED="1419060605883" ID="ID_28821265" MODIFIED="1419062397994" TEXT="for the emulator"/>
<node CREATED="1419062560158" FOLDED="true" ID="ID_725926926" LINK="http://goo.gl/d9OCR" MODIFIED="1428333504143" TEXT="kernel compile and test with Android Emulator">
<node CREATED="1419063481054" ID="ID_1437179108" MODIFIED="1419063482636" TEXT="should end up in the arch/arm/boot folder of your kernel tree"/>
</node>
<node CREATED="1419065563743" ID="ID_1077121728" MODIFIED="1419065572366" TEXT="for 4.4.3">
<icon BUILTIN="help"/>
<node CREATED="1419065663212" ID="ID_1842608435" MODIFIED="1419065665187" TEXT="2.6.29"/>
</node>
<node CREATED="1453617115332" ID="ID_64801450" LINK="http://goo.gl/VLgr11" MODIFIED="1453617142034" TEXT="to get a copy of kernel from AOSP repository"/>
<node CREATED="1453618358011" ID="ID_569550494" MODIFIED="1453618373012" TEXT="~/out/source/goldfish-kernel"/>
</node>
<node CREATED="1453608297887" ID="ID_246042668" LINK="http://goo.gl/aHw8El" MODIFIED="1453608320934" TEXT="Android kernel compile and test with Android Emulator"/>
</node>
<node CREATED="1419352068976" ID="ID_1229255216" MODIFIED="1419352075185" TEXT="Downloading source">
<node CREATED="1453608200237" ID="ID_1184274015" LINK="#ID_1263942317" MODIFIED="1453608226750" TEXT="~/source/kernel"/>
<node CREATED="1453614745998" ID="ID_1130911653" LINK="http://goo.gl/aHw8El" MODIFIED="1453614795210" TEXT="Get the Android kernel"/>
<node CREATED="1453614766468" ID="ID_711201358" LINK="http://goo.gl/aHw8El" MODIFIED="1453614792993" TEXT="Check out the correct branch for working with the emulator"/>
</node>
<node CREATED="1419060817993" ID="ID_583062609" LINK="http://goo.gl/778aLq" MODIFIED="1419060832821" TEXT="Main Google Android Kernels"/>
<node CREATED="1419465535647" FOLDED="true" ID="ID_1892474404" MODIFIED="1428330567522" TEXT="Ensure that the prebuilt toolchain is in your path.">
<node CREATED="1419352064303" ID="ID_1727286667" LINK="downloading-a-prebuilt-gcc" MODIFIED="1419465598609" TEXT="Downloading a prebuilt gcc"/>
<node CREATED="1419465733969" ID="ID_563400246" MODIFIED="1419465735317" TEXT="linux host, if you don&apos;t have an Android source tree, you can download the prebuilt toolchain"/>
</node>
<node CREATED="1419062224191" ID="ID_1544164849" MODIFIED="1419062233235" TEXT="kernel patches for android">
<icon BUILTIN="help"/>
</node>
<node CREATED="1419516348206" FOLDED="true" ID="ID_425710368" LINK="http://goo.gl/zDlDAC" MODIFIED="1453607686664" TEXT="Building Kernels">
<node CREATED="1419516393982" ID="ID_364048427" MODIFIED="1419516394921" TEXT="Configure kernel for emulator"/>
<node CREATED="1419517303173" FOLDED="true" ID="ID_489089849" LINK="http://goo.gl/KSu4pk" MODIFIED="1419556134917" TEXT="git checkout android-goldfish-3.4">
<node CREATED="1419517258970" ID="ID_701037528" LINK="http://goo.gl/Q8ZHzB" MODIFIED="1419517276718" TEXT="&#x8fd9;&#x91cc;&#x6211;&#x6ca1;&#x6709;&#x627e;&#x5230;goldfish_defconfig&#x7684;&#x914d;&#x7f6e;&#x6587;&#x4ef6;"/>
</node>
<node CREATED="1419517488243" FOLDED="true" ID="ID_743418158" MODIFIED="1419556136261" TEXT="android-goldfish-2.6.29">
<node CREATED="1419517457883" ID="ID_512958792" LINK="http://goo.gl/Q8ZHzB" MODIFIED="1419554170202" TEXT="&#x7136;&#x540e;&#x53ef;&#x4ee5;&#x5728;arch/arm/config&#x8def;&#x5f84;&#x4e0b;&#x627e;&#x5230;&#x4e24;&#x4e2a;&#x914d;&#x7f6e;&#x6587;&#x4ef6;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1419554191734" ID="ID_1483375683" LINK="../tux.mm#ID_813669052" MODIFIED="1419554290709" TEXT="arch/arm/configs"/>
</node>
<node CREATED="1419555979453" ID="ID_861668449" MODIFIED="1419555980293" TEXT="make goldfish_armv7_defconfig"/>
<node CREATED="1419813113359" ID="ID_1694631993" LINK="http://goo.gl/aM6MW0" MODIFIED="1419813136159" TEXT="built this way should end up in the arch/arm/boot folder of your kernel tree"/>
</node>
<node CREATED="1419062972995" FOLDED="true" ID="ID_1243610350" LINK="http://goo.gl/7ViWul" MODIFIED="1453607442924" TEXT="prebuilt kernel">
<node CREATED="1419063678652" ID="ID_958534556" LINK="http://goo.gl/aHw8El" MODIFIED="1419063709654" TEXT="the standard distribution the kernel is distributed as a pre-built binary"/>
</node>
</node>
<node CREATED="1412242631606" FOLDED="true" ID="ID_1501869516" LINK="http://goo.gl/TGKxii" MODIFIED="1447557403470" TEXT="A practical approach to the AOSP build system">
<node CREATED="1412242585254" MODIFIED="1412242597348" TEXT="by adding an Android application to the system image"/>
<node CREATED="1412243600014" MODIFIED="1412243600812" TEXT="How does the build system know what to build?"/>
<node CREATED="1412243751318" MODIFIED="1412243752196" TEXT="high level overview of the Android build system"/>
<node CREATED="1412243776142" MODIFIED="1412243776796" TEXT="how to add an APK to the system image"/>
</node>
<node CREATED="1408740891295" ID="ID_140864002" LINK="http://goo.gl/srSlbP" MODIFIED="1408740909949" TEXT="How-to Automate Your ROM Build Process">
<icon BUILTIN="info"/>
</node>
<node CREATED="1418692422452" FOLDED="true" ID="ID_27175046" LINK="../professional.mm#ID_240579795" MODIFIED="1451102789518" TEXT="distcc">
<node CREATED="1419047279714" ID="ID_242303015" LINK="http://goo.gl/8kLfC2" MODIFIED="1419047373909" TEXT="distcc allows sources to compile c / c + + (45/50% AOSP)"/>
<node CREATED="1419047292788" ID="ID_936229381" LINK="http://goo.gl/8kLfC2" MODIFIED="1419047377477" TEXT="but what solution it currently does for java files?"/>
<node CREATED="1419047423448" ID="ID_1263901409" LINK="http://goo.gl/Dosy6R" MODIFIED="1419047498509" TEXT="Unfortunately, it turned  out that bulk of Android build">
<node CREATED="1419047443112" ID="ID_751406798" LINK="http://goo.gl/Dosy6R" MODIFIED="1419047493081" TEXT=" is spent compiling Java apps and  performance gains from distcc"/>
<node CREATED="1419047457387" ID="ID_901664517" MODIFIED="1423189335301" TEXT=" were insignificant, below 10% even under"/>
</node>
<node CREATED="1419813086517" ID="ID_1682207326" MODIFIED="1419813093885" TEXT="pure c project">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1419352162782" ID="ID_509093666" LINK="http://goo.gl/xTtuIq" MODIFIED="1419352183643" POSITION="left" TEXT="how an Android ROM is built">
<node CREATED="1419352193731" ID="ID_1263633822" MODIFIED="1419352196635" TEXT="Kernel"/>
</node>
<node CREATED="1447557596303" ID="ID_932507830" MODIFIED="1447557603168" POSITION="left" TEXT="build SDK">
<icon BUILTIN="help"/>
<node CREATED="1451306609148" ID="ID_1008294771" LINK="http://tinyurl.com/hyjgvxh" MODIFIED="1451306624756" TEXT="Building the SDK for Linux and Mac OS"/>
</node>
<node CREATED="1451612949879" ID="ID_1609213480" LINK="https://goo.gl/DTGEhA" MODIFIED="1451612956107" POSITION="right" TEXT="running">
<node CREATED="1408741697064" FOLDED="true" ID="ID_244121509" MODIFIED="1450918816834" TEXT="rerun">
<node CREATED="1420165404035" ID="ID_1755350318" MODIFIED="1420165404753" TEXT="must invoke the envsetup.sh script and the lunch commands again"/>
<node CREATED="1408742288174" ID="ID_387343070" LINK="http://goo.gl/2mZSW5" MODIFIED="1408742301036" TEXT="Running emulator after building Android from source"/>
<node CREATED="1419556009125" ID="ID_1155274279" MODIFIED="1419556010488" TEXT="emulator -kernel ./kernel/arch/arm/boot/zImage"/>
</node>
<node CREATED="1451613928787" ID="ID_6282989" MODIFIED="1451613929504" TEXT="prebuilts/android-emulator/linux-x86_64/emulator"/>
</node>
</node>
</map>

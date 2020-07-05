<map version="1.1.0">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1387253602596" ID="ID_444769592" LINK="../technologies.mm" MODIFIED="1460543965920" TEXT="LVM">
<node CREATED="1387252549395" FOLDED="true" LINK="http://help.1and1.com/servers-c37684/linux-server-c37687/administration-help-c37694/increase-the-size-of-the-logical-volume-a756168.html" MODIFIED="1458539271030" POSITION="right" TEXT="Increase the Size of the Logical Volume">
<node CREATED="1387252132979" MODIFIED="1387252137347" TEXT="lvextend"/>
<node CREATED="1387252408707" MODIFIED="1387252416538" TEXT="resize2fs"/>
</node>
<node CREATED="1387263864993" ID="ID_393285813" LINK="http://www.tcpdump.com/kb/os/linux/lvm-resizing-guide/all-pages.html" MODIFIED="1387264743083" POSITION="right" TEXT="add additional physical volumes to this volume group "/>
<node CREATED="1387264195777" FOLDED="true" MODIFIED="1428476471729" POSITION="right" TEXT="resize the file system">
<icon BUILTIN="full-3"/>
<node CREATED="1387186195247" MODIFIED="1387264870948" TEXT="why df -h show incorrect size"/>
</node>
<node CREATED="1450543580126" ID="ID_654005978" LINK="http://tinyurl.com/jafo3ty" MODIFIED="1450543594428" POSITION="right" TEXT="Commands to Scan PV&apos;s, LV&apos;s and VG&apos;s"/>
<node CREATED="1451185881102" ID="ID_1184401559" LINK="http://tinyurl.com/zjmk47b" MODIFIED="1451185889192" POSITION="right" TEXT="volume layout">
<icon BUILTIN="info"/>
</node>
<node CREATED="1451186711994" MODIFIED="1458539944410" POSITION="right" TEXT="lab">
<node CREATED="1451186714603" MODIFIED="1458539946104" TEXT="aosp">
<node CREATED="1451186719328" FOLDED="true" ID="ID_545284254" MODIFIED="1492223926268" TEXT="cache">
<node CREATED="1450546297420" ID="ID_429700212" MODIFIED="1450546298542" TEXT="sudo mkfs -t ext4 /dev/ubuntu-vg/ccache"/>
<node CREATED="1450546431721" ID="ID_1772888001" LINK="http://tinyurl.com/jss6czm" MODIFIED="1450546509974" TEXT="sudo mount -t ext4 /dev/ubuntu-vg/ccache ~/.ccache/"/>
<node CREATED="1450546624599" LINK="http://tinyurl.com/hy23653" MODIFIED="1450546639561" TEXT="sudo gvim /etc/fstab"/>
</node>
<node CREATED="1451186721683" MODIFIED="1451186722760" TEXT="out"/>
</node>
</node>
<node CREATED="1451184527257" ID="ID_602173756" MODIFIED="1492224409834" POSITION="right" TEXT="mount logical volume to directory">
<icon BUILTIN="help"/>
<node CREATED="1451185064805" LINK="http://tinyurl.com/q8efpzr" MODIFIED="1451185114506" TEXT="sequence"/>
<node CREATED="1451183757779" ID="ID_767790560" MODIFIED="1451183971019" TEXT="pv -&gt; vg ( mount point )">
<icon BUILTIN="idea"/>
</node>
<node CREATED="1451184595173" LINK="http://tinyurl.com/or7wdvv" MODIFIED="1451184610066" TEXT="lvmdiskscan"/>
<node CREATED="1451184736097" MODIFIED="1451184778225" TEXT="making a F/S mounting to a LV permanantly"/>
</node>
<node CREATED="1458532195768" LINK="#ID_771915814" MODIFIED="1458532201464" POSITION="right" TEXT="LVM"/>
<node CREATED="1458614098710" ID="ID_409401600" LINK="http://goo.gl/2h8wQ" MODIFIED="1458614146388" POSITION="right" TEXT="LVM HOWTO">
<node CREATED="1458614234699" ID="ID_1025624457" MODIFIED="1458614236165" TEXT="13.5.2.3. Move the data"/>
<node CREATED="1460620066334" ID="ID_16763767" LINK="http://goo.gl/XkXoz1" MODIFIED="1460620117339" TEXT="13.9. Recover physical volume metadata"/>
</node>
<node CREATED="1458532215140" FOLDED="true" ID="ID_644116595" LINK="../technologies.mm#ID_771915814" MODIFIED="1460618675301" POSITION="right" TEXT="LVM">
<icon BUILTIN="info"/>
<node CREATED="1458542207633" LINK="http://goo.gl/kMoFGH" MODIFIED="1460457779078" TEXT="How can I shrink a Logical Volume, and re-allocate the freed space into a new partition on the same drive?">
<icon BUILTIN="info"/>
<node CREATED="1458557300849" LINK="http://goo.gl/gy8FBs" MODIFIED="1458557330174" TEXT="&#x52d5;&#x614b;&#x6539;&#x8b8a;LV&#x4ee5;&#x53ca;&#x6a94;&#x6848;&#x7cfb;&#x7d71;&#x5927;&#x5c0f;"/>
<node CREATED="1458544971077" LINK="http://goo.gl/xd2udh" MODIFIED="1458556913495" TEXT="lvm&#x4fee;&#x6539;&#x6839;&#x5206;&#x533a;&#x5927;&#x5c0f;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1458549909318" LINK="http://goo.gl/gy8FBs" MODIFIED="1458549924112" TEXT="&#x5148;&#x7e2e;&#x5c0f;&#x4e0a;&#x5c64;&#x7684;filesystem&#xff0c;&#x518d;&#x7e2e;&#x5c0f;&#x5e95;&#x5c64;&#x7684;lv">
<icon BUILTIN="info"/>
<node CREATED="1458555102923" LINK="https://goo.gl/Q0gkPc" MODIFIED="1458555136159" TEXT="resize2fs"/>
<node CREATED="1458615994903" LINK="http://goo.gl/b9gldO" MODIFIED="1458616006581" TEXT="don&apos;t shrink it smaller then what you resize2fs it "/>
</node>
</node>
<node CREATED="1458543133257" LINK="https://goo.gl/y8m2oC" MODIFIED="1460457787406" TEXT="LVM Resize &#x2013; How to decrease or shrink the logical volume">
<icon BUILTIN="info"/>
<node CREATED="1458543114506" MODIFIED="1458543115334" TEXT="Shrinking a root volume"/>
<node CREATED="1458543122769" MODIFIED="1458543123479" TEXT="Shrinking a non-root volume"/>
</node>
</node>
<node CREATED="1460360779191" LINK="https://goo.gl/vzT2Yp" MODIFIED="1460360793630" POSITION="right" TEXT="How to Shrink an ext2/3/4 File system with resize2fs"/>
<node CREATED="1460458623001" LINK="https://goo.gl/4L4yOi" MODIFIED="1460458769166" POSITION="right" TEXT="create the journal"/>
<node CREATED="1460512352757" ID="ID_886919356" LINK="http://goo.gl/YAYpMA" MODIFIED="1460512366272" POSITION="right" TEXT="How to find the physical volume(s) that hold a logical volume in LVM"/>
<node CREATED="1460512608465" LINK="http://goo.gl/BuWGe0" MODIFIED="1460512621875" POSITION="right" TEXT="These are all the steps required to resize a LVM or LVM2 partition">
<icon BUILTIN="info"/>
</node>
<node CREATED="1460513140259" FOLDED="true" ID="ID_925968233" MODIFIED="1460962049015" POSITION="right" TEXT="resize">
<node CREATED="1460458821945" ID="ID_1890627225" LINK="http://goo.gl/5UaiJI" MODIFIED="1460458835075" TEXT="LVM-LV&#x7684;&#x5bb9;&#x91cf;&#x589e;&#x6e1b;&#x8a2d;&#x5b9a;(&#x4e0a;)"/>
<node CREATED="1460513143625" ID="ID_371103399" LINK="http://goo.gl/RpnxuU" MODIFIED="1460513161818" TEXT="In general, here&apos;s how to resize LVM volumes"/>
<node CREATED="1460513273234" ID="ID_1731980135" LINK="http://goo.gl/XO6X6J" MODIFIED="1460513303522" TEXT="the GParted (also known as Gnome Partition Editor) tool">
<node CREATED="1460513285114" MODIFIED="1460513291440" TEXT=" described in Part 1 of this series"/>
<node CREATED="1460513291770" LINK="http://goo.gl/XO6X6J" MODIFIED="1460513311836" TEXT=" does not support resizing LVM partitions.">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1460513359994" ID="ID_547008859" MODIFIED="1460513366368" TEXT="encrypted partition"/>
<node CREATED="1460513560339" ID="ID_1997801771" LINK="https://goo.gl/cYsHxF" MODIFIED="1460513583989" TEXT="Reduce an encrypted partition"/>
<node CREATED="1460621277493" ID="ID_1145459690" LINK="http://goo.gl/kMoFGH" MODIFIED="1460621289707" TEXT="How can I shrink a Logical Volume, and re-allocate the freed space into a new partition on the same drive?"/>
<node CREATED="1460623658918" ID="ID_638986661" LINK="http://goo.gl/bFnBfl" MODIFIED="1460623682347" TEXT="Running a Filesystem Check on LVM&#x2019;s"/>
</node>
<node CREATED="1460543875563" ID="ID_607167476" LINK="http://goo.gl/GJBNi3" MODIFIED="1460543878689" POSITION="right" TEXT="tool"/>
<node CREATED="1461060184025" ID="ID_1655794330" LINK="http://goo.gl/vt1ieK" MODIFIED="1461205706513" POSITION="right" TEXT="can not boot post change">
<node CREATED="1461208271655" FOLDED="true" ID="ID_1473997430" MODIFIED="1461208372441" TEXT="vgrename">
<node CREATED="1461062672457" FOLDED="true" ID="ID_1950798820" MODIFIED="1461208264345" TEXT="Kernel panic after LVM group rename">
<node CREATED="1461062721633" ID="ID_1140366227" LINK="http://goo.gl/LctFYs" MODIFIED="1461062733239" TEXT="I had renamed the devices, but not told my bootloader about it."/>
<node CREATED="1461062763705" ID="ID_330278607" MODIFIED="1461062764610" TEXT="found and mounted my boot filesystem, then edited the bootloader configuration"/>
</node>
</node>
<node CREATED="1461208277815" FOLDED="true" ID="ID_154836699" MODIFIED="1461208362247" TEXT="grub menu">
<node CREATED="1461060193512" ID="ID_1418890318" LINK="https://goo.gl/ljBgVJ" MODIFIED="1461060210482" TEXT="On GRUB menu, edit the kernel parameters to remove the &quot;rhgb&quot; and &quot;quiet&quot;. Then proceed with boot."/>
<node CREATED="1461060216160" ID="ID_1997179450" LINK="https://goo.gl/ljBgVJ" MODIFIED="1461060287208" TEXT="to remove rhgb quiet so you can see any other messages that might currently be hidden."/>
<node CREATED="1461061769177" ID="ID_1307422507" LINK="centos.mm" MODIFIED="1461204680120" TEXT="grub menu">
<node CREATED="1461061841721" ID="ID_862326460" LINK="https://goo.gl/Y5g2cv" MODIFIED="1461061851633" TEXT="9.7. GRUB Menu Configuration File"/>
</node>
</node>
<node CREATED="1461060648104" FOLDED="true" ID="ID_1380472128" LINK="https://goo.gl/1kD00f" MODIFIED="1461208360952" TEXT="Kernel panic on boot following &quot;dracut Warning: LVM rootvg/rootlv not found&quot;">
<node CREATED="1461060757417" ID="ID_1618391199" MODIFIED="1461060758749" TEXT="View and repair the LVM filter in /etc/lvm/lvm.conf"/>
<node CREATED="1461204888502" ID="ID_1303132384" MODIFIED="1461204889749" TEXT="View and repair the GRUB configuration"/>
<node CREATED="1461206432655" ID="ID_1747090237" LINK="https://goo.gl/woDbe3" MODIFIED="1461206443080" TEXT="also need to update your initrd as the name is also stored there"/>
<node CREATED="1461206389847" ID="ID_1885940525" MODIFIED="1461206401586" TEXT="boot / not such filesystem"/>
<node CREATED="1461207716480" ID="ID_589946009" LINK="https://goo.gl/F92fGd" MODIFIED="1461208205110" TEXT="Invalid/etc/fstabentry, /dev/hdb3 is a non-existent device."/>
</node>
<node CREATED="1461208378552" ID="ID_1097530498" MODIFIED="1461208413646" TEXT="through dracut, we can mount / modify real file system">
<node CREATED="1461208424423" ID="ID_818660574" MODIFIED="1461208428715" TEXT="dracut">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1461205100950" ID="ID_90208069" MODIFIED="1461205104419" POSITION="right" TEXT="configuration">
<node CREATED="1461060920049" ID="ID_1738191038" MODIFIED="1461205117590" TEXT=" /etc/lvm/">
<node CREATED="1461205118118" ID="ID_185430905" MODIFIED="1461205118836" TEXT="lvm.conf"/>
<node CREATED="1461205119182" ID="ID_1119157202" MODIFIED="1461205121597" TEXT="profile"/>
</node>
</node>
<node CREATED="1461205451143" ID="ID_1298308474" LINK="http://goo.gl/R2O2JC" MODIFIED="1461205610482" POSITION="right" TEXT="caching"/>
<node CREATED="1461205528943" ID="ID_1734531161" MODIFIED="1461205534318" POSITION="right" TEXT="lvmcache"/>
<node CREATED="1460962483102" ID="ID_1064639009" MODIFIED="1460962488214" POSITION="left" TEXT="idea">
<node CREATED="1450542388108" ID="ID_488542992" LINK="http://tinyurl.com/oo7ns9z" MODIFIED="1458539293013" TEXT=" consists of three logical &#x201c;layers&#x201d;">
<node CREATED="1387253448788" ID="ID_469495069" MODIFIED="1492224264944" TEXT="physical volume">
<node CREATED="1387253488772" ID="ID_1351399133" MODIFIED="1387253492844" TEXT="pvdisplay"/>
<node CREATED="1450542286463" FOLDED="true" MODIFIED="1458539271031" TEXT="Adding">
<node CREATED="1450542143403" LINK="http://tinyurl.com/qehd6z7" MODIFIED="1450542305171" TEXT="Disk"/>
<node CREATED="1450542293163" MODIFIED="1450542296415" TEXT="partition"/>
</node>
<node CREATED="1460538355712" FOLDED="true" ID="ID_298024513" MODIFIED="1492224445326" TEXT="pvdisplay">
<node CREATED="1460540587888" LINK="http://goo.gl/W9qL0" MODIFIED="1460540601553" TEXT="How to find the physical volume(s) that hold a logical volume in LVM"/>
</node>
<node CREATED="1460538353921" ID="ID_177649259" MODIFIED="1460538355294" TEXT="pvs">
<node CREATED="1492224268821" ID="ID_535307437" LINK="http://tinyurl.com/lbb7dks" MODIFIED="1492224358077" TEXT="in human readable format?"/>
</node>
<node CREATED="1450542571055" FOLDED="true" ID="ID_1572681819" LINK="http://tinyurl.com/oo7ns9z" MODIFIED="1460964883937" TEXT="pvcreate">
<node CREATED="1460619055621" ID="ID_1678059523" LINK="http://goo.gl/6e2MUT" MODIFIED="1460619059502" TEXT="man"/>
<node CREATED="1460619610453" ID="ID_714955231" MODIFIED="1460619611147" TEXT="restorefile is required with uuid"/>
<node CREATED="1460964493215" ID="ID_966007513" LINK="http://goo.gl/g8fTvT" MODIFIED="1460964513927" TEXT="&#x5efa;&#x7acb; LVM &#x78c1;&#x789f;&#x65b9;&#x5f0f;"/>
<node CREATED="1460964554960" ID="ID_306005698" LINK="https://goo.gl/k0fiVZ" MODIFIED="1460964566224" TEXT="5.1.1. Creating the Physical Volumes"/>
</node>
<node CREATED="1451004143106" FOLDED="true" ID="ID_525755510" LINK="http://tinyurl.com/5te3zz8" MODIFIED="1460964883938" TEXT="pvscan">
<node CREATED="1458541819247" LINK="http://goo.gl/IM8IyE" MODIFIED="1458541828844" TEXT="scan all disks for physical volumes "/>
<node CREATED="1387252823571" ID="ID_1040199214" LINK="http://technorati.com/technology/it/article/increase-the-size-of-a-mounted1/" MODIFIED="1492224399071" TEXT="Increase The Size of a Mounted Partition with LVM">
<node CREATED="1387252869259" MODIFIED="1387252870125" TEXT="pvscan"/>
<node CREATED="1387252726851" MODIFIED="1387252727996" TEXT="lvresize"/>
</node>
</node>
<node CREATED="1451004146980" FOLDED="true" ID="ID_1609425974" MODIFIED="1460964883941" TEXT="pvdisplay">
<node CREATED="1460539144810" FOLDED="true" ID="ID_1286222948" MODIFIED="1460964883939" TEXT="-m">
<node CREATED="1460539147873" LINK="http://goo.gl/sTFMP7" MODIFIED="1460539172047" TEXT="option to show the mapping of physical extents to logical"/>
</node>
</node>
<node CREATED="1458541955329" ID="ID_624622336" LINK="http://goo.gl/W9qL0" MODIFIED="1492224422265" TEXT="pvresize">
<node CREATED="1460538232328" LINK="http://goo.gl/Zf8vtb" MODIFIED="1460538249189" TEXT="Shrink the physical volume using pvresize"/>
<node CREATED="1460538503561" FOLDED="true" ID="ID_996567385" LINK="http://goo.gl/TH0xkE" MODIFIED="1460964883942" TEXT="How to shrink Linux partition (sda2, type is Linux LVM)">
<node CREATED="1460538646185" MODIFIED="1460538646959" TEXT="4. Backup partition table"/>
</node>
<node CREATED="1460539985050" LINK="http://goo.gl/W9qL0" MODIFIED="1460539999432" TEXT="Shrink the PV on /dev/sda1 prior to shrinking the partition with fdisk">
<icon BUILTIN="info"/>
</node>
<node CREATED="1460544517628" ID="ID_1823286331" LINK="http://goo.gl/hZOiiV" MODIFIED="1460544526592" TEXT=" i was able to fix it by booting to a rescue/live cd and re-assign the uuid over"/>
<node CREATED="1492224521201" ID="ID_522376346" MODIFIED="1492224532982" TEXT="stpes to extend a Linux PV partition"/>
</node>
<node CREATED="1458541969577" FOLDED="true" ID="ID_87732704" MODIFIED="1460964883945" TEXT="pvmove">
<node CREATED="1458614372995" LINK="http://goo.gl/2h8wQ" MODIFIED="1458614387209" TEXT="13.5.2.4. Remove the unused disk"/>
</node>
<node CREATED="1460619219589" ID="ID_1824481353" LINK="https://goo.gl/FKGev1" MODIFIED="1460619229559" TEXT="6.4. Recovering Physical Volume Metadata"/>
<node CREATED="1460962980056" ID="ID_497055343" MODIFIED="1460962999688" TEXT="max number of PV to create"/>
</node>
<node CREATED="1387253477596" FOLDED="true" ID="ID_271042363" MODIFIED="1492224263194" TEXT="volume group">
<node CREATED="1492223934279" ID="ID_1290422909" LINK="http://tinyurl.com/kly3ylc" MODIFIED="1492223973971" TEXT="Volume Groups (VG) don&apos;t deal with raw space directly">
<node CREATED="1492223957758" ID="ID_964775852" LINK="http://tinyurl.com/kly3ylc" MODIFIED="1492223976163" TEXT="they group Physical Volumes (PV)"/>
</node>
<node CREATED="1451004255347" FOLDED="true" ID="ID_1989156937" MODIFIED="1458539271032" TEXT="vgcreate">
<node CREATED="1451186242362" MODIFIED="1451186257003" TEXT="sudo vgcreate ubuntu-vg-out /dev/sda10"/>
</node>
<node CREATED="1458543257634" ID="ID_1223456940" LINK="http://goo.gl/OpCwGA" MODIFIED="1460620801700" TEXT="vgchange">
<node CREATED="1458543279714" LINK="https://goo.gl/y8m2oC" MODIFIED="1458543292715" TEXT="LVM Resize &#x2013; How to decrease or shrink the logical volume"/>
</node>
<node CREATED="1460620444373" ID="ID_213759488" LINK="http://goo.gl/4Qc8Iv" MODIFIED="1460620773883" TEXT="vgcfgrestore"/>
<node CREATED="1387253494732" ID="ID_415703163" MODIFIED="1387253500380" TEXT="vgdisplay"/>
<node CREATED="1450542618752" FOLDED="true" ID="ID_1838977545" MODIFIED="1458532482050" TEXT="vgextend">
<node CREATED="1450545506931" MODIFIED="1450545506931" TEXT="sudo vgextend ubuntu-vg /dev/sda6"/>
<node CREATED="1451183779097" MODIFIED="1451183781589" TEXT="sudo vgextend ubuntu-vg /dev/sda10"/>
<node CREATED="1451183831112" MODIFIED="1451183844431" TEXT="&apos;ubuntu-vg&apos; is the default name"/>
</node>
<node CREATED="1450545428213" ID="ID_139460641" MODIFIED="1450545429646" TEXT="vgs"/>
<node CREATED="1451186084715" ID="ID_401072840" LINK="https://goo.gl/lKzYfR" MODIFIED="1458541060858" TEXT="vgreduce">
<node CREATED="1451186151484" MODIFIED="1451186152767" TEXT="sudo vgreduce ubuntu-vg /dev/sda10"/>
<node CREATED="1458541459953" MODIFIED="1458541461018" TEXT=" remove the physical volume /dev/sdb1 from the volume group"/>
</node>
<node CREATED="1458532515372" ID="ID_1249119040" MODIFIED="1460965115323" TEXT="vgrename">
<node CREATED="1458532487428" LINK="http://goo.gl/eEUAKS" MODIFIED="1458532507887" TEXT="rename"/>
<node CREATED="1458532484680" ID="ID_465691169" MODIFIED="1458532485898" TEXT="sudo vgrename -v vg_tt206 vg_tt216"/>
<node CREATED="1460965136112" ID="ID_1822926366" LINK="https://goo.gl/L2V5G9" MODIFIED="1460965147694" TEXT="&#x2060;4.3.14. Renaming a Volume Group"/>
</node>
<node CREATED="1458533091469" ID="ID_1729356504" MODIFIED="1458533095091" TEXT="resize"/>
<node CREATED="1460618638039" ID="ID_205677224" LINK="http://goo.gl/MKviHr" MODIFIED="1460618662066" TEXT="LVM Volume Group Shows &quot;unknown device&quot;"/>
<node CREATED="1460962257248" ID="ID_1271114991" MODIFIED="1460962270124" TEXT="show free extents"/>
<node CREATED="1460963411137" ID="ID_717700254" LINK="https://goo.gl/a8n9fT" MODIFIED="1460963421980" TEXT="64 &#x4f4d;&#x5143;&#x6838;&#x5fc3;&#x4e0a;&#x7684;&#x88dd;&#x7f6e;&#x8868;&#x6703;&#x5c07;&#x4f5c;&#x7528;&#x4e2d;&#x4e3b;&#x8981;&#x7de8;&#x865f;&#x7684;&#x6578;&#x76ee;&#x9650;&#x5236;&#x70ba; 1024"/>
<node CREATED="1460964890427" ID="ID_1364536530" LINK="https://goo.gl/HGmnGF" MODIFIED="1460964953063" TEXT="5.1.2. Creating the Volume Group"/>
</node>
<node CREATED="1450542436875" FOLDED="true" ID="ID_213496175" MODIFIED="1461060180077" TEXT="Logical volumes (lv)">
<node CREATED="1450544673837" FOLDED="true" ID="ID_892546625" MODIFIED="1451185944229" TEXT="three type of logical volumes">
<node CREATED="1450544684843" FOLDED="true" MODIFIED="1458539271034" TEXT="Linear">
<node CREATED="1450544731462" MODIFIED="1450544732310" TEXT="default"/>
</node>
<node CREATED="1450544692761" MODIFIED="1450544693282" TEXT="Striped"/>
<node CREATED="1450544699441" MODIFIED="1450544700096" TEXT="Mirrored"/>
</node>
<node CREATED="1387252726851" FOLDED="true" ID="ID_1521628400" MODIFIED="1460538229590" TEXT="lvresize">
<node CREATED="1450542768088" MODIFIED="1450542768957" TEXT="lvextend">
<node CREATED="1460513935323" LINK="http://goo.gl/gy8FBs" MODIFIED="1460513942185" TEXT="&#x53ea;&#x80fd;&#x63a5;&#x6b63;&#x503c;"/>
</node>
<node CREATED="1458549813228" LINK="https://goo.gl/R3D95H" MODIFIED="1460513846361" TEXT="lvreduce">
<node CREATED="1460514011970" LINK="http://goo.gl/vwC6fT" MODIFIED="1460514020320" TEXT="11.10. Reducing a logical volume"/>
<node CREATED="1460513896594" LINK="http://goo.gl/gy8FBs" MODIFIED="1460513905962" TEXT="&#x5f8c;&#x9762;&#x53ea;&#x80fd;&#x63a5;&#x8ca0;&#x503c;"/>
</node>
<node CREATED="1460514280219" MODIFIED="1460514280760" TEXT="--resizefs">
<node CREATED="1460514268291" LINK="http://goo.gl/MXD7hm" MODIFIED="1460514294635" TEXT="Resize underlying filesystem together"/>
<node CREATED="1460514071034" LINK="https://goo.gl/sy17iR" MODIFIED="1460514175477" TEXT=" may be specified either in 1024 (iB) or 1000 (B) units.">
<icon BUILTIN="info"/>
</node>
<node CREATED="1460516547371" LINK="http://goo.gl/MXD7hm" MODIFIED="1460516560948" TEXT="With the + or - sign the value is added or subtracted from the actual size"/>
</node>
</node>
<node CREATED="1387263948225" LINK="http://www.tcpdump.com/kb/os/linux/lvm-resizing-guide/all-pages.html" MODIFIED="1387264829307" TEXT="resize the logical volume">
<icon BUILTIN="full-2"/>
</node>
<node CREATED="1450543487164" FOLDED="true" ID="ID_1897215676" LINK="http://goo.gl/GIbxvB" MODIFIED="1460966173527" TEXT="lvcreate">
<node CREATED="1450544844123" LINK="http://tinyurl.com/gpxrb7f" MODIFIED="1450544855628" TEXT="to be allocated from a specific physical volume in the volume group"/>
<node CREATED="1450545162315" LINK="http://tinyurl.com/4tvucd9" MODIFIED="1450545167025" TEXT="-l"/>
<node CREATED="1450545333514" MODIFIED="1450545334245" TEXT="sudo lvcreate -l 100%PVS -n ccache ubuntu-vg /dev/sda6"/>
<node CREATED="1451183610738" ID="ID_1886020543" MODIFIED="1451186358872" TEXT="sudo lvcreate -l 80%PVS -n out ubuntu-vg-out /dev/sda10"/>
<node CREATED="1460962114783" ID="ID_869364147" LINK="https://goo.gl/CtBZlA" MODIFIED="1460962129445" TEXT="4.4.1. Creating Logical Volumes">
<node CREATED="1460962148919" ID="ID_1023573986" MODIFIED="1460962149949" TEXT="linear volumes"/>
<node CREATED="1460962158071" ID="ID_1307631383" MODIFIED="1460962176209" TEXT="striped volumes,">
<icon BUILTIN="help"/>
</node>
<node CREATED="1460962169663" ID="ID_1802726277" MODIFIED="1460962170332" TEXT="striped volumes,"/>
<node CREATED="1460962215599" ID="ID_1737747843" MODIFIED="1460962216445" TEXT="from a volume group"/>
</node>
</node>
<node CREATED="1450542109786" ID="ID_1923822679" MODIFIED="1450542114150" TEXT="lvdisplay"/>
<node CREATED="1460966145382" ID="ID_650938291" MODIFIED="1460966147334" TEXT="lvs"/>
<node CREATED="1450545695554" ID="ID_16124837" MODIFIED="1450545699095" TEXT="lvscan"/>
<node CREATED="1451185618484" MODIFIED="1451185621307" TEXT="lvremove"/>
<node CREATED="1458544971077" LINK="http://goo.gl/xd2udh" MODIFIED="1458556913495" TEXT="lvm&#x4fee;&#x6539;&#x6839;&#x5206;&#x533a;&#x5927;&#x5c0f;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1460542881972" LINK="http://goo.gl/u9qIs5" MODIFIED="1460542978145" TEXT="Next we remove the journal from /dev/sda1, thus turning it into an ext2 partition">
<icon BUILTIN="yes"/>
</node>
<node CREATED="1460963149968" ID="ID_1454666100" LINK="http://goo.gl/HQf8JO" MODIFIED="1460963168251" TEXT="there is a limit of 65,536 physical extents (PE) per logical volume (LV)"/>
<node CREATED="1460963107056" ID="ID_1147826062" MODIFIED="1460963110638" TEXT="Maximum Size Of A Logical Volume">
<icon BUILTIN="help"/>
</node>
<node CREATED="1460963215280" ID="ID_1006002325" LINK="http://goo.gl/HQf8JO" MODIFIED="1460963497681" TEXT="the maximum size of single LV">
<node CREATED="1460963236688" ID="ID_325129317" MODIFIED="1460963237437" TEXT="limited by">
<node CREATED="1460963247824" ID="ID_862203205" MODIFIED="1460963251943" TEXT="CPU architecture"/>
<node CREATED="1460963252915" ID="ID_1786852030" MODIFIED="1460963252915" TEXT="and Linux kernel version"/>
</node>
<node CREATED="1460963319055" ID="ID_802131301" MODIFIED="1460963320108" TEXT="32-bit CPU and Linux kernel version 2.6.x">
<node CREATED="1460963333152" ID="ID_1098401368" MODIFIED="1460963333886" TEXT="the limit of logical volume size is maximized at 16TB"/>
</node>
<node CREATED="1460963289896" ID="ID_98086576" MODIFIED="1460963290731" TEXT="2.6.x running on 64-bit CPU">
<node CREATED="1460963300223" ID="ID_1400100467" MODIFIED="1460963300970" TEXT=" the maximum LV size is 8EB"/>
</node>
</node>
</node>
<node CREATED="1460543814358" LINK="http://goo.gl/bj7Jh" MODIFIED="1460543834692" TEXT="good chart to describe the architecture">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1460962489063" ID="ID_274505139" MODIFIED="1460962498414" TEXT="extent">
<node CREATED="1460963042416" ID="ID_61092715" MODIFIED="1460963043654" TEXT="physical extent">
<node CREATED="1460962950515" ID="ID_797650083" LINK="http://goo.gl/neRIHl" MODIFIED="1460962970563" TEXT="we&apos;re limited to a 2TB volume size."/>
</node>
<node CREATED="1460963063256" ID="ID_198194198" MODIFIED="1460963071217" TEXT="aka volume">
<icon BUILTIN="help"/>
</node>
</node>
</node>
</node>
</map>

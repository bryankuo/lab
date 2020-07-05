<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1394691273366" ID="ID_501231664" LINK="applications.mm" MODIFIED="1462175116710" TEXT="busybox">
<node CREATED="1453643048746" LINK="#ID_1530617079" MODIFIED="1453643056686" POSITION="right" TEXT="busybox"/>
<node CREATED="1394691301241" MODIFIED="1453642983706" POSITION="right" TEXT="where is the printf source for busybox">
<icon BUILTIN="help"/>
<node CREATED="1394691416201" MODIFIED="1394691416889" TEXT="Where can I find the printf (user program) source?"/>
<node CREATED="1394691401849" MODIFIED="1394691402824" TEXT="Here is Glibc printf.c code"/>
<node CREATED="1394691431577" MODIFIED="1394691432241" TEXT="You can see Glibc vfprintf.c (glibc-2.18/stdio-common/vfprintf.c)"/>
<node CREATED="1394691460233" FOLDED="true" MODIFIED="1428906014471" TEXT="busybox is typically built using uclibc">
<node CREATED="1394691483225" LINK="http://www.uclibc.org/" MODIFIED="1394691486400" TEXT="http://www.uclibc.org/"/>
</node>
<node CREATED="1394691496537" FOLDED="true" MODIFIED="1428906014472" TEXT="The printf source code within uclibc is here">
<node CREATED="1394691507905" LINK="http://git.uclibc.org/uClibc/tree/libc/stdio/printf.c" MODIFIED="1394691510696" TEXT="http://git.uclibc.org/uClibc/tree/libc/stdio/printf.c"/>
</node>
<node CREATED="1394691519361" FOLDED="true" MODIFIED="1428906014472" TEXT="It eveentually winds up in _vfprintf here:">
<node CREATED="1394691528969" LINK="http://git.uclibc.org/uClibc/tree/libc/stdio/_vfprintf.c" MODIFIED="1394691531377" TEXT="http://git.uclibc.org/uClibc/tree/libc/stdio/_vfprintf.c"/>
</node>
</node>
<node CREATED="1449351261430" LINK="http://goo.gl/mKM1eO" MODIFIED="1449351274689" POSITION="right" TEXT="Build BusyBox"/>
<node CREATED="1453642986558" MODIFIED="1453642993961" POSITION="right" TEXT="labs"/>
<node CREATED="1453643297268" MODIFIED="1453643303195" POSITION="right" TEXT="how to upgrade"/>
<node CREATED="1453643369853" LINK="../qemu.mm" MODIFIED="1453643398571" POSITION="right" TEXT="busybox-based initramfs"/>
<node CREATED="1453645789685" MODIFIED="1453681021169" POSITION="right" TEXT="mdev">
<node CREATED="1453681021169" MODIFIED="1453681022785" TEXT=" is udev of busybox"/>
<node CREATED="1453681025760" MODIFIED="1453681041050" TEXT="use hotplug infrastructure"/>
</node>
<node CREATED="1459237663349" LINK="../tux.mm#ID_61103640" MODIFIED="1459237695760" POSITION="right" TEXT="uses UML for its testing"/>
<node CREATED="1462169227574" LINK="http://goo.gl/73Fy0I" MODIFIED="1462169238609" POSITION="right" TEXT="BusyBox &#x539f;&#x59cb;&#x78bc;&#x4e0b;&#x8f09;,&#x7f16;&#x8b6f;,&#x5b89;&#x88dd;&#x8207;&#x4f7f;&#x7528;">
<node CREATED="1462170154177" MODIFIED="1462170155176" TEXT="&#x672c;&#x6587;&#x5de5;&#x4f5c;&#x74b0;&#x5883;&#x70ba; Ubuntu 14.04 LTS, 64-&#x4f4d;&#x5143;, x86"/>
</node>
<node CREATED="1462170167159" LINK="../qemu.mm" MODIFIED="1462170184401" POSITION="right" TEXT="qemu"/>
<node CREATED="1462172591984" MODIFIED="1462172594166" POSITION="right" TEXT=" make menuconfig"/>
<node CREATED="1462172786630" ID="ID_1940801772" LINK="http://goo.gl/PKYtgl" MODIFIED="1462172795473" POSITION="right" TEXT="&#x4f7f;&#x7528; busybox &#x5efa;&#x7f6e; Root Filesystem">
<node CREATED="1462173053478" MODIFIED="1462173058631" TEXT="toolchain">
<icon BUILTIN="help"/>
</node>
<node CREATED="1462172391038" LINK="http://goo.gl/PKYtgl" MODIFIED="1462172404819" TEXT="Runtime SUID/SGID configuration via /etc/busybox.conf">
<icon BUILTIN="help"/>
</node>
<node CREATED="1462172644478" MODIFIED="1462172645147" TEXT="&#x5df2;&#x7d93;&#x5305;&#x542b;&#x4e86;udev&#x7684;&#x7c21;&#x5316;&#x7248;&#x672c;&#x5373;mdev"/>
<node CREATED="1462172770075" MODIFIED="1462172770765" TEXT="&#x5efa;&#x7acb;root filesystem &#x6240;&#x9700;&#x7684;&#x76ee;&#x9304;&#x548c;&#x6587;&#x4ef6;"/>
</node>
<node CREATED="1462175097099" ID="ID_567730194" LINK="https://goo.gl/5CUFWG" MODIFIED="1462175185896" POSITION="right" TEXT="Busybox run on Qemu">
<node CREATED="1462175206015" ID="ID_263869713" MODIFIED="1462175206774" TEXT="Download arm cross compiler from CodeSourcery"/>
</node>
<node CREATED="1462175443108" ID="ID_929694394" LINK="https://goo.gl/QVNXFM" MODIFIED="1462193119068" POSITION="right" TEXT="Compile Linux, BusyBox for ARM and load it using QEMU">
<icon BUILTIN="info"/>
<node CREATED="1462193122180" ID="ID_1968709262" MODIFIED="1462193123031" TEXT="linux-3.10.tar.bz2"/>
<node CREATED="1462177646665" ID="ID_613095183" LINK="https://goo.gl/XPf3ZV" MODIFIED="1462177660506" TEXT="Prerequisites">
<node CREATED="1462177624183" ID="ID_1692923793" LINK="http://goo.gl/wEIlwJ" MODIFIED="1462177634985" TEXT="build-essential"/>
</node>
<node CREATED="1462175367558" ID="ID_196066478" LINK="https://goo.gl/QVNXFM" MODIFIED="1462175377780" TEXT="Compiling Linux from Source for ARM architecture"/>
<node CREATED="1462175400361" FOLDED="true" ID="ID_1287617373" LINK="https://goo.gl/XMMyt1" MODIFIED="1462192007632" TEXT="Compiling BusyBox from source for ARM architecture">
<node CREATED="1462178368502" ID="ID_284732161" MODIFIED="1462178369353" TEXT="Once the build is complete, a folder named _install is created"/>
<node CREATED="1462178385681" ID="ID_1536280040" MODIFIED="1462178386423" TEXT="This folder contains a bare structure of the linux root file system. "/>
<node CREATED="1462178583838" ID="ID_602692733" LINK="https://goo.gl/joXs0E" MODIFIED="1462178603780" TEXT="Create etc/init.d/rcS file and enter the following shell code"/>
<node CREATED="1462179050697" ID="ID_366032200" MODIFIED="1462179051316" TEXT="Create the root filesystem image with the cpio tool."/>
</node>
<node CREATED="1462175418566" ID="ID_179514559" MODIFIED="1462175419210" TEXT="Running Linux with BusyBox on Linux for ARM on QEMU"/>
</node>
<node CREATED="1462191844121" ID="ID_1062167988" LINK="http://goo.gl/eSVGSZ" MODIFIED="1462191857459" POSITION="right" TEXT="Linux on ARM emulator bringup">
<node CREATED="1462191823329" ID="ID_1862405775" MODIFIED="1462191824093" TEXT="build and run Linux kernel 4.X on QEMU for versatile or vexpress configs"/>
</node>
<node CREATED="1462192844026" ID="ID_1165171847" LINK="http://goo.gl/JiD7hp" MODIFIED="1462192862548" POSITION="right" TEXT="Building Linux kernel with Busybox for ARM VersatilePB">
<node CREATED="1462192929866" ID="ID_1864910363" MODIFIED="1462192930406" TEXT="test it on QEMU emulator on VersatilePB platform"/>
<node CREATED="1462192904580" ID="ID_1345159262" MODIFIED="1462192905240" TEXT="use Linux kernel 3.10 from android repository for Goldfish"/>
<node CREATED="1462192980349" ID="ID_1324074693" MODIFIED="1462192980906" TEXT="Before bulding the source code make sure that you have ">
<node CREATED="1462192819446" ID="ID_1920221426" MODIFIED="1462192820006" TEXT="arm-none-eabi- toolchain for the kernel"/>
<node CREATED="1462192831820" ID="ID_1558213282" MODIFIED="1462192832322" TEXT="arm-linux-gnueabi- one for a user space environment (busybox)"/>
</node>
</node>
</node>
</map>

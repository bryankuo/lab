<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1354156126906" ID="ID_1284148317" LINK="../android.mm" MODIFIED="1431247754737" TEXT="NDK">
<node CREATED="1370391381034" LINK="http://www.javaworld.com.tw/jute/post/view?bid=11&amp;id=298481&amp;sty=3" MODIFIED="1370393195882" POSITION="left" TEXT="JNI &#x958b;&#x767c;&#x7b46;&#x8a18; (4) Android NDK &#x7c21;&#x4ecb;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1356598586296" FOLDED="true" ID="ID_1354860979" MODIFIED="1428649722268" POSITION="left" TEXT="info">
<node CREATED="1354240577515" FOLDED="true" ID="ID_101517289" MODIFIED="1428649722268" TEXT="docs">
<node CREATED="1354262358875" FOLDED="true" ID="ID_624845547" MODIFIED="1428649722267" TEXT="documentation.html">
<node CREATED="1354240582687" FOLDED="true" ID="ID_1865522774" MODIFIED="1428649722267" TEXT="overview.html">
<node CREATED="1354247913843" MODIFIED="1354247915375" TEXT="NDK provides a helper script, named &apos;ndk-gdb&apos;"/>
</node>
<node CREATED="1354258207468" MODIFIED="1354262381062" TEXT="STANDALONE-TOOLCHAIN.html"/>
</node>
<node CREATED="1357784577468" LINK="http://www.kandroid.org/ndk/docs/OVERVIEW.html" MODIFIED="1357784593390" TEXT="overview"/>
</node>
<node CREATED="1354156136781" LINK="http://developer.android.com/tools/sdk/ndk/index.html" MODIFIED="1354156214281" TEXT="download"/>
<node CREATED="1356598563984" LINK="https://groups.google.com/forum/?fromgroups#!forum/android-ndk" MODIFIED="1356598583625" TEXT="google group"/>
</node>
<node CREATED="1359242276808" FOLDED="true" ID="ID_207515288" MODIFIED="1428649722270" POSITION="left" TEXT="ndk/build/tools/">
<icon BUILTIN="info"/>
<node CREATED="1359239951626" FOLDED="true" ID="ID_1879388640" LINK="http://vec.io/posts/how-to-build-ffmpeg-with-android-ndk#toc-configure-ndk" MODIFIED="1428649722268" TEXT="standalone toolchain">
<node CREATED="1359240166796" MODIFIED="1359240369731" TEXT="make-standalone-toolchain.sh">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1359241023831" FOLDED="true" ID="ID_626389335" MODIFIED="1428649722269" TEXT="dev-scripts">
<node CREATED="1359241246384" MODIFIED="1359241248926" TEXT="A sysroot is a directory containing system headers and libraries"/>
<node CREATED="1359241273168" MODIFIED="1359241274758" TEXT="compiler will use to build a few required target-specific binaries"/>
</node>
<node CREATED="1359241832455" FOLDED="true" ID="ID_603523761" MODIFIED="1428649722269" TEXT="SYSROOT">
<node CREATED="1359241545719" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-ndk/1TxJiOW95LE" MODIFIED="1359241573802" TEXT="C and other headers are in $NDK/platforms/android-zzzz/arch-yyyy/usr/"/>
<node CREATED="1359241559482" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-ndk/1TxJiOW95LE" MODIFIED="1359241578596" TEXT="which is also known as the SYSROOT"/>
<node CREATED="1359241802467" FOLDED="true" ID="ID_1746189" MODIFIED="1428649722269" TEXT="wondering why C++ headers are not part of the  SYSROOT">
<node CREATED="1359241819442" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-ndk/1TxJiOW95LE" MODIFIED="1359241861517" TEXT=" because we provide several distinct C++ runtime implementations."/>
</node>
</node>
<node CREATED="1359242082880" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-ndk/sunL9bW6gC4" MODIFIED="1359242099557" TEXT="How to build Android NDK by myself">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1362738586609" LINK="file:///E:/android/ndk/r8c/documentation.html" MODIFIED="1362738606734" POSITION="left" TEXT="By default, ndk-build places all intermediate generated files under $PROJECT/obj"/>
<node CREATED="1364257200269" LINK="http://stackoverflow.com/questions/10098049/android-ndk-build-ignoring-app-abi-x86" MODIFIED="1364257219829" POSITION="left" TEXT="Android ndk-build ignoring APP_ABI := x86">
<icon BUILTIN="help"/>
</node>
<node CREATED="1372818083920" ID="ID_1830497479" LINK="http://wp.me/p1El9Q-3" MODIFIED="1372818111052" POSITION="left" TEXT="Compile C/C++ ARM binary (Static Library) for Android using Standalone toolchain"/>
<node CREATED="1359300379174" FOLDED="true" ID="ID_585332528" MODIFIED="1428649722271" POSITION="left" TEXT="debug">
<node CREATED="1357108552256" FOLDED="true" ID="ID_1794278620" MODIFIED="1428649722270" TEXT="ndk-gdb">
<node CREATED="1357108559178" MODIFIED="1357108570772" TEXT="how to use">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1358752695390" FOLDED="true" ID="ID_1726498494" LINK="http://www.codexperiments.com/android/2010/08/tips-tricks-debugging-android-ndk-stack-traces/" MODIFIED="1428649722270" TEXT="Debugging with Android NDK stack traces">
<icon BUILTIN="info"/>
<node CREATED="1358752736031" MODIFIED="1358752737687" TEXT="arm-eabi-addr2line"/>
<node CREATED="1358752755718" MODIFIED="1358752757234" TEXT="native code is compiled in Debug mode to access code information"/>
</node>
<node CREATED="1361095398188" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-ndk/Id9t7X5ODFE" MODIFIED="1361096294850" TEXT="output to file"/>
</node>
<node CREATED="1363251422296" ID="ID_419559719" LINK="https://code.google.com/p/android/issues/detail?id=3434" MODIFIED="1363251438734" POSITION="left" TEXT="need NDK support for real-time low latency audio; synchronous play and record"/>
<node CREATED="1369791808906" FOLDED="true" ID="ID_1024564763" MODIFIED="1428649722272" POSITION="left" TEXT="plugin">
<node CREATED="1366860548609" FOLDED="true" ID="ID_1152193859" MODIFIED="1428649722271" TEXT="HelloWorld &#x5305;&#x542b; NDK Plugin">
<node CREATED="1366860532265" MODIFIED="1366860533890" TEXT="NDK&#x63d2;&#x4ef6;&#x90e8;&#x5206;"/>
<node CREATED="1366860508203" LINK="http://cheng-min-i-taiwan.blogspot.tw/2012/06/androidandroid-sdk-r20-helloworld-ndk.html" MODIFIED="1369791739781" TEXT="&#x78ba;&#x5b9a;&#x9084;&#x662f;&#x8981;&#x5b89;&#x88dd;Cygwin">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1369791768015" FOLDED="true" ID="ID_1600321014" MODIFIED="1428649722271" TEXT="steps">
<node CREATED="1366936975967" ID="ID_490732482" MODIFIED="1366936999890" TEXT="install NDK plugin">
<icon BUILTIN="full-1"/>
</node>
<node CREATED="1366936986542" ID="ID_1931296350" MODIFIED="1366937002841" TEXT="specify NDK path">
<icon BUILTIN="full-2"/>
</node>
<node CREATED="1366860099546" LINK="http://tools.android.com/recent/usingthendkplugin" MODIFIED="1366941769296" TEXT="Using the NDK plugin">
<icon BUILTIN="full-3"/>
</node>
<node CREATED="1366941795406" LINK="http://blog.csdn.net/Mirage520/article/details/8042469" MODIFIED="1366941824812" TEXT="NDK_DEBUG=1  &#x7b49;&#x53f7;&#x5de6;&#x53f3;&#x4e5f;&#x4e0d;&#x80fd;&#x6709;&#x7a7a;&#x683c;">
<icon BUILTIN="full-4"/>
</node>
<node CREATED="1366943008031" ID="ID_1469888799" MODIFIED="1366943016484" TEXT="Path and Symbols">
<icon BUILTIN="full-5"/>
</node>
<node CREATED="1366942415265" LINK="http://blog.csdn.net/hgl868/article/details/6724276" MODIFIED="1366942428703" TEXT="NDK Build &#x53c2;&#x6570;"/>
<node CREATED="1362737533265" LINK="http://mhandroid.wordpress.com/2011/01/23/using-eclipse-for-android-cc-development/" MODIFIED="1362737545375" TEXT="Using Eclipse for Android C/C++ Development"/>
</node>
<node CREATED="1366552901739" LINK="https://github.com/appunite/AndroidFFmpeg" MODIFIED="1366553097963" TEXT=" If you have adt &gt;= 20.0 you can click right mouse button on project "/>
<node CREATED="1366872027781" LINK="http://stackoverflow.com/questions/7667017/fixing-eclipse-errors-when-using-android-ndk-and-stdvector" MODIFIED="1366872041453" TEXT="Fixing Eclipse errors when using Android NDK and std::vector"/>
<node CREATED="1366873914093" LINK="http://stackoverflow.com/questions/10534367/how-to-get-ndk-gdb-working-on-android" MODIFIED="1366873927312" TEXT="How to get ndk-gdb working on Android?"/>
<node CREATED="1357722526746" LINK="http://mobilepearls.com/labs/ndk-builder-in-eclipse/" MODIFIED="1357722539309" TEXT="Setting up Automatic NDK Builds in Eclipse"/>
</node>
<node CREATED="1372722766719" FOLDED="true" ID="ID_704264505" MODIFIED="1428649722272" POSITION="left" TEXT="cygwin">
<node CREATED="1370318451609" LINK="http://stackoverflow.com/questions/8384213/android-ndk-revision-7-host-awk-tool-is-outdated-error" MODIFIED="1370318596562" TEXT="ndk revision 7 onwards, ndk source can be built without cygwin">
<icon BUILTIN="info"/>
</node>
<node CREATED="1370336992281" LINK="http://stackoverflow.com/questions/15459934/unable-to-launch-cygpath-in-android" MODIFIED="1370337008000" TEXT="With NDK r8d, you don&apos;t need cygwin"/>
<node CREATED="1354182685218" LINK="http://www.cnblogs.com/scottwong/archive/2010/12/17/1909455.html" MODIFIED="1373326034228" TEXT="&#x7528; Cygwin &#x4e0d;&#x884c;&#xff0c;&#x6709;&#x53c2;&#x6570;&#x957f;&#x5ea6;&#x9650;&#x5236;"/>
</node>
<node CREATED="1370316737734" FOLDED="true" ID="ID_274271446" MODIFIED="1428649722274" POSITION="left" TEXT="Samples">
<node CREATED="1370312863500" MODIFIED="1370312874734" TEXT="hello-jni"/>
<node CREATED="1370312875093" MODIFIED="1370312878828" TEXT="hello-gl2"/>
<node CREATED="1370313315703" FOLDED="true" ID="ID_1140570746" MODIFIED="1428649722273" TEXT="hello-neon">
<node CREATED="1370313394875" FOLDED="true" ID="ID_740423881" MODIFIED="1428649722272" TEXT="helloneon.c">
<node CREATED="1370313330203" MODIFIED="1370313331078" TEXT="android_getCpuFeatures"/>
<node CREATED="1370313385203" MODIFIED="1370313386453" TEXT="android_getCpuFamily"/>
</node>
</node>
<node CREATED="1370312891156" ID="ID_1208907034" MODIFIED="1370312897390" TEXT="hello-jni-test"/>
<node CREATED="1370315138140" MODIFIED="1370315141453" TEXT="two-libs"/>
<node CREATED="1370316525046" FOLDED="true" ID="ID_1153995488" LINK="http://goo.gl/YHvNh" MODIFIED="1428649722273" TEXT="NativeActivity">
<node CREATED="1370316384125" LINK="http://www.klayge.org/2011/12/13/%E4%BF%AE%E6%94%B9android_native_app_glue%EF%BC%8C%E7%AE%80%E5%8C%96android%E7%9A%84%E7%BA%AFcc%E7%BC%96%E7%A8%8B/" MODIFIED="1370316405984" TEXT="android_native_app_glue"/>
<node CREATED="1370316536562" MODIFIED="1370316550671" TEXT="using android_native_app_glue"/>
<node CREATED="1370316551296" MODIFIED="1370316556031" TEXT="android_main"/>
</node>
<node CREATED="1370167767768" MODIFIED="1370167771223" TEXT="plasma"/>
<node CREATED="1370167899264" MODIFIED="1370167900253" TEXT="GL2JNIActivity"/>
<node CREATED="1370316730078" FOLDED="true" ID="ID_2974370" MODIFIED="1428649722273" TEXT="NavitveAudio">
<node CREATED="1370338981906" MODIFIED="1370338997093" TEXT="LAB - test adding native support"/>
<node CREATED="1370342535562" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;cad=rja&amp;ved=0CDAQFjAA&amp;url=http%3A%2F%2Fvisualgdb.com%2Ftutorials%2Fandroid%2Fnative-audio%2F&amp;ei=uMOtUcaqFMe2kAXrlIAo&amp;usg=AFQjCNFepnA72TfGPCW4eMxNPrudo0Z37g&amp;sig2=1ith5Yo6eEpbYLnnrsJfXQ" MODIFIED="1370342558171" TEXT="Debugging the native-audio project with Visual Studio"/>
</node>
<node CREATED="1372140085545" FOLDED="true" ID="ID_716738583" MODIFIED="1428649722273" TEXT="NativeMedia">
<node CREATED="1372144499654" MODIFIED="1372144540166" TEXT="playing .ts file is not working"/>
<node CREATED="1372144518911" LINK="http://stackoverflow.com/questions/14021227/android-ndk-sample-code-for-playing-ts-file-is-not-working" MODIFIED="1372144570397" TEXT="Actually the problem was with ts file"/>
</node>
</node>
<node CREATED="1372918464546" LINK="http://stackoverflow.com/questions/15330385/android-ndk-linker-errors-to-shared-libraries" MODIFIED="1372919757602" POSITION="left" TEXT="add cpp"/>
<node CREATED="1369099368218" FOLDED="true" ID="ID_1408394822" MODIFIED="1428649722274" POSITION="left" TEXT="ant">
<node CREATED="1369099546968" MODIFIED="1369099553765" TEXT="configuration"/>
<node CREATED="1369795665109" LINK="http://tungchingkai.blogspot.tw/2011/08/how-to-build-android-ndk-sample-using.html" MODIFIED="1369795681343" TEXT="How to build Android ndk sample using ant"/>
</node>
<node CREATED="1369884316890" ID="ID_753352305" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=3&amp;cad=rja&amp;ved=0CEIQFjAC&amp;url=http%3A%2F%2Fj796160836.pixnet.net%2Fblog%2Fpost%2F31583827-%255Bandroid%255D-%25E5%25AE%2589%25E8%25A3%259Dndk%25E8%2588%2587%25E4%25BD%25BF%25E7%2594%25A8jni%25E5%2591%25BC%25E5%258F%25AB%25E7%25B3%25BB%25E7%25B5%25B1%25E5%25BA%2595%25E5%25B1%25A4native%25E7%259A%2584c-&amp;ei=4cSmUYSpFoLeigeSg4CABw&amp;usg=AFQjCNG8KwIDdSI3Scqx4tV-Lf0huinSug&amp;sig2=VaTnvubc97uVPOVU8Tp7sg" MODIFIED="1369884336281" POSITION="left" TEXT="[Android] &#x5b89;&#x88dd;NDK&#x8207;&#x4f7f;&#x7528;JNI&#x547c;&#x53eb;&#x7cfb;&#x7d71;&#x5e95;&#x5c64;native&#x7684;C/C++&#x7a0b;&#x5f0f;"/>
<node CREATED="1407467726493" ID="ID_1583176552" LINK="http://goo.gl/MkNl2f" MODIFIED="1407467741426" POSITION="left" TEXT="NDK Build &#x7528;&#x6cd5;&#xff08;NDK Build&#xff09;"/>
<node CREATED="1407821937688" ID="ID_855407263" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=40&amp;cad=rja&amp;uact=8&amp;ved=0CHYQFjAJOB4&amp;url=http%3A%2F%2Fwww.eoeandroid.com%2Fthread-326484-1-1.html&amp;ei=AYTpU67yHpTo8AW3tIDoAw&amp;usg=AFQjCNGzlQb6gqF8vMebHWGJ_jJ5JfBCZw&amp;sig2=ZEJXgdClWqUN7t5u-_TcdQ" MODIFIED="1407821957718" POSITION="left" TEXT="NDK&#x4f7f;&#x7528;distcc&#x5206;&#x5e03;&#x5f0f;&#x7f16;&#x8bd1;"/>
<node CREATED="1366702970359" ID="ID_153740935" LINK="http://cheng-min-i-taiwan.blogspot.tw/2012/05/ubuntu-1204-lts-android-sdk.html" MODIFIED="1366702985421" POSITION="right" TEXT="&#x5728; Ubuntu 12.04 LTS &#x5b89;&#x88dd; Android SDK&amp;NDK &#x958b;&#x767c;&#x74b0;&#x5883;"/>
<node CREATED="1370180326965" FOLDED="true" ID="ID_971725817" MODIFIED="1428649722274" POSITION="right" TEXT="NDK sampe - GL2JNI">
<node CREATED="1370180404380" ID="ID_1021850755" MODIFIED="1370180405421" TEXT="RGB_565 opaque surface"/>
<node CREATED="1370180886366" ID="ID_1270756554" MODIFIED="1370180887554" TEXT="ContextFactory"/>
</node>
<node CREATED="1372724194609" FOLDED="true" ID="ID_1011313637" MODIFIED="1428649722276" POSITION="right" TEXT="build system">
<node CREATED="1358501076906" FOLDED="true" ID="ID_565778580" LINK="http://blog.csdn.net/yili_xie/article/details/4906865" MODIFIED="1428649722275" TEXT="Android build system note">
<icon BUILTIN="info"/>
<node CREATED="1358501101250" ID="ID_1367569811" MODIFIED="1358501102828" TEXT="&#x7f16;&#x8bd1;&#x811a;&#x672c;&#x53ca;&#x7cfb;&#x7edf;&#x53d8;&#x91cf;"/>
<node CREATED="1358501119078" ID="ID_1431828523" MODIFIED="1358501121500" TEXT="include $(CLEAR_VARS) -&#x6e05;&#x9664;&#x4e4b;&#x524d;&#x7684;&#x4e00;&#x4e9b;&#x7cfb;&#x7edf;&#x53d8;&#x91cf;"/>
</node>
<node CREATED="1358501504093" ID="ID_1313287317" LINK="http://orsonlife.blogspot.tw/2009/12/androidmk.html" MODIFIED="1358501522296" TEXT="&#x5e38;&#x7528;&#x7684;&#x5beb;&#x6cd5;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1358501784687" ID="ID_1270630999" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-porting/qMaEYZtyRFo" MODIFIED="1358501808156" TEXT="difference LOCAL_SHARED_LIBRARIES and LOCAL_LDLIBS"/>
<node CREATED="1354239816390" FOLDED="true" ID="ID_761427865" MODIFIED="1428649722275" TEXT="Android.mk">
<node CREATED="1353989521640" ID="ID_340002340" LINK="http://mindtherobot.com/blog/452/android-beginners-ndk-setup-step-by-step/" MODIFIED="1353989531640" TEXT="for the NDK build process to recognize your NDK modules"/>
<node CREATED="1354257756703" FOLDED="true" ID="ID_1113578708" MODIFIED="1428649722275" TEXT="parameters">
<node CREATED="1354258434187" ID="ID_1775271706" MODIFIED="1354258436953" TEXT="LOCAL_MODULE_TAGS"/>
</node>
<node CREATED="1354258507140" FOLDED="true" ID="ID_190497239" MODIFIED="1428649722275" TEXT="blogs">
<node CREATED="1354258511031" ID="ID_159929273" LINK="http://tw.myblog.yahoo.com/blue-comic/article?mid=674&amp;prev=676&amp;l=f&amp;fid=35" MODIFIED="1354258526312" TEXT="Android Makefile &#x7a2e;&#x985e;"/>
<node CREATED="1354241750265" ID="ID_1764691489" LINK="http://zensheno.blog.51cto.com/2712776/501371" MODIFIED="1354241762093" TEXT="Android.mk&#x6587;&#x4ef6;&#x8bed;&#x6cd5;&#x89c4;&#x8303;"/>
</node>
</node>
<node CREATED="1372839389602" ID="ID_476941310" LINK="http://www.kandroid.org/ndk/docs/ANDROID-MK.html" MODIFIED="1372839403412" TEXT="Android.mk file syntax specification"/>
<node CREATED="1372909399294" FOLDED="true" ID="ID_104740184" LINK="http://branda.to/~thinker/GinGin_CGI.py/show_id_doc/393" MODIFIED="1428649722276" TEXT="Android Building System &#x5206;&#x6790;">
<node CREATED="1372909335479" ID="ID_487391716" MODIFIED="1372909343878" TEXT="package vs. module"/>
<node CREATED="1373334893135" ID="ID_1896987749" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=2&amp;cad=rja&amp;ved=0CDkQFjAB&amp;url=http%3A%2F%2Fmy.safaribooksonline.com%2Fbook%2Fprogramming%2Fandroid%2F9781449327958%2F4dot-the-build-system%2Fi_sect14_id398069_html&amp;ei=FG3bUYi3BOSTiQfN44HgDA&amp;usg=AFQjCNGpFdRVst4RtjLt24lqIq82huxZ0w&amp;sig2=WrzoQlQYNE8eechXBccMWg" MODIFIED="1373335264500" TEXT="the Android build system doesn&apos;t rely on recursive makefiles"/>
</node>
<node CREATED="1373335398223" ID="ID_115692321" LINK="https://aabdelfattah.wordpress.com/2013/04/08/android-build-system-ultimate-guide/#build-system-architecture" MODIFIED="1373335413285" TEXT="Android Build System Ultimate Guide"/>
<node CREATED="1373759754850" ID="ID_4513593" LINK="http://www.cnblogs.com/hesiming/archive/2011/03/15/1984444.html" MODIFIED="1373759774591" TEXT="android&#x7f16;&#x8bd1;&#x7cfb;&#x7edf;makefile(Android.mk)&#x5199;&#x6cd5;"/>
</node>
<node CREATED="1352363312156" FOLDED="true" ID="ID_725246150" MODIFIED="1428649722278" POSITION="right" TEXT="development">
<node CREATED="1354264270328" FOLDED="true" ID="ID_286754433" MODIFIED="1428649722276" TEXT=".so file">
<node CREATED="1354264308593" FOLDED="true" ID="ID_1643574973" MODIFIED="1428649722276" TEXT="placement">
<node CREATED="1354264278109" ID="ID_633808345" MODIFIED="1354264306859" TEXT="&lt;file system&gt;/&lt;package&gt;/lib"/>
</node>
</node>
<node CREATED="1354154530125" FOLDED="true" ID="ID_49698128" MODIFIED="1428649722277" TEXT="build system">
<node CREATED="1354499978640" ID="ID_424736993" LINK="http://blog.chinaunix.net/uid-22935566-id-2602677.html" MODIFIED="1354513917781" TEXT="understanding"/>
<node CREATED="1354239569734" FOLDED="true" ID="ID_577475545" MODIFIED="1428649722277" TEXT="ndk-build">
<node CREATED="1354154582546" FOLDED="true" ID="ID_1955201353" LINK="http://orsonlife.blogspot.tw/2009/12/androidmk.html" MODIFIED="1428649722277" TEXT="&#x5e7e;&#x7a2e;&#x91cd;&#x8981;&#x7684;&#x8a2d;&#x5b9a;&#x6a94;">
<node CREATED="1354172283390" ID="ID_1381061083" MODIFIED="1354172286656" TEXT="build-binary.mk"/>
</node>
</node>
<node CREATED="1354094004015" ID="ID_408526281" MODIFIED="1365899318173" TEXT="make files"/>
<node CREATED="1354263732609" FOLDED="true" ID="ID_1677349504" MODIFIED="1428649722277" TEXT="note">
<node CREATED="1354263725734" ID="ID_572390201" LINK="http://simonxanderandroid.blogspot.tw/2011/01/android-ffmpeg-eclipse-ndk-on-windows.html" MODIFIED="1354263747750" TEXT="&#x5728;window&#x4e0a;&#x4f7f;&#x7528;r5&#x53ef;&#x80fd;&#x6703;&#x6709;&#x6307;&#x4ee4;&#x592a;&#x9577;&#x7684;&#x932f;&#x8aa4;"/>
</node>
</node>
</node>
<node CREATED="1409191973839" ID="ID_1422429307" LINK="&#x6269;&#x5c55; Eclipse &#x73af;&#x5883;" MODIFIED="1409192211245" POSITION="right" TEXT="&#x6269;&#x5c55; Eclipse &#x73af;&#x5883;">
<icon BUILTIN="help"/>
<icon BUILTIN="info"/>
</node>
<node CREATED="1366552951703" FOLDED="true" ID="ID_634167224" MODIFIED="1431247754737" POSITION="left" TEXT="Native Support">
<node CREATED="1369883383359" ID="ID_746694789" LINK="https://code.google.com/p/awesomeguy/wiki/JNITutorial#JNITutorial" MODIFIED="1369883428234" TEXT="JNI tutorial by awesomeguy">
<icon BUILTIN="info"/>
</node>
<node CREATED="1369883467500" FOLDED="true" ID="ID_1572955825" MODIFIED="1428649718011" TEXT="tutorial">
<node CREATED="1369883477968" ID="ID_864556845" LINK="http://javapapers.com/core-java/how-to-call-a-c-program-from-java/" MODIFIED="1369883491218" TEXT="How to call a C program from Java?"/>
<node CREATED="1366697457078" FOLDED="true" ID="ID_1660957965" LINK="http://huenlil.pixnet.net/blog/post/23802146-%5B%E8%BD%89%5Djni%E8%88%87android-vm%E4%B9%8B%E9%97%9C%E4%BF%82" MODIFIED="1428649718011" TEXT="[&#x8f49;]JNI&#x8207;Android VM&#x4e4b;&#x95dc;&#x4fc2;">
<node CREATED="1366698661609" FOLDED="true" ID="ID_248267853" MODIFIED="1428649718011" TEXT="&#x5982;&#x4f55;&#x64b0;&#x5beb;*.so&#x7684;&#x5165;&#x53e3;&#x51fd;&#x6578;">
<node CREATED="1365899157966" FOLDED="true" ID="ID_1172967945" MODIFIED="1428649718010" TEXT="JNI_Onload">
<node CREATED="1366697362781" ID="ID_1975996793" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-ndk/ceqeb6POkhQ" MODIFIED="1369633880906" TEXT="How to obtain JavaVM pointer in jni cpp code"/>
<node CREATED="1369633806453" ID="ID_588359468" LINK="http://docs.oracle.com/javase/1.5.0/docs/guide/jni/spec/invocation.html" MODIFIED="1369633893328" TEXT="when the native library is loaded"/>
<node CREATED="1369638644890" ID="ID_1223689507" LINK="http://cheng-min-i-taiwan.blogspot.tw/2011/08/java-native-interface-jni-android-c.html" MODIFIED="1369638660281" TEXT="&#x7576;VM&#x57f7;&#x884c;&#x5230;System.loadLibrary()&#x51fd;&#x6578;&#x6642;&#xff0c;&#x9996;&#x5148;&#x6703;&#x53bb;&#x57f7;&#x884c;C&#x7d44;&#x4ef6;&#x88e1;&#x7684;JNI_OnLoad()&#x51fd;&#x6578;&#x3002;"/>
</node>
<node CREATED="1365899157966" ID="ID_459757213" MODIFIED="1365899161233" TEXT="JNI_OnUnload"/>
<node CREATED="1366870015453" ID="ID_869812599" LINK="http://cheng-min-i-taiwan.blogspot.tw/2012/06/androidandroid-sdk-r20-helloworld-ndk.html" MODIFIED="1366870031359" TEXT="&#x9019;&#x88e1;&#x662f;cpp&#x6a94;&#xff0c;&#x6240;&#x4ee5;&#x7a0b;&#x5f0f;&#x8a18;&#x5f97;&#x8981;&#x5beb;JNI_OnLoad&#x51fd;&#x5f0f;"/>
</node>
</node>
<node CREATED="1356660119046" ID="ID_1342354220" LINK="http://lipeng88213.iteye.com/blog/1292570" MODIFIED="1356660135046" TEXT="JNI&#x4e2d;&#x5e38;&#x7528;&#x7684;&#x65b9;&#x6cd5;"/>
<node CREATED="1353987663281" ID="ID_74921793" LINK="http://mindtherobot.com/blog/452/android-beginners-ndk-setup-step-by-step/" MODIFIED="1353999125390" TEXT="put your native pieces of code into libraries">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1369379776453" ID="ID_1156344648" LINK="http://www.electronicsweekly.com/eyes-on-android/programming/what-is-android-native-code-2011-11/" MODIFIED="1369379789140" TEXT="What is&#x2026; Android Native Development?"/>
</node>
<node CREATED="1370165113747" FOLDED="true" ID="ID_384157916" MODIFIED="1428649718011" TEXT="x86">
<node CREATED="1369883164593" ID="ID_1979855595" LINK="http://software.intel.com/en-us/articles/using-the-android-x86-ndk-with-eclipse-and-porting-an-ndk-sample-app" MODIFIED="1369883176812" TEXT="Using the Android* x86 NDK with Eclipse* and Porting an NDK Sample App"/>
</node>
<node CREATED="1369884488281" ID="ID_35047561" LINK="http://stackoverflow.com/questions/11504258/how-to-remove-native-support-from-an-android-project-in-eclipse-because-eclipse" MODIFIED="1369884501328" TEXT="How to remove native support from an Android Project"/>
<node CREATED="1353208261051" FOLDED="true" ID="ID_1050590034" LINK="ffmpeg/ffmpeg.mm" MODIFIED="1431247754737" TEXT="ffmpeg">
<arrowlink DESTINATION="ID_1050590034" ENDARROW="Default" ENDINCLINATION="0;0;" ID="Arrow_ID_284529405" STARTARROW="None" STARTINCLINATION="0;0;"/>
<linktarget COLOR="#b0b0b0" DESTINATION="ID_1050590034" ENDARROW="Default" ENDINCLINATION="0;0;" ID="Arrow_ID_284529405" SOURCE="ID_1050590034" STARTARROW="None" STARTINCLINATION="0;0;"/>
<node CREATED="1357550355187" FOLDED="true" ID="ID_348607346" MODIFIED="1428649718013" TEXT="application">
<node CREATED="1357550369765" FOLDED="true" ID="ID_200171755" LINK="https://github.com/faywong/FFplayer" MODIFIED="1428649718012" TEXT="faywong / FFplayer">
<node CREATED="1357550474781" ID="ID_1958235096" MODIFIED="1357550497515" TEXT="base on the ffmpeg native code"/>
<node CREATED="1357550490656" ID="ID_676977123" MODIFIED="1357729764215" TEXT="to support the playback of local/HLS streaming">
<icon BUILTIN="button_cancel"/>
</node>
</node>
<node CREATED="1361158209250" FOLDED="true" ID="ID_587665824" MODIFIED="1428649718012" TEXT="RTMP">
<node CREATED="1354244777281" ID="ID_673369070" LINK="http://bashell.sinaapp.com/archives/using-ffmpeg-1_0-rtmp-protocol-decode-h264-stream.html" MODIFIED="1354244791843" TEXT="&#x4f7f;&#x7528;ffmpeg-1.0&#x5185;&#x7f6e;RTMP&#x534f;&#x8bae;&#x5b9e;&#x65f6;&#x89e3;&#x7801;H264&#x89c6;&#x9891;&#x6d41;"/>
</node>
<node CREATED="1362477930234" FOLDED="true" ID="ID_413687633" MODIFIED="1428649718012" TEXT="mms">
<node CREATED="1362477947062" ID="ID_158548253" LINK="http://changyy.pixnet.net/blog/post/31675147-android-%E9%96%8B%E7%99%BC%E7%AD%86%E8%A8%98---%E7%B6%B2%E8%B7%AF%E5%BB%A3%E6%92%AD%E7%A8%8B%E5%BC%8F%E5%8F%8A%E5%AF%A6%E4%BD%9C%E5%8E%9F%E7%90%86-(" MODIFIED="1362477968265" TEXT="&#x7db2;&#x8def;&#x5ee3;&#x64ad;&#x7a0b;&#x5f0f;&#x53ca;&#x5be6;&#x4f5c;&#x539f;&#x7406; (&#x4f7f;&#x7528;FFmpeg&#x64ad;&#x653e;mms)">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1354187246125" FOLDED="true" ID="ID_949657674" LINK="http://simonxanderandroid.blogspot.tw/2011/01/android-ffmpeg-eclipse-ndk-on-windows.html" MODIFIED="1428649718013" TEXT="&#x6574;&#x5408; Android &#x548c; FFmpeg (&#x4f7f;&#x7528; Eclipse + NDK) on Windows">
<node CREATED="1356615767541" ID="ID_786373244" MODIFIED="1361158856531" TEXT="&#x6ce8;&#x610f;&#x7684;&#x662f; loadLibarary &#x7684;&#x9806;&#x5e8f;">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1354265367859" FOLDED="true" ID="ID_1912239494" LINK="http://stackoverflow.com/questions/5164211/use-ffmpeg-on-android" MODIFIED="1428649718013" TEXT="use-ffmpeg-on-android">
<node CREATED="1356615916433" ID="ID_704727533" MODIFIED="1356615918665" TEXT="to convert YUV420 frame to H.264?"/>
</node>
<node CREATED="1357719617606" ID="ID_523203128" LINK="http://kongweile.iteye.com/blog/1144881" MODIFIED="1357719634465" TEXT="&#x5728;NDK&#x4e2d;&#x5982;&#x4f55;&#x4f7f;&#x7528;libffmpeg.so"/>
</node>
<node CREATED="1354265598812" FOLDED="true" ID="ID_1801798613" MODIFIED="1428649718013" TEXT="0.11.1">
<node CREATED="1354265584484" ID="ID_1723103218" LINK="http://dmitrydzz-hobby.blogspot.tw/2012/04/how-to-build-ffmpeg-and-use-it-in.html" MODIFIED="1372300882358" TEXT="Google the open-source Dolphin player,"/>
<node CREATED="1372300886052" ID="ID_406717632" MODIFIED="1372300904198" TEXT="download the code it has ffmpeg distribution"/>
<node CREATED="1372300905635" ID="ID_418202567" MODIFIED="1372300910084" TEXT="and a script to build ffmpeg so under android. 0.11.1 builds fine"/>
<node CREATED="1354513531265" ID="ID_301137465" LINK="http://superonion.iteye.com/blog/1609777?page=2" MODIFIED="1354513550562" TEXT="&#x589e;&#x52a0;&#x4e86;&#x5bf9;HLS&#x534f;&#x8bae;&#x7684;&#x652f;&#x6301;&#x3002;"/>
</node>
<node CREATED="1357025895782" FOLDED="true" ID="ID_1327044253" MODIFIED="1428649718016" TEXT="performance">
<node CREATED="1358147071546" FOLDED="true" ID="ID_1804882922" MODIFIED="1428649718014" TEXT="optimization">
<node CREATED="1357025965747" FOLDED="true" ID="ID_1252698170" MODIFIED="1428649718014" TEXT="neon">
<node CREATED="1357044459636" FOLDED="true" ID="ID_1458304850" MODIFIED="1428649718014" TEXT="how to configure NEON support">
<icon BUILTIN="help"/>
<node CREATED="1358146095765" ID="ID_1730264261" MODIFIED="1358146111234" TEXT="real device">
<icon BUILTIN="help"/>
</node>
<node CREATED="1358146101078" ID="ID_690764536" MODIFIED="1358146108343" TEXT="emulator">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1359206733685" ID="ID_926164459" MODIFIED="1362621915531" TEXT="packet"/>
</node>
<node CREATED="1358147008437" FOLDED="true" ID="ID_851601973" MODIFIED="1428649718015" TEXT="decoding an h.264 video file on android using ffmpeg">
<node CREATED="1357026087483" FOLDED="true" ID="ID_462573216" LINK="http://stackoverflow.com/questions/8180884/ffmpeg-with-neon-optimization" MODIFIED="1428649718015" TEXT="I have compiled ffmpeg-0.10 for android using its script situated here">
<node CREATED="1358146060281" ID="ID_1767204113" MODIFIED="1358147116125" TEXT="config.log">
<icon BUILTIN="info"/>
</node>
<node CREATED="1357025954105" ID="ID_605713437" LINK="http://stackoverflow.com/questions/8180884/ffmpeg-with-neon-optimization" MODIFIED="1357025963353" TEXT="configuration"/>
</node>
</node>
<node CREATED="1362817299311" FOLDED="true" ID="ID_1007979709" MODIFIED="1428649718016" TEXT="hardware">
<node CREATED="1357109281553" FOLDED="true" ID="ID_1632632555" LINK="http://stackoverflow.com/questions/13730356/hw-rendering-to-android-surface-using-openmax-il" MODIFIED="1428649718015" TEXT="HW rendering to Android Surface using OpenMAX IL">
<node CREATED="1357109477475" ID="ID_808662102" MODIFIED="1357109480225" TEXT="Passed the Android Surface object through the JNI"/>
<node CREATED="1357109512818" ID="ID_1314882649" MODIFIED="1357109514443" TEXT="Use createRendererFromJavaSurface defined in IOMX.h"/>
</node>
<node CREATED="1362816888542" ID="ID_1985147000" LINK="http://freepine.blogspot.tw/2010/01/overview-of-stagefrighter-player.html" MODIFIED="1362816911972" TEXT=" ffmpeg h264 decoder is too slow to decode HD video with 1280x720 ">
<icon BUILTIN="info"/>
</node>
<node CREATED="1362816947697" ID="ID_714715445" MODIFIED="1362816949525" TEXT=" I am now thinking of using hardware decoder shipped within an android device."/>
<node CREATED="1362816964040" ID="ID_555769393" MODIFIED="1362816965603" TEXT=" The only way to access this codec is through openmax IL"/>
<node CREATED="1362816986152" ID="ID_434905904" LINK="http://freepine.blogspot.tw/2010/01/overview-of-stagefrighter-player.html" MODIFIED="1362817008881" TEXT="But android-ndk doesn&apos;t provide OMXIL (Integration Layer), just OMXAL (Application Layer). ">
<icon BUILTIN="info"/>
</node>
<node CREATED="1362817603471" FOLDED="true" ID="ID_61196352" LINK="https://groups.google.com/forum/#!msg/android-platform/50yrEHTQGno/97TVAItmKx4J" MODIFIED="1428649718016" TEXT=" starting with Android 4.1 (API level 16 / Jellybean)">
<icon BUILTIN="info"/>
<node CREATED="1362817649892" ID="ID_768323885" LINK="#ID_1570298338" MODIFIED="1362817845405" TEXT="MediaCodec"/>
</node>
</node>
<node CREATED="1362817024323" ID="ID_1454689253" MODIFIED="1362817025248" TEXT="In OMXAL I could only get the player interface"/>
</node>
<node CREATED="1360118201937" FOLDED="true" ID="ID_1594360012" MODIFIED="1428649718026" TEXT="general idea">
<node CREATED="1354247837906" FOLDED="true" ID="ID_232310998" MODIFIED="1428649718017" TEXT="prebuilt">
<node CREATED="1354261996968" ID="ID_1918057993" MODIFIED="1354261998609" TEXT="How to use a pre-built library in android application"/>
</node>
<node CREATED="1354248194546" FOLDED="true" ID="ID_404803418" MODIFIED="1428649718024" TEXT="porting">
<node CREATED="1354522173359" ID="ID_577800840" LINK="https://github.com/lhzhang/FFMpeg" MODIFIED="1354522186562" TEXT="lhzhang / FFMpeg"/>
<node CREATED="1354585996046" FOLDED="true" ID="ID_27878965" LINK="http://gitorious.org/~olvaffe/ffmpeg/ffmpeg-android" MODIFIED="1428649718017" TEXT="ffmpeg   ffmpeg-android">
<node CREATED="1354586010437" ID="ID_1972557641" MODIFIED="1354586012437" TEXT="This is for use with Android source tree, not NDK."/>
</node>
<node CREATED="1354608489593" ID="ID_1500946895" LINK="https://github.com/churnlabs/android-ffmpeg-sample" MODIFIED="1354608568343" TEXT="churnlabs / android-ffmpeg-sample"/>
<node CREATED="1354771910203" FOLDED="true" ID="ID_469404329" MODIFIED="1428649718017" TEXT="Decode h264 rtsp with ffmpeg and separated AVCodecContext">
<node CREATED="1354771891562" ID="ID_1237664785" LINK="http://stackoverflow.com/questions/11261551/decode-h264-rtsp-with-ffmpeg-and-separated-avcodeccontext" MODIFIED="1354771927375" TEXT="neccessary to create AVCodecContext separately"/>
</node>
<node CREATED="1357264562703" FOLDED="true" ID="ID_1293245537" LINK="https://github.com/guardianproject/android-ffmpeg" MODIFIED="1428649718018" TEXT="theguardianproject ">
<node CREATED="1357264546593" ID="ID_976647160" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1357267043921" TEXT="The most easy to build, easy to use implementation I have found">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1354161003359" FOLDED="true" ID="ID_1269277789" LINK="http://superonion.iteye.com/blog/1609777" MODIFIED="1428649718021" TEXT="FFmpeg &#x79fb;&#x690d; Android">
<node CREATED="1354094323125" FOLDED="true" ID="ID_681265460" MODIFIED="1428649718020" TEXT="configuration">
<node CREATED="1354094333656" FOLDED="true" ID="ID_1573184244" MODIFIED="1428649718018" TEXT="target">
<node CREATED="1354095980703" FOLDED="true" ID="ID_23666175" MODIFIED="1428649718018" TEXT="hardware">
<node CREATED="1354094358312" ID="ID_564796577" MODIFIED="1354094360062" TEXT="x86"/>
<node CREATED="1354094355500" ID="ID_27968909" MODIFIED="1354094357812" TEXT="arm"/>
</node>
<node CREATED="1354095905593" FOLDED="true" ID="ID_219008186" MODIFIED="1428649718018" TEXT="android">
<node CREATED="1354096078156" ID="ID_1391395761" MODIFIED="1354096080062" TEXT="version"/>
<node CREATED="1354096080437" ID="ID_1254542578" MODIFIED="1354096082765" TEXT="level"/>
</node>
</node>
<node CREATED="1354094350078" FOLDED="true" ID="ID_1816094275" MODIFIED="1428649718019" TEXT="host">
<node CREATED="1354094362312" FOLDED="true" ID="ID_1475194482" MODIFIED="1428649718019" TEXT="ubuntu">
<node CREATED="1354161050796" ID="ID_882923023" MODIFIED="1354161054406" TEXT="12.04"/>
</node>
</node>
<node CREATED="1354094405625" FOLDED="true" ID="ID_1073733322" MODIFIED="1428649718020" TEXT="ndk">
<node CREATED="1354095289453" FOLDED="true" ID="ID_132755924" MODIFIED="1428649718019" TEXT="version">
<node CREATED="1354161056968" ID="ID_1206806929" MODIFIED="1354161059156" TEXT="r8"/>
</node>
<node CREATED="1354155117171" ID="ID_134064916" MODIFIED="1354155124062" TEXT="toolchain"/>
</node>
<node CREATED="1354095282453" FOLDED="true" ID="ID_28852123" MODIFIED="1428649718020" TEXT="ffmpeg">
<node CREATED="1354095294078" FOLDED="true" ID="ID_1576553034" MODIFIED="1428649718020" TEXT="version">
<node CREATED="1354513460640" ID="ID_233933280" MODIFIED="1354513465375" TEXT="0.11.1"/>
</node>
</node>
</node>
</node>
<node CREATED="1354187325625" FOLDED="true" ID="ID_483134661" LINK="http://blog.sina.com.cn/s/blog_69a04cf40100x1fr.html" MODIFIED="1428649718021" TEXT="FFmpeg&#x5728;Android&#x4e0a;&#x7684;&#x79fb;&#x690d;&#x4e4b;&#x7b2c;&#x4e00;&#x6b65;">
<node CREATED="1356615409922" ID="ID_1636476563" MODIFIED="1356615412171" TEXT="&#x5df2;&#x7ecf;&#x6709;&#x5f88;&#x591a;&#x524d;&#x8f88;&#x505a;&#x8fc7;&#x8fd9;&#x65b9;&#x9762;&#x7684;&#x5de5;&#x4f5c;&#x5e76;&#x516c;&#x5f00;&#x4e86;&#x4ed6;&#x4eec;&#x7684;&#x6210;&#x679c;&#xff0c;&#x5927;&#x6982;&#x5217;&#x4e00;&#x4e0b;"/>
</node>
<node CREATED="1354522372187" FOLDED="true" ID="ID_1052918439" LINK="http://www.cnblogs.com/tairikun/archive/2012/09/10.html" MODIFIED="1428649718021" TEXT="&#x5173;&#x4e8e;&#x5982;&#x4f55;&#x7f16;&#x5199;&#x5728; Android &#x4e0a;&#x8fd0;&#x884c;&#x7684; FFmpeg &#x64ad;&#x653e;&#x5668;">
<node CREATED="1357028894989" ID="ID_358527017" MODIFIED="1357028924849" TEXT="&#x624b;&#x52d5;&#x4fee;&#x6539;too much"/>
<node CREATED="1357028925590" ID="ID_203055435" MODIFIED="1357028935866" TEXT="version is too old"/>
</node>
<node CREATED="1354518708218" FOLDED="true" ID="ID_880869368" LINK="https://github.com/halfninja/android-ffmpeg-x264/blob/master/README.textile" MODIFIED="1428649718022" TEXT="android-ffmpeg-x264">
<node CREATED="1357266549843" FOLDED="true" ID="ID_1591165775" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1428649718022" TEXT="The benefit over olvaffe&apos;s build system">
<node CREATED="1357266567515" ID="ID_1429793282" MODIFIED="1357266568750" TEXT="is that it doesn&apos;t require Android.mk files to build the libraries"/>
<node CREATED="1357266610187" ID="ID_839313217" MODIFIED="1357266611687" TEXT="makes it much less likely to stop working when you pull new change from FFMPEG or X264"/>
</node>
</node>
<node CREATED="1358427131719" ID="ID_1320967573" LINK="http://dl.dropbox.com/u/22605641/ffmpeg_android/main.html" MODIFIED="1358427147806" TEXT="configure x264 for android"/>
<node CREATED="1356615092397" FOLDED="true" ID="ID_930012104" MODIFIED="1428649718023" TEXT="havlenaptr&#x79fb;&#x690d;&#x7684;ffmpeg">
<node CREATED="1354161138734" FOLDED="true" ID="ID_1930895955" LINK="http://blog.csdn.net/moruite/article/details/6305944" MODIFIED="1428649718022" TEXT="&#x89e3;&#x51b3;Android&#x5e73;&#x53f0;&#x79fb;&#x690d;ffmpeg&#x7684;&#x4e00;&#x63fd;&#x5b50;&#x95ee;&#x9898;">
<node CREATED="1356615021309" ID="ID_428110778" MODIFIED="1356615024810" TEXT="Android&#x7684;&#x89c6;&#x9891;&#x5904;&#x7406;&#x4ee5;&#x540e;&#x4e5f;&#x4f1a;&#x8d70;&#x4ee5;&#x786c;&#x89e3;&#x4e3a;&#x4e3b;&#xff0c;&#x8f6f;&#x89e3;&#x4e3a;&#x8f85;&#x7684;&#x8def;&#x7ebf;&#x3002;"/>
<node CREATED="1357196373812" ID="ID_1832657929" MODIFIED="1357196384359" TEXT="#define CONFIG_RTSP_DEMUXER 0 ">
<icon BUILTIN="closed"/>
</node>
<node CREATED="1357208241453" ID="ID_1558561800" MODIFIED="1357208247718" TEXT="config.log"/>
</node>
<node CREATED="1357549025265" FOLDED="true" ID="ID_1017020191" MODIFIED="1428649718023" TEXT="Android&#x591a;&#x5a92;&#x4f53;&#x5f00;&#x53d1;&#xff08;3&#xff09;&#x2014;&#x2014;&#x2014;&#x2014;&#x4f7f;&#x7528;Android NKD&#x7f16;&#x8bd1;havlenapetr-FFMpeg-7c27aa2">
<node CREATED="1357549044093" FOLDED="true" ID="ID_465128115" LINK="https://github.com/havlenapetr/FFMpeg" MODIFIED="1428649718023" TEXT="&#x79fb;&#x690d;havlenapetr/FFMpeg">
<node CREATED="1357549108578" ID="ID_1380558977" MODIFIED="1357549110734" TEXT="Project is not active, recent change is 2 years ago."/>
<node CREATED="1357549140515" ID="ID_692359463" MODIFIED="1357549142140" TEXT="&#x8fd9;&#x4e2a;&#x7248;&#x672c;&#x7684;havlenapetr FFmpeg&#x5de5;&#x7a0b;&#x53ea;&#x80fd;&#x5728;Android 2.2&#x4e0a;&#x9762;&#x8fd0;&#x884c;"/>
<node CREATED="1357549188578" ID="ID_906968285" LINK="http://blog.csdn.net/conowen/article/details/7526398" MODIFIED="1357549201468" TEXT="havlenapetr&#x91c7;&#x7528;&#x7684;&#x662f;&#x97f3;&#x89c6;&#x9891;&#x76f4;&#x63a5;&#x5728;JNI&#x5c42;&#x8f93;&#x5165;"/>
<node CREATED="1357551170406" FOLDED="true" ID="ID_1558542648" MODIFIED="1428649718022" TEXT="&#x6216;&#x8005;&#x4f60;&#x66f4;&#x6539;&#x89c6;&#x9891;&#x7684;&#x8f93;&#x51fa;&#x65b9;&#x5f0f;&#xff0c;&#x91c7;&#x7528;STL&#x89c6;&#x9891;&#x8f93;&#x51fa;">
<node CREATED="1357551179875" ID="ID_641785533" MODIFIED="1357551183453" TEXT="STL&#x89c6;&#x9891;&#x8f93;&#x51fa;">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1357551275281" ID="ID_175993101" MODIFIED="1357551276843" TEXT="&#x6709;&#x5728;&#x771f;&#x673a;&#x4e0a;&#x6d4b;&#x8bd5;&#x8fc7;&#x5417;&#xff1f;&#x6548;&#x7387;&#x600e;&#x4e48;&#x6837;&#xff1f;&#x80fd;&#x8fbe;&#x5230;&#x600e;&#x6837;&#x7684;&#x5e27;&#x7387;&#x554a;&#xff1f;"/>
<node CREATED="1357551259234" ID="ID_1754980539" MODIFIED="1357551261046" TEXT="&#x5728;&#x771f;&#x673a;&#x4e0a;&#x9762;&#x8dd1;&#x7684;&#xff0c;cortex A8 1.0GHZ&#xff0c;480P&#x57fa;&#x672c;&#x6d41;&#x7545;"/>
</node>
<node CREATED="1357624377187" ID="ID_882601553" LINK="http://blog.csdn.net/scut1135/article/details/6537258" MODIFIED="1357624406937" TEXT="&#x5176;&#x5bf9;&#x97f3;&#x89c6;&#x9891;&#x540c;&#x6b65;&#x5904;&#x7406;&#x5e76;&#x4e0d;&#x6210;&#x529f;"/>
<node CREATED="1357628190609" ID="ID_960404446" LINK="http://blog.csdn.net/scut1135/article/details/6537258" MODIFIED="1357628202312" TEXT="&#x5f88;&#x591a;&#x6280;&#x672f;&#x662f;&#x4ece;&#x8fd9;&#x91cc;&#x5f97;&#x5230;&#x7684;"/>
<node CREATED="1358426357707" ID="ID_764206935" MODIFIED="1358426364405" TEXT="not verified yet"/>
</node>
</node>
<node CREATED="1354097568390" FOLDED="true" ID="ID_1735240044" MODIFIED="1428649718026" TEXT="blogs">
<node CREATED="1353208339312" FOLDED="true" ID="ID_1035328308" LINK="http://www.roman10.net/how-to-build-ffmpeg-for-android/" MODIFIED="1428649718025" TEXT="how to build ffmpeg for android">
<node CREATED="1354181295406" FOLDED="true" ID="ID_221461327" MODIFIED="1428649718025" TEXT="referenced by">
<node CREATED="1354007735187" FOLDED="true" ID="ID_1511901202" LINK="http://www.wretch.cc/blog/JohnDX/15760183" MODIFIED="1428649718024" TEXT="[Android] NDK Build FFmpeg (arm)">
<node CREATED="1354017200734" ID="ID_1204651974" LINK="http://vec.io/tags/ffmpeg" MODIFIED="1354017227421" TEXT="How to build FFmpeg with Android NDK2012-9-3"/>
<node CREATED="1354017283390" ID="ID_739534557" LINK="http://simonxanderandroid.blogspot.tw/2011/01/android-ffmpeg-eclipse-ndk-on-windows.html" MODIFIED="1354017288234" TEXT=""/>
<node CREATED="1354246921937" ID="ID_123932482" LINK="http://kongweile.iteye.com/blog/1457111" MODIFIED="1354246940984" TEXT="android-ndk-r7 &#x7f16;&#x8bd1; ffmpeg-0.10"/>
</node>
</node>
</node>
<node CREATED="1353998933328" FOLDED="true" ID="ID_1772166734" LINK="http://iamkcspa.pixnet.net/blog/post/36123700" MODIFIED="1428649718025" TEXT="&#x5c07;FFmpeg&#x6574;&#x5408;&#x81f3;Android&#x5e73;&#x53f0;">
<node CREATED="1354247612062" ID="ID_945531155" MODIFIED="1354247639796" TEXT="too many hand-made midification">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1361058038337" ID="ID_508531740" LINK="http://changyy.pixnet.net/blog/post/31667085?utm_source=feedburner&amp;utm_medium=feed&amp;utm_campaign=Feed%3A+changyy+(%E7%AC%AC%E4%BA%8C%E5%8D%81%E5%9B%9B%E5%80%8B%E5%A4%8F%E5%A4%A9%E5%BE%8C%3A%3A+%E7%97%9E%E5%AE%A2%E9%82%A6+PIXNET+%3A%3A)" MODIFIED="1361058058004" TEXT="Android &#x958b;&#x767c;&#x7b46;&#x8a18; - &#x4f7f;&#x7528;&#x7b2c;&#x4e09;&#x65b9;&#x51fd;&#x5f0f;&#x5eab;&#x6d41;&#x7a0b; (&#x4ee5;FFmpeg&#x70ba;&#x4f8b;)"/>
</node>
</node>
<node CREATED="1367300883406" FOLDED="true" ID="ID_1361827718" MODIFIED="1428649718027" TEXT="&#x900f;&#x904e;jni&#x53d6;&#x5f97;ffmpeg&#x5373;&#x6642;&#x6578;&#x64da; ">
<node CREATED="1367300969546" FOLDED="true" ID="ID_544863159" LINK="http://stackoverflow.com/questions/9014475/ffmpeg-c-c-get-frame-count-or-timestamp-and-fps" MODIFIED="1428649718026" TEXT="ffmpeg c/c++ get frame count or timestamp and fps">
<node CREATED="1367301029859" ID="ID_1771641424" LINK="http://dranger.com/ffmpeg/tutorial05.html" MODIFIED="1367301043046" TEXT="Synching Video"/>
</node>
<node CREATED="1367301050984" ID="ID_1726980497" MODIFIED="1367301064671" TEXT="&#x5f9e;&#x53d6;&#x5f97;&#x7248;&#x672c;&#x5148;&#x505a;&#x8d77;"/>
<node CREATED="1361785419703" ID="ID_19287684" MODIFIED="1361785427687" TEXT="get ffmpeg version"/>
</node>
<node CREATED="1372734686190" FOLDED="true" ID="ID_243307145" LINK="https://code.google.com/p/ffmpegsource/issues/detail?id=11" MODIFIED="1428649718027" TEXT="&apos;UINT64_C&apos; was not declared in this scope">
<node CREATED="1372734722320" ID="ID_73596054" MODIFIED="1372734753406" TEXT="LOCAL_CPPFLAGS"/>
</node>
<node CREATED="1354097538281" FOLDED="true" ID="ID_1299574141" MODIFIED="1431247754737" TEXT="version">
<node CREATED="1353208429863" ID="ID_56720960" LINK="http://stackoverflow.com/questions/10897066/android-ndk-ffmpeg-build" MODIFIED="1353208442492" TEXT="Android NDK &amp; FFMPEG build"/>
<node CREATED="1354095090375" FOLDED="true" ID="ID_618412867" LINK="http://dmitrydzz-hobby.blogspot.tw/2012/04/how-to-build-ffmpeg-and-use-it-in.html" MODIFIED="1428649718031" TEXT="How to build ffmpeg and use it in Android applications">
<icon BUILTIN="full-1"/>
<node CREATED="1354095193140" ID="ID_227484041" MODIFIED="1354095204281" TEXT="2012/04/15"/>
<node CREATED="1354096271437" ID="ID_1312644108" MODIFIED="1357112063318" TEXT="As far as I know it is impossible to build this library on Windows.">
<icon BUILTIN="button_cancel"/>
</node>
<node CREATED="1354094323125" FOLDED="true" ID="ID_406166109" MODIFIED="1428649718030" TEXT="compiling">
<node CREATED="1354094333656" FOLDED="true" ID="ID_1629450888" MODIFIED="1428649718028" TEXT="target">
<node CREATED="1354095980703" FOLDED="true" ID="ID_204242240" MODIFIED="1428649718027" TEXT="hardware">
<node CREATED="1354094355500" ID="ID_1446387475" MODIFIED="1354094357812" TEXT="arm"/>
</node>
<node CREATED="1354095905593" FOLDED="true" ID="ID_230534827" MODIFIED="1428649718028" TEXT="android">
<node CREATED="1354096078156" FOLDED="true" ID="ID_96358002" MODIFIED="1428649718027" TEXT="version">
<node CREATED="1354096136921" ID="ID_735851583" MODIFIED="1354096140140" TEXT="2.3.3"/>
</node>
<node CREATED="1354096080437" FOLDED="true" ID="ID_542639227" MODIFIED="1428649718027" TEXT="level">
<node CREATED="1354096141687" ID="ID_1103265838" MODIFIED="1354096143609" TEXT="10"/>
</node>
</node>
</node>
<node CREATED="1354094350078" FOLDED="true" ID="ID_1001942999" MODIFIED="1428649718028" TEXT="host">
<node CREATED="1354094362312" FOLDED="true" ID="ID_411929961" MODIFIED="1428649718028" TEXT="ubuntu">
<node CREATED="1354097415359" ID="ID_1011928540" MODIFIED="1354097441875" TEXT="good configure script">
<icon BUILTIN="idea"/>
</node>
</node>
<node CREATED="1354247394562" ID="ID_87404431" MODIFIED="1354247399875" TEXT="cygwin">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node CREATED="1354094405625" FOLDED="true" ID="ID_1797427354" MODIFIED="1428649718029" TEXT="ndk">
<node CREATED="1354095174015" FOLDED="true" ID="ID_1454481598" MODIFIED="1428649718029" TEXT="version">
<node CREATED="1354095178296" ID="ID_1710958768" MODIFIED="1354095180734" TEXT="r7c"/>
<node CREATED="1354247385937" ID="ID_621620840" MODIFIED="1354247391703" TEXT="r8c">
<icon BUILTIN="button_ok"/>
</node>
</node>
</node>
<node CREATED="1354095210984" FOLDED="true" ID="ID_1542003420" MODIFIED="1428649718030" TEXT="ffmpeg">
<node CREATED="1354095216046" FOLDED="true" ID="ID_1302315199" MODIFIED="1428649718029" TEXT="version">
<node CREATED="1354095220609" ID="ID_1095738162" MODIFIED="1354095226625" TEXT="love"/>
<node CREATED="1354095249578" ID="ID_1511059576" LINK="http://git.videolan.org/?p=ffmpeg.git;a=shortlog;h=n0.8.12" MODIFIED="1354247374796" TEXT="0.8.11 &quot;Love&quot;">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1354095262703" ID="ID_1223414678" LINK="http://dmitrydzz-hobby.blogspot.tw/2012/04/how-to-build-ffmpeg-and-use-it-in.html" MODIFIED="1369132079937" TEXT="Unfortunatlly I couldn&apos;t compile newer versions."/>
<node CREATED="1356612500307" FOLDED="true" ID="ID_1909607749" MODIFIED="1428649718029" TEXT=" FFmpeg - version 0.10.2 &quot;Freedom&quot;">
<node CREATED="1356612485344" ID="ID_762478286" LINK="http://stackoverflow.com/questions/10438978/linker-errors-when-trying-to-enable-ffmpeg-stagefright-support" MODIFIED="1356612521008" TEXT=" I have successfully built all the libraries"/>
</node>
</node>
</node>
<node CREATED="1354256275062" FOLDED="true" ID="ID_1957693813" MODIFIED="1428649718030" TEXT="output">
<icon BUILTIN="button_ok"/>
<node CREATED="1354256281734" ID="ID_989531677" MODIFIED="1354256294984" TEXT="&lt;workspace&gt;/obj"/>
</node>
</node>
<node CREATED="1354264445546" FOLDED="true" ID="ID_374962706" MODIFIED="1428649718031" TEXT="libmylib.so">
<icon BUILTIN="idea"/>
<node CREATED="1354264529250" FOLDED="true" ID="ID_1919848506" MODIFIED="1428649718031" TEXT="pro">
<node CREATED="1354264513515" ID="ID_1443206238" MODIFIED="1369132098015" TEXT="user will not know what is placed inside"/>
</node>
</node>
<node CREATED="1356615992595" ID="ID_1704994369" MODIFIED="1356615996134" TEXT="build4android.sh"/>
<node CREATED="1357796464984" ID="ID_1878988024" MODIFIED="1357796481343" TEXT="statically linked">
<icon BUILTIN="info"/>
</node>
<node CREATED="1373327067101" ID="ID_937715901" MODIFIED="1373327093805" TEXT="one Android.mk for each module">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1354519187296" FOLDED="true" ID="ID_1530847372" LINK="http://bambuser.com/opensource" MODIFIED="1428649718038" TEXT="bambuser">
<icon BUILTIN="full-2"/>
<icon BUILTIN="button_ok"/>
<node CREATED="1357025051523" ID="ID_1972251781" LINK="http://stackoverflow.com/questions/5337833/ffmpeg-on-android-undefined-references-to-libavcodec-functions-although-it-is" MODIFIED="1357025092250" TEXT=" I take the lib*.a files and the include dir from the bambuser.com build"/>
<node CREATED="1357025069141" ID="ID_1660947652" MODIFIED="1357025070844" TEXT=" just directly include them in my jni directory"/>
<node CREATED="1357025132666" ID="ID_965158530" LINK="http://stackoverflow.com/questions/5337833/ffmpeg-on-android-undefined-references-to-libavcodec-functions-although-it-is" MODIFIED="1357025149841" TEXT="The following Android.mk works for me"/>
<node CREATED="1354513517015" FOLDED="true" ID="ID_240533104" MODIFIED="1428649718032" TEXT="follow-up">
<node CREATED="1354613581843" FOLDED="true" ID="ID_1053617777" LINK="http://www.ciufek.net/" MODIFIED="1428649718031" TEXT="Low latency streaming with ffmpeg">
<icon BUILTIN="info"/>
<node CREATED="1356615645713" ID="ID_882273595" MODIFIED="1357028579564" TEXT="alpha stage">
<icon BUILTIN="info"/>
</node>
<node CREATED="1356612202962" ID="ID_1958669667" LINK="http://sourceforge.net/projects/ffmpegavlib/" MODIFIED="1356612264702" TEXT="source"/>
<node CREATED="1356612191420" ID="ID_1793132644" MODIFIED="1356612195296" TEXT="FFMpegAVLib low latency Android playback"/>
</node>
</node>
<node CREATED="1357032028913" FOLDED="true" ID="ID_189397792" MODIFIED="1428649718033" TEXT="troubleshooting">
<node CREATED="1357032037395" FOLDED="true" ID="ID_73243565" MODIFIED="1428649718033" TEXT="arm-linux-androideabi-gcc is unable to create an executable">
<node CREATED="1357032824351" FOLDED="true" ID="ID_1583596269" MODIFIED="1428649718032" TEXT="">
<node CREATED="1357032080490" ID="ID_1256487527" LINK="http://stackoverflow.com/questions/12660043/arm-linux-androideabi-gcc-is-unable-to-create-an-executable-compile-ffmpeg-fo" MODIFIED="1357032095922" TEXT="In order to use the script do the following"/>
<node CREATED="1357032819105" ID="ID_311332420" MODIFIED="1357032820737" TEXT=" the script builds binaries for armeabi, armeabi-v7a and x86 architectures"/>
</node>
<node CREATED="1357043583590" FOLDED="true" ID="ID_747873644" LINK="http://stackoverflow.com/questions/9956836/android-toolchain-oddity" MODIFIED="1428649718032" TEXT="sudo apt-get install libc6-i386 lib32z1">
<node CREATED="1357043667789" ID="ID_324010366" MODIFIED="1369132079937" TEXT="happens on x64"/>
</node>
<node CREATED="1357043435709" FOLDED="true" ID="ID_981707454" LINK="http://forum.xbmc.org/showthread.php?pid=1157159" MODIFIED="1428649718032" TEXT="sudo apt-get install ia32-libs">
<icon BUILTIN="help"/>
<node CREATED="1357043788411" ID="ID_1422997473" MODIFIED="1357043802089" TEXT="too large"/>
<node CREATED="1357043802591" ID="ID_1708456130" MODIFIED="1357043806627" TEXT="take long time"/>
</node>
<node CREATED="1357032830854" FOLDED="true" ID="ID_295811016" MODIFIED="1428649718033" TEXT="That error usually occurs when you are using a different NDK version">
<icon BUILTIN="button_cancel"/>
<node CREATED="1357033205274" ID="ID_307834941" MODIFIED="1357033210043" TEXT="n8b"/>
</node>
</node>
</node>
<node CREATED="1357032133536" FOLDED="true" ID="ID_1349934275" MODIFIED="1428649718034" TEXT="build">
<node CREATED="1357032722288" FOLDED="true" ID="ID_480401498" MODIFIED="1428649718033" TEXT="README.txt">
<node CREATED="1357033170906" ID="ID_937186923" MODIFIED="1357033181037" TEXT="android-ndk-r5b"/>
<node CREATED="1357099034062" ID="ID_289387684" MODIFIED="1369132079937" TEXT="extract"/>
<node CREATED="1357099042937" ID="ID_1021336403" MODIFIED="1357099045781" TEXT="build"/>
</node>
<node CREATED="1357099216687" FOLDED="true" ID="ID_1952547745" MODIFIED="1428649718034" TEXT="steps">
<node CREATED="1357032126391" ID="ID_1299716582" LINK="http://www.quora.com/What-are-the-steps-for-integrating-FFMPEG-on-Android" MODIFIED="1357032158501" TEXT="What are the steps for integrating FFMPEG on Android"/>
<node CREATED="1357044206079" FOLDED="true" ID="ID_1314847436" MODIFIED="1428649718034" TEXT="compile ffmpeg for android armeabi devices">
<node CREATED="1357044212134" ID="ID_289295277" LINK="http://stackoverflow.com/questions/12660043/arm-linux-androideabi-gcc-is-unable-to-create-an-executable-compile-ffmpeg-foa" MODIFIED="1357044236508" TEXT="steps"/>
</node>
</node>
<node CREATED="1357099110718" FOLDED="true" ID="ID_1721428266" MODIFIED="1428649718034" TEXT="verified NDK">
<node CREATED="1357043978316" ID="ID_1480171039" MODIFIED="1357043984019" TEXT="r8b">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1357033214724" ID="ID_564861477" MODIFIED="1357044125947" TEXT="r8d">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1357099130687" ID="ID_633190313" MODIFIED="1357099142312" TEXT="linux-r8c">
<icon BUILTIN="button_ok"/>
</node>
</node>
</node>
<node CREATED="1357099185062" FOLDED="true" ID="ID_283389784" MODIFIED="1428649718038" TEXT="how to use">
<node CREATED="1357105697615" ID="ID_1796929398" MODIFIED="1357105707381" TEXT="5 .so file"/>
<node CREATED="1357112726803" FOLDED="true" ID="ID_1759005828" LINK="http://stackoverflow.com/questions/5164211/use-ffmpeg-on-android" MODIFIED="1428649718035" TEXT="two options">
<icon BUILTIN="info"/>
<node CREATED="1357112686053" FOLDED="true" ID="ID_1282443533" MODIFIED="1428649718035" TEXT="use ffmpeg api">
<node CREATED="1357198250296" FOLDED="true" ID="ID_1079752104" MODIFIED="1428649718035" TEXT="examples">
<node CREATED="1357198274687" ID="ID_1067407404" LINK="https://github.com/xorange/Android-Video-Player-FFmpeg-and-Bitmap/blob/master/jni/dranger/tutorial01.c" MODIFIED="1357198292484" TEXT="Android-Video-Player-FFmpeg-and-Bitmap"/>
</node>
</node>
<node CREATED="1357112701022" ID="ID_1248724432" LINK="http://stackoverflow.com/questions/5164211/use-ffmpeg-on-android" MODIFIED="1357112720553" TEXT="compile ffmpeg.c and invoke its main() via jni."/>
</node>
<node CREATED="1353998858437" FOLDED="true" ID="ID_666110778" LINK="http://www.roman10.net/how-to-build-android-applications-based-on-ffmpeg-by-an-example/" MODIFIED="1428649718038" TEXT="How to Build Android Applications Based on FFmpeg by An Example">
<node CREATED="1357202396546" ID="ID_956331940" MODIFIED="1357202404046" TEXT="configuration"/>
<node CREATED="1353986776843" FOLDED="true" ID="ID_1170124213" MODIFIED="1428649718037" TEXT="require">
<node CREATED="1353986823609" FOLDED="true" ID="ID_793221416" MODIFIED="1428649718036" TEXT="cygwin">
<node CREATED="1354015530406" FOLDED="true" ID="ID_221948288" MODIFIED="1428649718036" TEXT="troubleshooting">
<node CREATED="1354006543515" ID="ID_1913315898" MODIFIED="1354006549171" TEXT="no sudo"/>
<node CREATED="1353986829546" ID="ID_159403808" LINK="http://superuser.com/questions/154418/where-do-i-get-make-for-cygwin" MODIFIED="1353987320890" TEXT="gnu make"/>
<node CREATED="1354006526640" ID="ID_440267142" LINK="http://www2.warwick.ac.uk/fac/sci/moac/people/students/peter_cock/cygwin/part2/" MODIFIED="1354007360437" TEXT="install gcc"/>
<node CREATED="1354006551171" ID="ID_1362668558" MODIFIED="1354006564484" TEXT="note the EOL conversion"/>
<node CREATED="1354015543812" FOLDED="true" ID="ID_1744565824" LINK="http://stackoverflow.com/questions/5204251/compile-ffmpeg-with-android-ndk-r5b" MODIFIED="1428649718035" TEXT="/tmp directory not working">
<node CREATED="1357025565876" ID="ID_137136442" LINK="http://stackoverflow.com/questions/5204251/compile-ffmpeg-with-android-ndk-r5b" MODIFIED="1357025593818" TEXT="even if you put into your build_android.sh file the Windows path,"/>
<node CREATED="1357025579121" ID="ID_1975968584" MODIFIED="1357025580436" TEXT="the config for FFmpeg still contains the wrong path."/>
</node>
<node CREATED="1354015572812" ID="ID_258104671" MODIFIED="1354015594625" TEXT="/cygdrive/e not working"/>
</node>
</node>
<node CREATED="1353307634890" FOLDED="true" ID="ID_765363732" LINK="http://developer.android.com/tools/sdk/ndk/overview.html" MODIFIED="1428649718036" TEXT="NDK">
<node CREATED="1353662830062" ID="ID_281437760" LINK="http://developer.android.com/tools/sdk/ndk/index.html#Installing" MODIFIED="1353662840203" TEXT="installing"/>
<node CREATED="1353989501218" FOLDED="true" ID="ID_942674381" MODIFIED="1428649718036" TEXT="Android.mk">
<node CREATED="1353989521640" ID="ID_1317866153" LINK="http://mindtherobot.com/blog/452/android-beginners-ndk-setup-step-by-step/" MODIFIED="1353989531640" TEXT="for the NDK build process to recognize your NDK modules"/>
</node>
<node CREATED="1353998722921" ID="ID_523343287" MODIFIED="1353998727312" TEXT="ARM"/>
</node>
<node CREATED="1353153914212" FOLDED="true" ID="ID_18574036" LINK="http://www.koushikdutta.com/2009/01/jni-in-android-and-foreword-of-why-jni.html" MODIFIED="1428649718037" TEXT="JNI in Android">
<node CREATED="1353994447437" ID="ID_1080712077" MODIFIED="1369132098000" TEXT="possible to call Java methods from native code"/>
<node CREATED="1353995485937" ID="ID_1276342390" MODIFIED="1353995494281" TEXT="x86">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1357785263656" FOLDED="true" ID="ID_174858325" MODIFIED="1428649718037" TEXT="Build the Native Code">
<node CREATED="1357785203109" ID="ID_372921592" MODIFIED="1357785210343" TEXT="Android.mk">
<icon BUILTIN="info"/>
<icon BUILTIN="yes"/>
</node>
</node>
<node CREATED="1357785747359" FOLDED="true" ID="ID_849750152" MODIFIED="1428649718037" TEXT="use generated header">
<node CREATED="1357785765140" ID="ID_538966171" MODIFIED="1357785771031" TEXT="delete files"/>
<node CREATED="1357785771546" ID="ID_1147578050" LINK="http://dmitrydzz-hobby.blogspot.tw/2012/04/how-to-build-ffmpeg-and-use-it-in.html" MODIFIED="1357785786187" TEXT="use bash script"/>
</node>
<node CREATED="1357785856625" ID="ID_1559804020" MODIFIED="1357785858875" TEXT="build own libffmepg.so with own configuration"/>
<node CREATED="1357722526746" ID="ID_670092174" LINK="http://mobilepearls.com/labs/ndk-builder-in-eclipse/" MODIFIED="1357722539309" TEXT="Setting up Automatic NDK Builds in Eclipse"/>
<node CREATED="1357787988640" ID="ID_784159722" MODIFIED="1357787997046" TEXT="how to call back">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1357785407609" ID="ID_642293020" LINK="http://www.roman10.net/how-to-build-android-applications-based-on-ffmpeg-by-an-example/" MODIFIED="1357785425156" TEXT="The ARMv7 is significanly faster due to the use of the hardware FPU">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1355816963031" FOLDED="true" ID="ID_454653967" LINK="http://sourceforge.net/projects/ffmpeg4android/" MODIFIED="1428649718039" TEXT="FFmpeg4Android">
<icon BUILTIN="idea"/>
<icon BUILTIN="full-3"/>
<node CREATED="1357268824437" ID="ID_151738078" MODIFIED="1357268826484" TEXT="Configure and build FFmpeg library with Android NDK"/>
<node CREATED="1355817003656" ID="ID_1425975320" LINK="http://stackoverflow.com/questions/12534034/ffmpeg-vs-vitamio" MODIFIED="1355817031390" TEXT="FFmpeg for Android might be worth investigating."/>
<node CREATED="1355817015671" ID="ID_1771163673" MODIFIED="1355817017421" TEXT="From the author, &quot;My goal was to create FFmpeg library which can be compiled under Android source code tree, using Android NDK."/>
<node CREATED="1354248208234" FOLDED="true" ID="ID_661437880" MODIFIED="1428649718039" TEXT="note">
<node CREATED="1356931544804" ID="ID_1365133119" MODIFIED="1357028586788" TEXT="beta">
<icon BUILTIN="info"/>
</node>
<node CREATED="1356931491993" ID="ID_232276694" MODIFIED="1356931516814" TEXT="FFmpeg releases: 0.7.13, 0.8.12, 0.9.2, 0.10.6, 0.11.2, 1.0, HEAD"/>
<node CREATED="1356931540191" ID="ID_1991110019" MODIFIED="1356931541764" TEXT="Android target OS: Honeycomb, ICS, Android Master branch"/>
</node>
<node CREATED="1358426484219" ID="ID_1624243554" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1358426546631" TEXT="relatively new">
<icon BUILTIN="info"/>
</node>
<node CREATED="1358428923612" ID="ID_1031399701" MODIFIED="1358428937335" TEXT="I use NDK r8d to test"/>
<node CREATED="1358429419359" ID="ID_963002174" MODIFIED="1358429422720" TEXT="Android source code tree">
<icon BUILTIN="help"/>
</node>
<node CREATED="1358429436379" ID="ID_109499498" MODIFIED="1358429456537" TEXT="Android build environment">
<icon BUILTIN="help"/>
</node>
<node CREATED="1358429438553" ID="ID_324807940" MODIFIED="1358429454704" TEXT="envsetup.sh">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1354680310781" FOLDED="true" ID="ID_544337878" LINK="https://github.com/yixia/FFmpeg-Android" MODIFIED="1431247754736" TEXT="yixia / FFmpeg-Android">
<icon BUILTIN="full-4"/>
<node CREATED="1356687591203" ID="ID_675551188" MODIFIED="1356687593906" TEXT="The FFmpeg code used in VPlayer for Android"/>
<node CREATED="1367243062933" ID="ID_1513132771" MODIFIED="1367243068232" TEXT="recommended to use NDK r8b">
<icon BUILTIN="info"/>
</node>
<node CREATED="1372300581924" FOLDED="true" ID="ID_248178091" MODIFIED="1428649718039" TEXT="cygwin">
<node CREATED="1367227053421" ID="ID_1044944563" MODIFIED="1367227058640" TEXT="export TMPDIR=."/>
</node>
<node CREATED="1372300660404" FOLDED="true" ID="ID_1326907110" MODIFIED="1431247754736" TEXT="ubuntu">
<node CREATED="1367431220525" FOLDED="true" ID="ID_964723465" MODIFIED="1431247754736" TEXT="install ccache">
<node CREATED="1367431265363" ID="ID_569999633" LINK="http://blog.csdn.net/fanbird2008/article/details/8295318" MODIFIED="1367431358744" TEXT="one software packet speeding up recompiling."/>
<node CREATED="1367432380922" ID="ID_1377032526" LINK="http://www.41post.com/4509/programming/android-use-ccache-with-android-ndk-in-cygwin" MODIFIED="1367432396249" TEXT="Use ccache with Android NDK on Cygwin"/>
<node CREATED="1367432717207" ID="ID_1174284593" MODIFIED="1367432719082" TEXT=" export NDK_CCACHE=ccache. NDK&#x7684;&#x6784;&#x5efa;&#x7cfb;&#x7edf;&#x5c31;&#x4f1a;&#x5728;&#x7f16;&#x8bd1;&#x4efb;&#x4f55;&#x6e90;&#x6587;&#x4ef6;&#x7684;&#x65f6;&#x5019;&#x81ea;&#x52a8;&#x4f7f;&#x7528;&#x5b83;"/>
<node CREATED="1367433334743" ID="ID_1063451601" MODIFIED="1367433345594" TEXT="how about distcc">
<icon BUILTIN="help"/>
</node>
<node CREATED="1367433386758" ID="ID_1427300225" LINK="http://blog.csdn.net/kenny_yu/article/details/1600889" MODIFIED="1419046361040" TEXT="&#x4f7f;&#x7528;distcc&#x548c;ccache&#x7f29;&#x77ed;C/C++&#x9879;&#x76ee;&#x7f16;&#x8bd1;&#x65f6;&#x95f4;"/>
</node>
</node>
<node CREATED="1367242912179" FOLDED="true" ID="ID_1204868863" LINK="http://vitamio.org/pages/how-to-use-vitamio-with-your-own-ffmpeg-build" MODIFIED="1428649718042" TEXT="How to use Vitamio with your own FFmpeg build">
<icon BUILTIN="info"/>
<node CREATED="1357042472922" FOLDED="true" ID="ID_435881401" MODIFIED="1428649718041" TEXT="fork">
<node CREATED="1357042453028" FOLDED="true" ID="ID_1218649650" LINK="https://github.com/vecio/FFmpeg-Android" MODIFIED="1428649718041" TEXT="vecio / FFmpeg-Android">
<node CREATED="1354186866765" FOLDED="true" ID="ID_1879425429" LINK="http://vec.io/posts/how-to-build-ffmpeg-with-android-ndk" MODIFIED="1428649718041" TEXT="How to build FFmpeg with Android NDK">
<icon BUILTIN="full-3"/>
<node CREATED="1356656404941" ID="ID_1827048176" MODIFIED="1356656424065" TEXT=" from the latest ffmpeg git repository"/>
<node CREATED="1356656415317" ID="ID_1537543652" MODIFIED="1356656416711" TEXT="with the latest Android NDK version"/>
<node CREATED="1359207686701" FOLDED="true" ID="ID_1874030144" MODIFIED="1428649718040" TEXT="Got FFmpeg">
<node CREATED="1359207689602" ID="ID_1068210616" MODIFIED="1359207692183" TEXT="bypass"/>
<node CREATED="1359207757921" ID="ID_1577518708" MODIFIED="1359207762580" TEXT="use 0.11.1"/>
<node CREATED="1359239869927" ID="ID_1204178477" MODIFIED="1359239873977" TEXT="git clone git://source.ffmpeg.org/ffmpeg.git ffmpeg"/>
</node>
<node CREATED="1359207704215" FOLDED="true" ID="ID_36330031" MODIFIED="1428649718041" TEXT="Configure NDK">
<node CREATED="1359207988576" ID="ID_72446322" MODIFIED="1359207990380" TEXT="use the Android standalone toolchain"/>
<node CREATED="1359208015548" ID="ID_1731433876" MODIFIED="1359208017217" TEXT="More details about Android standalone toolchain can be found in Android NDK&apos;s docs"/>
</node>
<node CREATED="1359207717510" ID="ID_1348979029" MODIFIED="1359207719202" TEXT="Configure FFmpeg"/>
</node>
</node>
<node CREATED="1372300554315" ID="ID_1917634994" MODIFIED="1372300563830" TEXT="the same">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1367432983874" FOLDED="true" ID="ID_1063347126" MODIFIED="1428649718042" TEXT="done! and how to use?">
<node CREATED="1367549028750" ID="ID_499137695" MODIFIED="1367549040015" TEXT="porting ffplay">
<icon BUILTIN="help"/>
</node>
<node CREATED="1367549045718" ID="ID_285182760" MODIFIED="1367549056796" TEXT="to get streaming"/>
</node>
<node CREATED="1369301724718" ID="ID_1007045984" LINK="http://git.videolan.org/?p=ffmpeg.git" MODIFIED="1369301741062" TEXT="ffmpeg commit online"/>
<node CREATED="1372304073229" FOLDED="true" ID="ID_530052302" MODIFIED="1428649718058" TEXT="2 phases">
<node CREATED="1369366954078" ID="ID_1906397813" MODIFIED="1369366959906" TEXT="5e99df019a850e9ffa96d73e72b8a47a93a61de8">
<icon BUILTIN="yes"/>
</node>
<node CREATED="1372304089229" FOLDED="true" ID="ID_499258846" MODIFIED="1428649718042" TEXT="build under CLI">
<node CREATED="1372303965173" ID="ID_1785190471" MODIFIED="1372303978092" TEXT="build with NDK r8e ok"/>
<node CREATED="1372304035197" ID="ID_1482670642" LINK="file:///home/bryan/android/ndk/r8e/documentation.html" MODIFIED="1372304045626" TEXT="r8e documentation"/>
</node>
<node CREATED="1372303919701" ID="ID_218878335" MODIFIED="1372303939347" TEXT="integrate Eclipse NDK plugin"/>
<node CREATED="1372304208629" ID="ID_959971359" LINK="http://stackoverflow.com/questions/13798602/how-to-build-include-ffmpeg-into-an-existing-android-project" MODIFIED="1372304230322" TEXT="How to build + include FFMPEG into an existing Android project"/>
<node CREATED="1372304411197" ID="ID_1087052355" MODIFIED="1372304417643" TEXT="rename ABI"/>
<node CREATED="1372304418053" ID="ID_1701502333" MODIFIED="1372304421997" TEXT="import"/>
<node CREATED="1372304424005" ID="ID_119687798" MODIFIED="1372304428909" TEXT="modify android.mk"/>
<node CREATED="1372304234469" ID="ID_864358192" MODIFIED="1372304245815" TEXT="verify">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1360882264884" FOLDED="true" ID="ID_1361229130" LINK="#ID_1765568002" MODIFIED="1428649718059" TEXT="Use Android Hardware Decoder with OMXCodec in NDK">
<icon BUILTIN="full-5"/>
<node CREATED="1374284677740" ID="ID_257810720" LINK="http://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html" MODIFIED="1374284699988" TEXT="GCC optimizations are included"/>
<node CREATED="1374284757762" ID="ID_144120391" LINK="http://vec.io/posts/how-to-build-ffmpeg-with-android-ndk" MODIFIED="1374284776429" TEXT="How to Build FFmpeg with Android NDK"/>
</node>
<node CREATED="1366071008486" FOLDED="true" ID="ID_310972689" LINK="#ID_1858113916" MODIFIED="1428649718059" TEXT="appunite / AndroidFFmpeg">
<icon BUILTIN="full-6"/>
<node CREATED="1369384884812" ID="ID_1171985530" MODIFIED="1369384915656" TEXT="not using openmax"/>
</node>
<node CREATED="1356687687078" FOLDED="true" ID="ID_1624980083" LINK="https://bitbucket.org/ABitNo/ffmpegandroid" MODIFIED="1428649718059" TEXT="BitBucket version">
<node CREATED="1356687995046" ID="ID_271749843" LINK="https://github.com/abitno/FFmpeg-Android" MODIFIED="1356688009031" TEXT="GitHub version"/>
</node>
</node>
<node CREATED="1354241994593" FOLDED="true" ID="ID_1689824317" MODIFIED="1428649718065" TEXT="configuring">
<node CREATED="1354513738453" FOLDED="true" ID="ID_689318747" LINK="http://superonion.iteye.com/blog/1609777?page=2" MODIFIED="1428649718060" TEXT="&#x9700;&#x8981;&#x8054;&#x7f51;&#x7684;&#x8bdd;">
<node CREATED="1356674405140" ID="ID_1616665142" MODIFIED="1356674407484" TEXT="&#x8fd8;&#x9700;&#x8981;&#x5c06;config.h&#x4e2d;&#x7684;&#x4ee5;&#x4e0b;&#x5b9a;&#x4e49;&#x7f6e;&#x4e3a;1"/>
<node CREATED="1356674455187" ID="ID_1480821436" MODIFIED="1356674469062" TEXT="change config.mak manually"/>
</node>
<node CREATED="1354242007546" FOLDED="true" ID="ID_1287215466" LINK="https://github.com/guardianproject/android-ffmpeg/blob/master/configure_ffmpeg.sh" MODIFIED="1428649718060" TEXT="guardianproject / android-ffmpeg">
<node CREATED="1356616221196" ID="ID_1471298464" LINK="https://github.com/guardianproject/android-ffmpeg#readme" MODIFIED="1356616237961" TEXT="my clean, easily changeable, static ffmpeg creator for Android"/>
<node CREATED="1358426560352" ID="ID_755998697" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1358426575591" TEXT="most easy to build, easy to use implementation"/>
</node>
<node CREATED="1356674525562" ID="ID_630464030" LINK="http://stackoverflow.com/questions/7906944/ffmpeg-api-how-to-connect-to-rtsp-stream-using-av-open-input-file" MODIFIED="1356674538703" TEXT="How to connect to RTSP stream using av_open_input_file"/>
<node CREATED="1353998933328" FOLDED="true" ID="ID_360703247" LINK="http://iamkcspa.pixnet.net/blog/post/36123700" MODIFIED="1428649718061" TEXT="&#x5c07;FFmpeg&#x6574;&#x5408;&#x81f3;Android&#x5e73;&#x53f0;">
<node CREATED="1354247612062" ID="ID_77149834" MODIFIED="1354247639796" TEXT="too many hand-made midification">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1357265860171" ID="ID_1638751767" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1357265875843" TEXT="you need to enable the muxers/demuxers/encoders/decoders of the formats you want to use"/>
<node CREATED="1357206930890" ID="ID_928042247" LINK="https://www.google.com/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=9&amp;cad=rja&amp;ved=0CIEBEBYwCA&amp;url=http%3A%2F%2Fwww.tangentsoftworks.com%2Fblog%2Fwp-content%2Fuploads%2F2012%2F11%2FFFmpeg-Configure-Options.pdf&amp;ei=K1PlUNabJ8-XkgXG54HgAg&amp;usg=AFQjCNEN5Z4Y0rhvW3r5DjnjMFRct8_MbA&amp;sig2=BhwA_Nd_szO52_zkoMYA9g" MODIFIED="1357206945828" TEXT="FFmpeg Configure Options"/>
<node CREATED="1357206116562" FOLDED="true" ID="ID_744765450" LINK="http://blog.csdn.net/angelmejlu/article/details/2305793" MODIFIED="1428649718062" TEXT="ffmpeg ./configure&#x53c2;&#x6570;&#x8bf4;&#x660e;">
<arrowlink DESTINATION="ID_744765450" ENDARROW="Default" ENDINCLINATION="0;0;" ID="Arrow_ID_1536121729" STARTARROW="None" STARTINCLINATION="0;0;"/>
<linktarget COLOR="#b0b0b0" DESTINATION="ID_744765450" ENDARROW="Default" ENDINCLINATION="0;0;" ID="Arrow_ID_1536121729" SOURCE="ID_744765450" STARTARROW="None" STARTINCLINATION="0;0;"/>
<node CREATED="1357206217921" FOLDED="true" ID="ID_1254126878" MODIFIED="1428649718062" TEXT="--enable-encoder">
<node CREATED="1357206221453" FOLDED="true" ID="ID_1471928240" MODIFIED="1428649718061" TEXT="what are the available options">
<node CREATED="1357206308125" ID="ID_1341258944" MODIFIED="1357206309812" TEXT="mpeg2video"/>
</node>
</node>
</node>
<node CREATED="1357267089500" FOLDED="true" ID="ID_1096080108" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1428649718064" TEXT="You&apos;ll need to extract bionic(libc) and zlib(libz) from the Android build as well">
<node CREATED="1357267101968" ID="ID_309955346" MODIFIED="1357267104078" TEXT="as ffmpeg libraries depend on them."/>
<node CREATED="1360121024250" ID="ID_679944115" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1360121037984" TEXT="The main thing that&apos;s missing is a decent JNI interface to make it accessible via Java"/>
</node>
<node CREATED="1358143852406" FOLDED="true" ID="ID_129212145" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1428649718064" TEXT="Here are the steps I went through in getting ffmpeg to work on Android">
<arrowlink DESTINATION="ID_129212145" ENDARROW="Default" ENDINCLINATION="0;0;" ID="Arrow_ID_1526289947" STARTARROW="None" STARTINCLINATION="0;0;"/>
<linktarget COLOR="#b0b0b0" DESTINATION="ID_129212145" ENDARROW="Default" ENDINCLINATION="0;0;" ID="Arrow_ID_1526289947" SOURCE="ID_129212145" STARTARROW="None" STARTINCLINATION="0;0;"/>
<node CREATED="1358143872203" ID="ID_751286115" MODIFIED="1358143873421" TEXT="Build static libraries of ffmpeg for Android."/>
<node CREATED="1358143916781" ID="ID_1852473968" MODIFIED="1358143919406" TEXT="Create a dynamic library wrapping ffmpeg functionality using the Android NDK"/>
<node CREATED="1358143930390" ID="ID_1800333604" MODIFIED="1358143994968" TEXT="Use the ffmpeg-wrapping dynamic library from your java sources">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1354187441937" FOLDED="true" ID="ID_377989601" LINK="http://www.shouyanwang.org/thread-1753-1-1.html" MODIFIED="1428649718064" TEXT="android ffmpeg &#x79fb;&#x690d; -&#x9644;&#x6e90;&#x7801;&#x548c;&#x53ef;&#x89e3;&#x7801;so">
<node CREATED="1361157993906" ID="ID_496909091" MODIFIED="1361158004812" TEXT="win / cygwin / ndkr7"/>
<node CREATED="1361158022515" ID="ID_979566720" MODIFIED="1361158031593" TEXT="configuration">
<icon BUILTIN="info"/>
</node>
<node CREATED="1361158102859" ID="ID_779859207" MODIFIED="1361158104328" TEXT="&#x628a;a&#x6587;&#x4ef6;&#x5408;&#x6210;&#x4e3a;&#x4e00;&#x4e2a;so&#x81ea;&#x5df1;&#x518d;&#x5355;&#x72ec;&#x7684;&#x5199;&#x4e00;&#x4e2a;&#x5916;&#x90e8;&#x7684;&#x63a5;&#x53e3;"/>
<node CREATED="1361158124750" ID="ID_1637193394" MODIFIED="1361158126281" TEXT="&#x8fd8;&#x6709;&#x8def;&#x5f84;&#x65b9;&#x9762;&#x7684;&#x95ee;&#x9898;"/>
<node CREATED="1361158158734" ID="ID_1432284124" MODIFIED="1361158169390" TEXT="JNI code example"/>
</node>
<node CREATED="1362950139615" FOLDED="true" ID="ID_1598350907" LINK="http://vec.io/posts/how-to-build-ffmpeg-with-android-ndk" MODIFIED="1428649718065" TEXT="How to build FFmpeg with Android NDK">
<node CREATED="1362950205301" ID="ID_1389920683" MODIFIED="1362950206635" TEXT=" build FFmpeg from the latest git repository"/>
<node CREATED="1362950227256" ID="ID_833835513" MODIFIED="1362950255708" TEXT="we don&#x2019;t use the traditional Android.mk file to build FFmpeg">
<icon BUILTIN="info"/>
</node>
<node CREATED="1362950250800" ID="ID_666340373" MODIFIED="1362950252399" TEXT=" try the Android NDK standalone toolchain"/>
<node CREATED="1362950372604" ID="ID_1528304243" MODIFIED="1362950378163" TEXT=" some GCC optimizations are included">
<icon BUILTIN="info"/>
</node>
<node CREATED="1362950425881" ID="ID_29040951" MODIFIED="1362950426955" TEXT="For those who wanna the full code, please go to https://github.com/vecio/FFmpeg-Android."/>
</node>
</node>
<node CREATED="1358426065661" ID="ID_32234114" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1358426099367" TEXT=" relatively new FFmpeg for Android"/>
<node CREATED="1354524362875" FOLDED="true" ID="ID_900343582" MODIFIED="1428649718066" TEXT="advance topic">
<node CREATED="1354524385390" FOLDED="true" ID="ID_321102195" MODIFIED="1428649718065" TEXT="different version of ffmpeg">
<node CREATED="1354524470859" ID="ID_1859653025" MODIFIED="1354524476718" TEXT="latest version"/>
</node>
<node CREATED="1354524393281" FOLDED="true" ID="ID_1943867685" MODIFIED="1428649718065" TEXT="different host">
<node CREATED="1356675848890" ID="ID_575387469" MODIFIED="1356675861578" TEXT="build on ubuntu linux"/>
<node CREATED="1356675862609" ID="ID_763781312" MODIFIED="1356675875203" TEXT="take advantage on CPU resource"/>
<node CREATED="1354524457968" ID="ID_983367726" MODIFIED="1354524463046" TEXT="63 is preferred"/>
</node>
<node CREATED="1354524425312" FOLDED="true" ID="ID_1049710859" MODIFIED="1428649718066" TEXT="different configuration">
<node CREATED="1354524485671" ID="ID_205367642" MODIFIED="1354524491500" TEXT="enable networking"/>
</node>
<node CREATED="1354524379593" ID="ID_850788513" MODIFIED="1354524384953" TEXT="x86 cpu"/>
</node>
<node CREATED="1372918300374" FOLDED="true" ID="ID_822416942" MODIFIED="1428649718076" TEXT="static link vs. dynamic link">
<node CREATED="1358143810500" FOLDED="true" ID="ID_290859636" MODIFIED="1428649718074" TEXT="make libffmpeg.so">
<node CREATED="1357003939165" FOLDED="true" ID="ID_1363862157" LINK="http://web.archiveorange.com/archive/v/4q4Bhl5HwObzjGkaJaKi" MODIFIED="1428649718067" TEXT="libstagefright doesnt work on android">
<node CREATED="1357003501049" FOLDED="true" ID="ID_977807208" MODIFIED="1428649718066" TEXT="how to test it or use it.">
<node CREATED="1357003583204" ID="ID_45601509" LINK="http://web.archiveorange.com/archive/v/4q4Bhl5HwObzjGkaJaKi" MODIFIED="1357003620302" TEXT="libstagefright is configured as the H.264 decoder."/>
</node>
<node CREATED="1357003784576" ID="ID_850477904" MODIFIED="1357003788545" TEXT=" which wrapper application should i use to test this"/>
<node CREATED="1357003916139" ID="ID_606267948" MODIFIED="1357003918983" TEXT="Rather than trying it using vlc, tested it using ffmpeg"/>
</node>
<node CREATED="1359244454668" FOLDED="true" ID="ID_1012043005" MODIFIED="1428649718068" TEXT="clues">
<icon BUILTIN="idea"/>
<node CREATED="1358850843406" FOLDED="true" ID="ID_677908916" MODIFIED="1428649718067" TEXT="use static link">
<icon BUILTIN="idea"/>
<node CREATED="1358851903156" ID="ID_608801856" MODIFIED="1358851911515" TEXT="add application.mk"/>
</node>
<node CREATED="1359240264334" FOLDED="true" ID="ID_1688281994" MODIFIED="1428649718067" TEXT="build-stlport.sh">
<icon BUILTIN="idea"/>
<node CREATED="1359240299840" ID="ID_607408664" MODIFIED="1359240319323" TEXT="what is this">
<icon BUILTIN="help"/>
</node>
<node CREATED="1359240320400" ID="ID_16920504" MODIFIED="1359240327091" TEXT="any help">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1359244141052" FOLDED="true" ID="ID_512412187" LINK="http://stackoverflow.com/questions/4893403/cant-include-c-headers-like-vector-in-android-ndk" MODIFIED="1428649718068" TEXT="Can&apos;t include C++ headers like vector in Android NDK">
<node CREATED="1359244169579" ID="ID_1984717437" LINK="http://stackoverflow.com/questions/4893403/cant-include-c-headers-like-vector-in-android-ndk" MODIFIED="1359244192534" TEXT="First off, check the android-ndk-r5\build\platforms\android-X\arch-arm\usr\include directory - is vector really there?"/>
</node>
<node CREATED="1359244435044" FOLDED="true" ID="ID_1011016179" MODIFIED="1428649718068" TEXT="Android NDK - getting STLPort up and running">
<icon BUILTIN="idea"/>
<node CREATED="1359244443269" ID="ID_1437129527" MODIFIED="1359244449982" TEXT="little bit old"/>
</node>
</node>
<node CREATED="1361082396006" FOLDED="true" ID="ID_80344974" MODIFIED="1428649718071" TEXT="built from build_libstagefright">
<node CREATED="1357111269818" FOLDED="true" ID="ID_38209444" LINK="http://stackoverflow.com/questions/13246489/use-build-libstagefright-in-ffmpeg-to-build-file-so-for-android" MODIFIED="1428649718070" TEXT="Use build_libstagefright in ffmpeg to build file .so for android">
<icon BUILTIN="bookmark"/>
<node CREATED="1358474498000" FOLDED="true" ID="ID_1520278878" MODIFIED="1428649718068" TEXT="export NDK=...">
<node CREATED="1358474513546" ID="ID_1460703074" MODIFIED="1358488913750" TEXT="ubuntu / r8c">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1360930190860" ID="ID_1602455592" MODIFIED="1360930330938" TEXT="ubuntu / r8d">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1360930457701" ID="ID_275187844" MODIFIED="1360930738694" TEXT="0.10.6">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node CREATED="1358487848343" ID="ID_1049843189" MODIFIED="1358487856125" TEXT="enable-shared"/>
<node CREATED="1358487916328" FOLDED="true" ID="ID_211880695" MODIFIED="1428649718069" TEXT="how to">
<node CREATED="1358487962406" FOLDED="true" ID="ID_715707951" MODIFIED="1428649718069" TEXT="get a single libffmpeg.so">
<node CREATED="1358506603937" FOLDED="true" ID="ID_1970562761" MODIFIED="1428649718069" TEXT="modify build_libstagefright">
<node CREATED="1358506692593" ID="ID_111288161" MODIFIED="1358506704953" TEXT="add ar, ld"/>
<node CREATED="1358506681734" ID="ID_506818724" MODIFIED="1358506689953" TEXT="add -lstlport"/>
</node>
</node>
<node CREATED="1358487923718" ID="ID_220172005" MODIFIED="1358487952265" TEXT="extract headers gracefully">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1356932179340" FOLDED="true" ID="ID_43753190" LINK="http://ffmpeg.org/pipermail/ffmpeg-devel/2012-May/124566.html" MODIFIED="1428649718070" TEXT="To build ffmpeg with libstagefright">
<icon BUILTIN="info"/>
<node CREATED="1356932196323" ID="ID_530387204" MODIFIED="1356932198963" TEXT="run tools/build_libstagefright."/>
<node CREATED="1356932920348" ID="ID_1978530380" MODIFIED="1356932933779" TEXT="at ffmpeg/tools"/>
<node CREATED="1357003149430" ID="ID_1867514748" MODIFIED="1357003153083" TEXT="change the OS from Window 7 to Linux"/>
<node CREATED="1357003191346" FOLDED="true" ID="ID_173479034" MODIFIED="1428649718070" TEXT="ffmpeg version is 1.0">
<node CREATED="1358597779558" ID="ID_1556967275" MODIFIED="1358597789597" TEXT="1.1">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1357003306619" ID="ID_604213887" MODIFIED="1357003309614" TEXT="NDK-r8b"/>
<node CREATED="1358431147918" ID="ID_1458558523" MODIFIED="1358431155874" TEXT="NDK-r8d as well"/>
<node CREATED="1358488919187" ID="ID_1833221391" MODIFIED="1358488939734" TEXT="windows / ndk / r8c / cygwin"/>
</node>
<node CREATED="1360941655401" ID="ID_665393812" MODIFIED="1361060309107" TEXT="-L$NDK/sources/cxx-stl/gnu-libstdc++/libs/armeabi"/>
<node CREATED="1358635775545" FOLDED="true" ID="ID_994676328" LINK="http://stackoverflow.com/questions/13246489/use-build-libstagefright-in-ffmpeg-to-build-file-so-for-android" MODIFIED="1428649718071" TEXT="Use build_libstagefright in ffmpeg to build file .so for android">
<node CREATED="1358635642532" ID="ID_136636845" LINK="http://permalink.gmane.org/gmane.comp.video.ffmpeg.user/41675" MODIFIED="1358635675781" TEXT="require_cpp">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1358491468890" ID="ID_1592916353" LINK="http://dmitrydzz-hobby.blogspot.tw/2012/04/how-to-build-ffmpeg-and-use-it-in.html" MODIFIED="1358491481718" TEXT="only need headers"/>
<node CREATED="1361082247063" FOLDED="true" ID="ID_637554208" LINK="http://dmitrydzz-hobby.blogspot.tw/2012/04/how-to-build-ffmpeg-and-use-it-in.html" MODIFIED="1428649718072" TEXT="link from statically built library">
<node CREATED="1361082314853" FOLDED="true" ID="ID_1179899352" MODIFIED="1428649718071" TEXT="non-numeric second argument to `wordlist&apos; function: &apos;&apos;.  Stop.">
<node CREATED="1361082220659" ID="ID_888026226" MODIFIED="1361082231918" TEXT="&#x8fd9;&#x4e2a;error&#x662f;&#x7531;&#x4e8e;jni&#x4e0a;&#x5c42;&#x7684;AndroidManifest.xml&#x7684;&#x95ee;&#x9898;&#x5bfc;&#x81f4;&#x7684;"/>
<node CREATED="1361082233857" ID="ID_1230300065" MODIFIED="1361082244574" TEXT="&#x6240;&#x4ee5;&#x5728;&#x751f;&#x6210;so&#x7684;&#x65f6;&#x5019;&#xff0c;&#x5148;&#x628a;&#x8fd9;&#x4e2a;&#x6587;&#x4ef6;&#x5220;&#x9664;&#x7f16;&#x8bd1;&#x5373;&#x53ef;"/>
</node>
</node>
<node CREATED="1356932249791" FOLDED="true" ID="ID_1641012536" MODIFIED="1428649718073" TEXT="To use it in your application">
<icon BUILTIN="button_ok"/>
<node CREATED="1356932270771" FOLDED="true" ID="ID_1274426859" LINK="http://ffmpeg.org/pipermail/ffmpeg-devel/2012-May/124566.html" MODIFIED="1428649718072" TEXT="you&apos;ll have to link against these android libs">
<node CREATED="1361281252513" ID="ID_249021469" MODIFIED="1361281256799" TEXT="How to link a specific version of a shared library in makefile">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1361155177044" FOLDED="true" ID="ID_936813839" LINK="http://ffmpeg.org/pipermail/ffmpeg-devel/2012-May/124565.html" MODIFIED="1428649718072" TEXT="you have to link against libstagefright.so, libbinder.so, libmedia.so and libutils.so">
<icon BUILTIN="info"/>
<node CREATED="1361155218794" ID="ID_498857520" MODIFIED="1361155220372" TEXT="in the android-libs folder created during build"/>
<node CREATED="1361155237232" ID="ID_373221449" MODIFIED="1361155238841" TEXT="or from /system/lib in your device/emulator."/>
</node>
<node CREATED="1361152595466" ID="ID_1455226722" LINK="http://ffmpeg.org/pipermail/ffmpeg-devel/2012-May/124565.html" MODIFIED="1361152608497" TEXT="Builds for API levels 8-10 (froyo-gingerbread) should be mutually compatible."/>
<node CREATED="1361095365724" FOLDED="true" ID="ID_1891927783" MODIFIED="1428649718073" TEXT="ANDROID_LIBS=../android-libs">
<icon BUILTIN="idea"/>
<node CREATED="1356932305429" ID="ID_1890937233" MODIFIED="1361155313685" TEXT="libstagefright.so, libbinder.so, libutils.so, libmedia.so">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1361314592619" ID="ID_139471749" LINK="http://stackoverflow.com/questions/6165813/using-my-own-prebuilt-shared-library-in-an-android-ndk-project" MODIFIED="1361314623818" TEXT="Using my own prebuilt shared library in an Android NDK project"/>
<node CREATED="1361314474451" ID="ID_1707879845" MODIFIED="1361314495160" TEXT="NDK / LOCAL_SHARED_LIBRARIES">
<icon BUILTIN="button_ok"/>
</node>
</node>
<node CREATED="1362985922734" FOLDED="true" ID="ID_1028393124" MODIFIED="1428649718074" TEXT="guard against exception handling">
<node CREATED="1362985956421" ID="ID_1420153159" LINK="http://blog.csdn.net/yang_hui1986527/article/details/6680489" MODIFIED="1362985970250" TEXT="Android Jni&#x8c03;&#x7528;so&#x5e93;&#xff0c;&#x52a0;&#x8f7d;&#x5e93;&#x5931;&#x8d25;&#x5206;&#x6790;"/>
<node CREATED="1362986057453" ID="ID_710520334" MODIFIED="1362986058875" TEXT="UnsatisfiedLinkError"/>
<node CREATED="1362986161140" FOLDED="true" ID="ID_1659772917" LINK="http://www.cppblog.com/kongque/archive/2010/11/20/134160.aspx" MODIFIED="1428649718073" TEXT="android ndk&#x7a0b;&#x5e8f;UnsatisfiedLinkError&#x89e3;&#x51b3;&#x65b9;&#x6848;">
<node CREATED="1362986146234" ID="ID_283588632" MODIFIED="1362986148609" TEXT="&#x8be5;so&#x4e2d;&#x9700;&#x8981;&#x94fe;&#x63a5;&#x7684;&#x6240;&#x6709;&#x7b26;&#x53f7;&#x90fd;&#x9700;&#x8981;&#x80fd;&#x591f;&#x94fe;&#x63a5;&#x5230;"/>
</node>
</node>
<node CREATED="1362991391484" ID="ID_1802652585" MODIFIED="1362991398140" TEXT="cannot locate symbol &quot;__aeabi_lasr&quot; referenced by &quot;libffmpeg.so&quot;">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1373120395265" FOLDED="true" ID="ID_1367739702" MODIFIED="1428649718075" TEXT="link against static library">
<node CREATED="1373756505073" FOLDED="true" ID="ID_61006955" LINK="http://www.pressingquestion.com/1301122/Trouble-Linking-Static-Libraries-Using-Android-Ndk-R5b" MODIFIED="1428649718074" TEXT="Trouble linking static libraries using Android NDK r5b">
<node CREATED="1373756422214" ID="ID_764768253" LINK="http://www.pressingquestion.com/1301122/Trouble-Linking-Static-Libraries-Using-Android-Ndk-R5b" MODIFIED="1373756570628" TEXT="Are you building the libraries using ndk-build?">
<icon BUILTIN="info"/>
</node>
<node CREATED="1373756463466" ID="ID_1784079652" LINK="http://www.pressingquestion.com/1301122/Trouble-Linking-Static-Libraries-Using-Android-Ndk-R5b" MODIFIED="1373756564280" TEXT="If not, I usually keep libraries I&apos;ve built with the standalone toolchain"/>
<node CREATED="1373756482097" ID="ID_1903155872" MODIFIED="1373756483622" TEXT=" in the jni folder and reference them directly by name in LOCAL_LDLIBS"/>
</node>
<node CREATED="1373757929180" ID="ID_1484325829" LINK="#ID_1765568002" MODIFIED="1373757967162" TEXT="standalone toolchain"/>
</node>
<node CREATED="1372837261180" FOLDED="true" ID="ID_1775522345" LINK="http://superonion.iteye.com/blog/1609777" MODIFIED="1428649718075" TEXT="&#x5728;ffmpeg&#x6bcf;&#x500b;&#x76ee;&#x9304;&#x4e0b;&#x90fd;&#x5efa;&#x7acb;Android.mk">
<icon BUILTIN="info"/>
<node CREATED="1372837294481" ID="ID_1409171346" MODIFIED="1372837317155" TEXT="&#x7528;NDK plugin&#x5e95;&#x4e0b;build"/>
<node CREATED="1372817541322" ID="ID_916143495" LINK="http://android-jotting.blogspot.tw/2010/08/compile-static-library-only-using-ndk.html" MODIFIED="1372817561624" TEXT="Compile Static Library only using NDK"/>
<node CREATED="1373326585993" ID="ID_1852594153" LINK="#ID_618412867" MODIFIED="1373326611935" TEXT="How to build ffmpeg and use it in Android applications"/>
</node>
</node>
<node CREATED="1372918434506" ID="ID_1685270828" LINK="#ID_1765568002" MODIFIED="1373757874674" TEXT="as stagefright decoder">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1366873999265" ID="ID_1207104212" LINK="http://www.eclipse.org/sequoyah/documentation/native_debug.php" MODIFIED="1366874015093" TEXT="A step-by-step guide for debugging native code"/>
<node CREATED="1353987655796" FOLDED="true" ID="ID_793504886" MODIFIED="1428649718085" TEXT="general idea">
<node CREATED="1356663057765" FOLDED="true" ID="ID_1191115246" MODIFIED="1428649718076" TEXT="comment">
<node CREATED="1354677234183" ID="ID_1940833633" LINK="http://stackoverflow.com/questions/5666513/what-is-the-best-method-to-render-video-frames" MODIFIED="1354677253292" TEXT="ndk-gdb debugging experience is pretty lousy right now in my opinion"/>
</node>
<node CREATED="1354587448984" FOLDED="true" ID="ID_717487747" MODIFIED="1428649718077" TEXT="Graphics">
<node CREATED="1354677546964" ID="ID_610644111" LINK="http://stackoverflow.com/questions/5666513/what-is-the-best-method-to-render-video-frames" MODIFIED="1354677567121" TEXT=" You frankly need to shove the video frames through the Native supported Bitmap on Froyo and above"/>
<node CREATED="1354678217058" ID="ID_205174842" LINK="http://stackoverflow.com/questions/4676178/android-video-player-using-ndk-opengl-es-and-ffmpeg" MODIFIED="1354678269730" TEXT="Android Video Player Using NDK, OpenGL ES, and FFmpeg">
<icon BUILTIN="idea"/>
</node>
<node CREATED="1356658813296" FOLDED="true" ID="ID_92263550" MODIFIED="1428649718077" TEXT="render">
<node CREATED="1356591238343" FOLDED="true" ID="ID_1895985752" MODIFIED="1428649718077" TEXT="OpenGL in Android for video display">
<node CREATED="1356591263468" ID="ID_910011262" MODIFIED="1356591264375" TEXT="Is it possible to use OpenGL to display video and be able to resize the view in runtime?"/>
<node CREATED="1356591079625" ID="ID_1598119223" LINK="http://stackoverflow.com/questions/3315966/opengl-in-android-for-video-display" MODIFIED="1356591222062" TEXT="by uploading each frame as a texture by glTexSubImage2D"/>
<node CREATED="1356600936718" ID="ID_1405895556" LINK="http://stackoverflow.com/questions/8867616/android-ffmpeg-opengl-es-render-movie" MODIFIED="1356600950312" TEXT="should create texture only once."/>
</node>
<node CREATED="1356591337218" FOLDED="true" ID="ID_1675491472" LINK="http://stackoverflow.com/questions/5666513/what-is-the-best-method-to-render-video-frames" MODIFIED="1428649718077" TEXT="What is the best method to render video frames?">
<node CREATED="1356591320765" ID="ID_1736397688" MODIFIED="1356591323187" TEXT="decoding and displaying the frames by myself"/>
</node>
<node CREATED="1356601077703" ID="ID_24501090" LINK="http://stackoverflow.com/questions/11257444/how-to-draw-circle-rectangle-manually-on-android-videoplayer" MODIFIED="1356601091000" TEXT="How to draw circle,rectangle manually on android videoplayer"/>
</node>
</node>
<node CREATED="1354240670203" FOLDED="true" ID="ID_840009628" MODIFIED="1428649718078" TEXT="example">
<node CREATED="1354239371578" ID="ID_456838831" LINK="http://mindtherobot.com/blog/452/android-beginners-ndk-setup-step-by-step/" MODIFIED="1354239393578" TEXT="Android Beginners: NDK Setup Step by Step"/>
<node CREATED="1356590760437" FOLDED="true" ID="ID_393022849" LINK="http://quirkygba.blogspot.tw/2010/10/android-native-coding-in-c.html" MODIFIED="1428649718078" TEXT="Android Native Coding in C">
<node CREATED="1356590814718" ID="ID_487990370" LINK="http://stackoverflow.com/questions/4676178/android-video-player-using-ndk-opengl-es-and-ffmpeg" MODIFIED="1356590829734" TEXT="Using this technique I have been able to get 60 FPS"/>
</node>
</node>
<node CREATED="1359300392321" FOLDED="true" ID="ID_896580987" MODIFIED="1428649718079" TEXT="STL">
<node CREATED="1358753857984" ID="ID_594666095" MODIFIED="1358753859734" TEXT="C++ support with the Android NDK"/>
<node CREATED="1358754613406" ID="ID_14233575" LINK="http://stackoverflow.com/questions/1650963/ustl-or-stlport-for-android" MODIFIED="1361105608869" TEXT="The recommended, easy way to use it at build time is">
<icon BUILTIN="info"/>
</node>
<node CREATED="1361105611148" ID="ID_718688426" MODIFIED="1361105613013" TEXT="by defining APP_STL in the Application.mk"/>
<node CREATED="1361061891734" FOLDED="true" ID="ID_445649326" LINK="http://www.cppblog.com/kongque/archive/2011/06/29/149781.html" MODIFIED="1428649718079" TEXT="Android NDK&#x652f;&#x6301;STL&#x7684;&#x4e00;&#x4e9b;&#x6ce8;&#x610f;&#x4e8b;&#x9879;">
<icon BUILTIN="info"/>
<node CREATED="1361061878811" ID="ID_1681696063" MODIFIED="1361061880646" TEXT="Android NDK&#x4ece;r5b&#x7248;&#x672c;&#x5f00;&#x59cb;&#x6709;&#x5b98;&#x65b9;&#x652f;&#x6301;&#x7684;STL&#x4e86;"/>
<node CREATED="1361061967562" FOLDED="true" ID="ID_1076074843" MODIFIED="1428649718078" TEXT="&#x4f7f;&#x7528;Android.mk&#x548c;Application.mk">
<node CREATED="1361062002825" ID="ID_120493310" MODIFIED="1361062004125" TEXT="&#x90a3;&#x4e48;&#x9700;&#x8981;&#x5728;Application.mk&#x6587;&#x4ef6;&#x4e2d;&#x6dfb;&#x52a0;&#x4e00;&#x4e2a;&#x9009;&#x9879;"/>
<node CREATED="1361062101681" ID="ID_1332548027" LINK="http://www.41post.com/3527/programming/import-stl-libraries-to-android-ndk-code" MODIFIED="1361062118040" TEXT="Import STL libraries to the Android NDK code"/>
<node CREATED="1358754013375" ID="ID_1013646474" MODIFIED="1358754015062" TEXT="add a line like:     APP_STL := gnustl_static  To your Application.mk"/>
<node CREATED="1358754772546" FOLDED="true" ID="ID_1246884359" MODIFIED="1428649718078" TEXT="Application.mk">
<node CREATED="1358757800171" ID="ID_789557915" MODIFIED="1358757805046" TEXT="usually placed under $PROJECT/jni/Application.mk">
<icon BUILTIN="info"/>
</node>
</node>
</node>
<node CREATED="1361061972468" FOLDED="true" ID="ID_614133390" MODIFIED="1428649718079" TEXT="&#x4e0d;&#x4f7f;&#x7528;Android.mk&#x548c;Application.mk">
<node CREATED="1361062025889" ID="ID_1911296258" MODIFIED="1361062027863" TEXT="&#x9700;&#x8981;&#x6ce8;&#x610f;&#x81ea;&#x5df1;&#x8981;&#x6307;&#x5b9a;stl&#x7684;&#x5305;&#x542b;&#x8def;&#x5f84;"/>
</node>
</node>
<node CREATED="1361067039247" FOLDED="true" ID="ID_370314484" MODIFIED="1428649718079" TEXT="stlport">
<node CREATED="1358754301984" ID="ID_1222184416" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-ndk/b-mR0_vg7JE" MODIFIED="1358754313859" TEXT="Any way to point the linker to use the &apos;libstlport.so&apos;?"/>
<node CREATED="1358752806921" ID="ID_702196413" LINK="http://www.codexperiments.com/android/2010/08/tips-tricks-debugging-android-ndk-stack-traces/" MODIFIED="1358752819968" TEXT="guess NDK is not really mature yet (see discussion about STLport"/>
<node CREATED="1358758233703" ID="ID_1913992726" LINK="http://stackoverflow.com/questions/4893403/cant-include-c-headers-like-vector-in-android-ndk" MODIFIED="1358758245593" TEXT="Can&apos;t include C++ headers like vector in Android NDK"/>
<node CREATED="1358754522875" ID="ID_668099348" LINK="http://stackoverflow.com/questions/1650963/ustl-or-stlport-for-android" MODIFIED="1358754532625" TEXT="STLport supported since Android2.3 "/>
<node CREATED="1361105976653" ID="ID_182926237" LINK="http://www.kandroid.org/ndk/docs/CPLUSPLUS-SUPPORT.html" MODIFIED="1361105998861" TEXT="Note that &apos;stlport_shared&apos; is preferred">
<icon BUILTIN="info"/>
</node>
</node>
</node>
<node CREATED="1353563375984" FOLDED="true" ID="ID_427877430" LINK="professional/RTSP.mm" MODIFIED="1428649718084" TEXT="RTSP">
<node CREATED="1353029732906" FOLDED="true" ID="ID_1281553205" MODIFIED="1428649718082" TEXT="survey">
<node CREATED="1353029751859" FOLDED="true" ID="ID_131557771" MODIFIED="1428649718080" TEXT="reference">
<node CREATED="1353035440937" FOLDED="true" ID="ID_120136355" MODIFIED="1428649718080" TEXT="Google Android sample applications">
<node CREATED="1353044283453" ID="ID_1192143863" MODIFIED="1353044317140" TEXT="SkeletonActivity"/>
</node>
<node CREATED="1353035780343" ID="ID_1226570765" LINK="http://davanum.wordpress.com/2007/12/29/android-videomusic-player-sample-from-local-disk-as-well-as-remote-urls/" MODIFIED="1353035798218" TEXT="Android &#x2013; Video/Music Player Sample"/>
</node>
<node CREATED="1353116574679" FOLDED="true" ID="ID_1334262365" MODIFIED="1428649718080" TEXT="library">
<node CREATED="1353116582332" ID="ID_409273541" LINK="http://code.google.com/p/rtsplib-java/issues/detail?id=4" MODIFIED="1353116743665" TEXT="rtsplib-java"/>
<node CREATED="1354698202640" FOLDED="true" ID="ID_1722774576" LINK="http://code.google.com/p/jjmpeg/" MODIFIED="1428649718080" TEXT="jjmpeg">
<node CREATED="1354698366218" ID="ID_528695323" MODIFIED="1354698368218" TEXT="a Java binding to FFmpeg&apos;s very handy decoding and encoding libraries"/>
</node>
</node>
<node CREATED="1354407701377" FOLDED="true" ID="ID_888472339" MODIFIED="1428649718081" TEXT="framework">
<node CREATED="1354407709037" FOLDED="true" ID="ID_903984454" LINK="http://gpac.wp.mines-telecom.fr/home/" MODIFIED="1428649718080" TEXT="GPAC">
<node CREATED="1354407714453" ID="ID_1868741535" MODIFIED="1354407721876" TEXT="MPEG4"/>
</node>
</node>
<node CREATED="1355825826781" FOLDED="true" ID="ID_432889548" MODIFIED="1428649718081" TEXT="information">
<node CREATED="1354858714078" ID="ID_1108774787" LINK="http://www.javaworld.com.tw/jute/post/view?bid=26&amp;id=301334" MODIFIED="1355363871250" TEXT="RTSP&#x5728;android 3.0&#x4ee5;&#x4e0a;&#x624d;&#x6709;API&#x652f;&#x63f4;"/>
<node CREATED="1354867366078" ID="ID_1703563915" LINK="http://www.wowza.com/forums/content.php?62-RTSP-streaming-troubleshooting-guide-%28RTSP-RTP-playback%29" MODIFIED="1354867379437" TEXT="How to troubleshoot RTSP/RTP playback"/>
</node>
<node CREATED="1355803589265" FOLDED="true" ID="ID_57859007" MODIFIED="1428649718082" TEXT="evalution">
<node CREATED="1355803601984" FOLDED="true" ID="ID_1937136913" MODIFIED="1428649718081" TEXT="criteria">
<node CREATED="1355984494781" ID="ID_1335841964" MODIFIED="1355984497984" TEXT="cost"/>
<node CREATED="1355984526828" ID="ID_1328425264" MODIFIED="1355984535703" TEXT="development environment"/>
<node CREATED="1355984644718" FOLDED="true" ID="ID_1283868676" MODIFIED="1428649718081" TEXT="resource">
<node CREATED="1355984631062" ID="ID_96037076" MODIFIED="1355984639750" TEXT="documentation"/>
<node CREATED="1355984671859" ID="ID_75437509" MODIFIED="1355984676265" TEXT="source code"/>
</node>
</node>
<node CREATED="1357024026412" FOLDED="true" ID="ID_1840927569" MODIFIED="1428649718082" TEXT="performance">
<node CREATED="1355968991953" ID="ID_364874480" MODIFIED="1355968994125" TEXT="&#x652f;&#x6301;&#x786c;&#x89e3;&#x7801;&#xff1f;"/>
<node CREATED="1355968854890" ID="ID_1632769178" MODIFIED="1358232232906" TEXT="&#x652f;&#x6301;&#x54ea;&#x4e9b;&#x6307;&#x4ee4;&#x96c6;&#x7684;CPU&#xff1f;"/>
</node>
</node>
<node CREATED="1358323867129" ID="ID_927015883" LINK="http://stackoverflow.com/questions/9435670/rtsp-vs-hls-stream-which-one-will-play-smoothly-on-an-android-device" MODIFIED="1358323881551" TEXT="RTSP is only supported over UDP"/>
</node>
<node CREATED="1353029528343" FOLDED="true" ID="ID_1797020499" MODIFIED="1428649718084" TEXT="lab">
<node CREATED="1353029557343" FOLDED="true" ID="ID_834396152" MODIFIED="1428649718083" TEXT="IP camera search tool">
<node CREATED="1353045070640" FOLDED="true" ID="ID_1915826509" MODIFIED="1428649718083" TEXT="start and search">
<node CREATED="1353047530578" FOLDED="true" ID="ID_681265035" MODIFIED="1428649718082" TEXT="Show please wait spin">
<node CREATED="1353051706187" ID="ID_1402018893" LINK="http://developer.android.com/reference/android/app/ProgressDialog.html#ProgressDialog(android.content.Context)" MODIFIED="1353051730937" TEXT="ProgressDialog"/>
<node CREATED="1353054445187" ID="ID_419764064" LINK="http://malsandroid.blogspot.tw/2010/04/loading-please-wait.html" MODIFIED="1353054453062" TEXT="example"/>
</node>
<node CREATED="1353048336359" FOLDED="true" ID="ID_699862413" MODIFIED="1428649718083" TEXT="send ONVIF device discovery request">
<node CREATED="1353052867109" ID="ID_331227384" MODIFIED="1353052871687" TEXT="UDP"/>
<node CREATED="1353052872109" ID="ID_1859868639" MODIFIED="1353052875984" TEXT="multicast"/>
<node CREATED="1353052876593" ID="ID_87125879" MODIFIED="1353052880031" TEXT="port 3702"/>
<node CREATED="1353052880640" ID="ID_1176545832" MODIFIED="1353052882000" TEXT="xml"/>
</node>
<node CREATED="1353047549859" ID="ID_710246675" MODIFIED="1353047555906" TEXT="linear layout"/>
</node>
<node CREATED="1353045062187" ID="ID_83406820" MODIFIED="1353045069406" TEXT="scroll result"/>
<node CREATED="1353045082656" ID="ID_989687457" MODIFIED="1353045097625" TEXT="click to show info"/>
</node>
<node CREATED="1353029539484" FOLDED="true" ID="ID_1249078203" MODIFIED="1428649718084" TEXT="RTSP streaming player">
<node CREATED="1353030992140" ID="ID_1183306589" MODIFIED="1353031004062" TEXT="RTSP client"/>
<node CREATED="1353035120515" ID="ID_837024045" MODIFIED="1353035124859" TEXT="display video information"/>
<node CREATED="1353119742296" ID="ID_1403040822" LINK="http://paultrani.com/2010/12/1420/" MODIFIED="1353665412859" TEXT="native is better and consistent">
<icon BUILTIN="button_ok"/>
</node>
</node>
</node>
<node CREATED="1354772045375" ID="ID_1872609888" LINK="professional/RTSP.mm" MODIFIED="1355363119000" TEXT="live video source"/>
<node CREATED="1356587506437" ID="ID_804477458" MODIFIED="1356587535359" TEXT="real device&#x70ba;&#x4f55;&#x8981;&#x900f;&#x904e;rtsp&#x624d;&#x80fd;&#x958b;&#x555f;">
<icon BUILTIN="help"/>
</node>
<node CREATED="1369386072500" ID="ID_239728393" LINK="professional.mm#ID_196847705" MODIFIED="1369386204843" TEXT="Receiving RTSP stream using FFMPEG library"/>
<node CREATED="1358390510078" FOLDED="true" ID="ID_348187869" LINK="http://stackoverflow.com/questions/11123234/why-mediaplayer-on-android-doesnt-play-via-rtsp-but-vitamio-does" MODIFIED="1428649718084" TEXT="Why MediaPlayer on Android doesn&apos;t play via RTSP but Vitamio does?">
<node CREATED="1358390558171" ID="ID_1963937495" MODIFIED="1358390558171" TEXT="Vitamio somehow just changes protocol from UDP to TCP and starts work."/>
</node>
</node>
<node CREATED="1369795166281" FOLDED="true" ID="ID_366465222" LINK="http://hot-dog.twbbs.org/?p=432" MODIFIED="1428649718084" TEXT="&#x7528; javah &#x6307;&#x4ee4;&#x7522;&#x751f; JNI &#x5c0d;&#x61c9;&#x7684; Header file">
<node CREATED="1370338429734" ID="ID_677905619" MODIFIED="1372145016024" TEXT="&#x5982;&#x4f55;&#x5957;&#x7528;eclipse&#x7684;prebuild macro"/>
</node>
<node CREATED="1370392584592" FOLDED="true" ID="ID_1123083983" LINK="http://www.javaworld.com.tw/jute/post/view?bid=11&amp;id=298481&amp;sty=3" MODIFIED="1428649718085" TEXT="&#x512a;&#x9ede;&#x5728;&#x65bc;&#x53d6;&#x7528;&#x65e2;&#x6709;&#x7684;&#x539f;&#x751f;&#x7a0b;&#x5f0f;,">
<node CREATED="1370392596350" ID="ID_791114485" MODIFIED="1370392599498" TEXT="&#x4f8b;&#x5982;&#xff1a;&#x591a;&#x5a92;&#x9ad4;&#x5f71;&#x97f3;&#x89e3;&#x78bc;&#x51fd;&#x5f0f;&#x5eab;&#x3001;2D/3D&#x7e6a;&#x5716;&#x7a0b;&#x5f0f;"/>
</node>
<node CREATED="1370391214728" ID="ID_1222269824" MODIFIED="1370391229025" TEXT="why bother download source">
<icon BUILTIN="help"/>
</node>
<node CREATED="1370391301895" ID="ID_456520553" MODIFIED="1370391324561" TEXT="android NDK source &#x4e0d;&#x540c;">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1409191355212" ID="ID_535192798" MODIFIED="1409191356121" POSITION="left" TEXT="Passing Bitmap over JNI"/>
<node CREATED="1409193249364" ID="ID_1555577065" MODIFIED="1409193250338" POSITION="left" TEXT="Calling Java back from native code"/>
<node CREATED="1409195409974" ID="ID_307718208" LINK="http://goo.gl/MQZq0L" MODIFIED="1409195424644" POSITION="left" TEXT="&#x4e00;&#x4e2a;&#x4f7f;&#x7528;FFmpeg&#x5e93;&#x8bfb;&#x53d6;3gp&#x89c6;&#x9891;&#x7684;&#x4f8b;&#x5b50;"/>
<node CREATED="1409193506044" FOLDED="true" ID="ID_167584813" LINK="http://goo.gl/o0eoG3" MODIFIED="1428649722278" POSITION="left" TEXT="AndroidBitmapInfo">
<node CREATED="1409193665068" ID="ID_125153841" LINK="http://goo.gl/8pQ6Z0" MODIFIED="1409193680121" TEXT="Understanding Bitmap memory layout"/>
<node CREATED="1409290884893" ID="ID_510957770" LINK="http://goo.gl/SZ27WQ" MODIFIED="1409290911804" TEXT="AndroidBitmap_getInfo">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1409195741625" ID="ID_1185420062" LINK="http://goo.gl/Y3xfpN" MODIFIED="1409195815301" POSITION="left" TEXT="Creating a new Bitmap with Pixel Data in JNI?"/>
<node CREATED="1409290995890" ID="ID_19159939" LINK="http://goo.gl/9uasP2" MODIFIED="1409291009409" POSITION="left" TEXT="jni return bitmap"/>
<node CREATED="1356660113468" ID="ID_1614529909" MODIFIED="1436868799312" POSITION="right" TEXT="JNI">
<node CREATED="1357267190640" ID="ID_1716455924" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1357267244718" TEXT="you&apos;ll need to write some C/C++ code to export the functionality you need out of ffmpeg"/>
<node CREATED="1357267233671" ID="ID_1226138156" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1357267248515" TEXT=" into a library java can interact with through JNI. "/>
<node CREATED="1358496212203" FOLDED="true" ID="ID_1674236152" LINK="http://stackoverflow.com/questions/4274512/c-code-not-compiling-correctly" MODIFIED="1428649722279" TEXT="C code not compiling correctly">
<node CREATED="1358496228640" ID="ID_1743942421" MODIFIED="1358496239265" TEXT="c99 mode">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1362475680359" ID="ID_950794279" LINK="http://blog.csdn.net/passport01/article/details/7211187" MODIFIED="1362475692656" TEXT="layering">
<icon BUILTIN="info"/>
</node>
<node CREATED="1354677738089" FOLDED="true" ID="ID_405999991" MODIFIED="1428649722280" TEXT="JNI Graphics">
<node CREATED="1354677750980" ID="ID_858470875" LINK="http://stackoverflow.com/questions/5605853/what-is-jni-graphics-or-how-to-use-it" MODIFIED="1354677775214" TEXT="What is that?"/>
<node CREATED="1354677685714" ID="ID_7941812" LINK="http://stackoverflow.com/questions/5666513/what-is-the-best-method-to-render-video-frames" MODIFIED="1354677813074" TEXT="jnigraphics library exposed by the NDK"/>
<node CREATED="1354676180996" FOLDED="true" ID="ID_157692218" LINK="http://stackoverflow.com/questions/5666513/what-is-the-best-method-to-render-video-frames" MODIFIED="1428649722279" TEXT="What is the best method to render video frames?">
<icon BUILTIN="idea"/>
<node CREATED="1354676235527" ID="ID_61255397" MODIFIED="1354676237777" TEXT="a comment notes that OpenGL isn&apos;t the best method for rendering video"/>
<node CREATED="1354676302933" ID="ID_49188693" MODIFIED="1358135447453" TEXT="jnigraphics native library">
<icon BUILTIN="help"/>
</node>
<node CREATED="1354677066449" FOLDED="true" ID="ID_1893066726" MODIFIED="1428649722279" TEXT="color conversion">
<node CREATED="1354677104105" ID="ID_1737134433" LINK="http://stackoverflow.com/questions/5666513/what-is-the-best-method-to-render-video-frames" MODIFIED="1357044528196" TEXT="many have chosen to use software-decoding"/>
<node CREATED="1357044529560" ID="ID_939598375" MODIFIED="1357044536773" TEXT="combined with available CPU extensions"/>
<node CREATED="1357044537382" ID="ID_252807547" MODIFIED="1357044539108" TEXT="like NEON for color space conversion"/>
</node>
</node>
</node>
<node CREATED="1353152927756" ID="ID_842572169" LINK="http://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=2&amp;cad=rja&amp;ved=0CCkQFjAB&amp;url=http%3A%2F%2Fwww.windriver.com.cn%2Fmobile%2Fpdf%2F08_Android_Multimedia_Framework_Overview.pdf&amp;ei=EXmnUJ7ELMXkmAXkoYGgBQ&amp;usg=AFQjCNEY4ObK1Ng4sJ99Hemwnig3mHTC-Q&amp;sig2=9ckr3Dv9ciR_g-wiEgO2_w" MODIFIED="1353152969666" TEXT="invoke JNI to manipulate client"/>
<node CREATED="1375153553566" FOLDED="true" ID="ID_1132987144" MODIFIED="1428649722282" TEXT="vec.io">
<node CREATED="1356658802578" FOLDED="true" ID="ID_1113432705" LINK="http://vec.io/posts/how-to-render-image-buffer-in-android-ndk-native-code#toc-private-c-plus-plus-api" MODIFIED="1428649722282" TEXT="How to Render Image Buffer in Android NDK Native Code">
<node CREATED="1356658934171" ID="ID_1984101070" MODIFIED="1356658935671" TEXT="a general way to render native image pixels to Android Surface from NDK"/>
<node CREATED="1356658973390" ID="ID_1391324345" MODIFIED="1356658974937" TEXT="should work for all Android versions"/>
<node CREATED="1362835620288" FOLDED="true" ID="ID_179791090" MODIFIED="1428649722280" TEXT="Java Surface JNI">
<node CREATED="1356659016734" FOLDED="true" ID="ID_146825174" MODIFIED="1428649722280" TEXT="steps">
<node CREATED="1356659021015" ID="ID_696145722" MODIFIED="1356659031843" TEXT="create a ByteBuffer">
<icon BUILTIN="full-1"/>
</node>
<node CREATED="1356659054984" ID="ID_1427117485" MODIFIED="1356659057656" TEXT="pass its handle to native C code">
<icon BUILTIN="full-2"/>
</node>
<node CREATED="1356659087828" ID="ID_264826039" MODIFIED="1356659110296" TEXT="copy the pixels to the native ByteBuffer pointer">
<icon BUILTIN="full-3"/>
</node>
<node CREATED="1356659106500" ID="ID_174038830" MODIFIED="1356659112578" TEXT="invoke the Java method surfaceRender through JNI">
<icon BUILTIN="full-4"/>
</node>
</node>
<node CREATED="1356659321062" ID="ID_67951452" MODIFIED="1356659330906" TEXT="To render an 1280x720 RGB image, the JNI method only needs about 10ms">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1362835661374" FOLDED="true" ID="ID_1731958042" MODIFIED="1428649722280" TEXT="OpenGL ES 2 Texture">
<icon BUILTIN="help"/>
<node CREATED="1362835808931" ID="ID_1489346265" MODIFIED="1362835838604" TEXT="To render an 1280x720 YUV image,"/>
<node CREATED="1362835839858" ID="ID_1223037050" MODIFIED="1362835932020" TEXT="the OpenGL method will cost about 12ms,">
<icon BUILTIN="info"/>
</node>
<node CREATED="1362835854439" ID="ID_1439271480" MODIFIED="1362835856777" TEXT="the color space conversion time included!"/>
</node>
<node CREATED="1362835895998" FOLDED="true" ID="ID_1006508257" MODIFIED="1428649722281" TEXT="NDK ANativeWindow API">
<icon BUILTIN="help"/>
<node CREATED="1362835918973" ID="ID_564349722" MODIFIED="1362835924204" TEXT="To render an 1280x720 RGB image, the ANativeWindow API only cost about 7ms.">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1362835985151" FOLDED="true" ID="ID_1136990217" MODIFIED="1428649722282" TEXT="Private C++ API">
<node CREATED="1362836011248" ID="ID_1770720838" MODIFIED="1362836012664" TEXT="Android teams don&#x2019;t recommend"/>
<node CREATED="1362836037861" FOLDED="true" ID="ID_1139301119" MODIFIED="1428649722281" TEXT="many famous Apps have choosen this method">
<node CREATED="1362836058215" ID="ID_1496823066" MODIFIED="1362836059229" TEXT="Flash"/>
<node CREATED="1362836059794" ID="ID_303026267" MODIFIED="1362836062438" TEXT="Firefox"/>
<node CREATED="1362836062879" ID="ID_200253237" MODIFIED="1362836066696" TEXT="MXPlayer"/>
<node CREATED="1362836066995" ID="ID_1069133669" MODIFIED="1362836070662" TEXT="VPlayer"/>
<node CREATED="1362836079149" FOLDED="true" ID="ID_1798668171" MODIFIED="1428649722281" TEXT="VLC">
<node CREATED="1380067602096" ID="ID_1440999477" LINK="http://www.ptt.cc/bbs/AndroidDev/M.1380002786.A.C06.html" MODIFIED="1380067617323" TEXT="vlc&#x5728;android&#x7684;&#x5d4c;&#x5165;"/>
</node>
</node>
<node CREATED="1362836154482" ID="ID_374694932" MODIFIED="1362836158724" TEXT="The performance in this method is also the same as the ANativeWindow one.">
<icon BUILTIN="info"/>
</node>
</node>
</node>
</node>
<node CREATED="1370207752895" FOLDED="true" ID="ID_1682781213" MODIFIED="1428649722283" TEXT="wrapper">
<node CREATED="1354522241125" ID="ID_820664213" LINK="http://blog.moenyan.net/?p=18" MODIFIED="1354522258140" TEXT="Another JNI wrapper for libvlc on Android"/>
<node CREATED="1370207805698" ID="ID_940631390" LINK="#ID_971725817" MODIFIED="1370207903186" TEXT="NDK sampe - GL2JNI"/>
<node CREATED="1356597749156" FOLDED="true" ID="ID_267362082" LINK="https://github.com/xorange/Android-Video-Player-FFmpeg-and-Bitmap/blob/master/src/sysu/ss/xu/FFmpeg.java" MODIFIED="1428649722282" TEXT="Singleton">
<icon BUILTIN="info"/>
<node CREATED="1356597869984" ID="ID_1229117616" LINK="https://github.com/xorange/Android-Video-Player-FFmpeg-and-Bitmap/tree/master/libs/armeabi" MODIFIED="1356597881562" TEXT="libffmpeg.so"/>
<node CREATED="1357197894312" ID="ID_884292724" MODIFIED="1357197909625" TEXT="encapsulate ffmpeg as a class"/>
</node>
</node>
<node CREATED="1367215043718" ID="ID_1028228440" MODIFIED="1367215050078" TEXT="jmethodID">
<icon BUILTIN="help"/>
</node>
<node CREATED="1369381005046" FOLDED="true" ID="ID_328692672" MODIFIED="1428649722283" TEXT="RegisterNatives">
<node CREATED="1369380969390" ID="ID_156521999" LINK="http://stackoverflow.com/questions/1010645/what-does-the-registernatives-method-do" MODIFIED="1369380982406" TEXT="What does the registerNatives() method do?"/>
<node CREATED="1369381080437" ID="ID_197354526" MODIFIED="1369381082062" TEXT="you can name your C functions whatever you want"/>
<node CREATED="1369381127328" FOLDED="true" ID="ID_710804826" MODIFIED="1428649722283" TEXT="I encourage everybody to read the JNI book">
<node CREATED="1369381297375" ID="ID_1134488990" LINK="http://www.informit.com/store/java-native-interface-programmers-guide-and-specification-9780201325775" MODIFIED="1369381302484" TEXT="info"/>
<node CREATED="1369381213468" ID="ID_1132256906" LINK="http://www.soi.city.ac.uk/~kloukin/IN2P3/material/jni.pdf" MODIFIED="1369381281140" TEXT="Java&#x2122; Native Interface: Programmer&apos;s Guide and Specification"/>
</node>
<node CREATED="1369643446687" ID="ID_405869821" LINK="http://huenlil.pixnet.net/blog/post/23802146-%5B%E8%BD%89%5Djni%E8%88%87android-vm%E4%B9%8B%E9%97%9C%E4%BF%82" MODIFIED="1369643462843" TEXT="registerNativeMethods()&#x51fd;&#x6578;&#x4e4b;&#x7528;&#x9014;"/>
</node>
<node CREATED="1369633501937" ID="ID_1403437652" MODIFIED="1369633508937" TEXT="types"/>
<node CREATED="1369633653671" FOLDED="true" ID="ID_1423693273" MODIFIED="1428649722284" TEXT="AttachCurrentThread">
<node CREATED="1369633690546" ID="ID_347140071" MODIFIED="1369633692359" TEXT="&#x8981;&#x60f3;&#x4f7f;&#x7528;&#x5f53;&#x524d;&#x7ebf;&#x7a0b;&#x7684;JNIEnv"/>
</node>
<node CREATED="1369633663734" ID="ID_1722139822" MODIFIED="1369633665640" TEXT="DetachCurrentThread"/>
<node CREATED="1373987453484" ID="ID_1378270764" LINK="https://github.com/halfninja/android-ffmpeg-x264/blob/master/Project/jni/videokit/uk_co_halfninja_videokit_Videokit.c" MODIFIED="1373987486071" TEXT="JNI_OnLoad example"/>
<node CREATED="1376288479679" ID="ID_786713623" LINK="http://xyplot.com/jni.simple.htm" MODIFIED="1376288494989" TEXT="Hello World! Simple Example"/>
<node CREATED="1369380995015" FOLDED="true" ID="ID_1779090260" MODIFIED="1428649722284" TEXT="JNINativeMethod">
<node CREATED="1409196189397" ID="ID_1314668215" LINK="http://goo.gl/80wDtK" MODIFIED="1409196201490" TEXT="Android JNI &#x4f7f;&#x7528;&#x7684;&#x6570;&#x636e;&#x7ed3;&#x6784;JNINativeMethod&#x8be6;&#x89e3;"/>
</node>
<node CREATED="1474423901376" ID="ID_1919017540" LINK="https://goo.gl/r49QYK" MODIFIED="1474423918308" TEXT="Is it required to keep some ordering of primitives and objects in JNI function arguments"/>
</node>
<node CREATED="1412081898134" FOLDED="true" ID="ID_1454344663" LINK="http://goo.gl/rvoPlO" MODIFIED="1428649722285" POSITION="right" TEXT="JNA">
<icon BUILTIN="help"/>
<node CREATED="1412083252998" ID="ID_1456391370" LINK="http://goo.gl/ydZabv" MODIFIED="1412083280106" TEXT="loads system standard libraries"/>
<node CREATED="1412083268540" ID="ID_903243030" LINK="http://goo.gl/ydZabv" MODIFIED="1412083283727" TEXT="can make calls into them with very little effort on your part"/>
<node CREATED="1412083454503" FOLDED="true" ID="ID_1441313497" MODIFIED="1428649722285" TEXT="only downside is performance">
<node CREATED="1412083498854" ID="ID_1078032388" MODIFIED="1412083499695" TEXT="call overhead is only two or three times worse than JNI"/>
</node>
<node CREATED="1412083803841" FOLDED="true" ID="ID_394337196" LINK="http://goo.gl/4kkyDL" MODIFIED="1428649722285" TEXT="JNAerator">
<node CREATED="1412083833954" ID="ID_1341688487" LINK="http://goo.gl/ydZabv" MODIFIED="1412083849703" TEXT="automatically generate JNA definitions for JNA"/>
</node>
</node>
<node CREATED="1412083708469" ID="ID_817082597" LINK="../programming.mm#ID_1811741999" MODIFIED="1412560516765" POSITION="right" TEXT="SWIG">
<icon BUILTIN="help"/>
</node>
<node CREATED="1436868898615" ID="ID_1385910521" LINK="http://goo.gl/ajClWb" MODIFIED="1436868913701" POSITION="right" TEXT="How to get sent string from java code to native C in Android">
<node CREATED="1436868804783" ID="ID_862838751" LINK="http://goo.gl/sywte3" MODIFIED="1436868825229" TEXT="Always use javah to generate the headers so you don&apos;t have any mistakes."/>
</node>
<node CREATED="1436869055759" ID="ID_1851227860" LINK="http://goo.gl/pJrDhE" MODIFIED="1436869171865" POSITION="right" TEXT="It is different to using the &apos;javah&apos; tool as SWIG will wrap existing C/C++ code">
<node CREATED="1436869084511" ID="ID_1493914885" MODIFIED="1436869085766" TEXT="javah takes &apos;native&apos; Java function declarations and creates C/C++ function prototypes."/>
<node CREATED="1436869123767" ID="ID_1688423147" MODIFIED="1436869138050" TEXT="SWIG wraps C/C++ code using Java proxy classes">
<node CREATED="1436869139223" ID="ID_415909205" MODIFIED="1436869140021" TEXT=" and is very useful if you want to have access to large amounts of C/C++ code from Java."/>
</node>
</node>
<node CREATED="1412740038761" ID="ID_1898007659" LINK="http://goo.gl/qHC4Fq" MODIFIED="1412740074786" POSITION="right" TEXT="Debugging Android JNI with CheckJNI"/>
<node CREATED="1416304339493" ID="ID_805834298" LINK="http://goo.gl/LDozA7" MODIFIED="1416304359915" POSITION="right" TEXT="Utilities for C/C++ Android Developers: fplutil 1.0"/>
<node CREATED="1418696868661" ID="ID_1848248386" MODIFIED="1418696874632" POSITION="right" TEXT="for fun">
<icon BUILTIN="help"/>
</node>
</node>
</map>

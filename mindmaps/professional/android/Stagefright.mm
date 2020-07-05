<map version="1.0.1">
<!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
<node CREATED="1353662401218" ID="ID_1239659958" LINK="android.mm" MODIFIED="1376141711399" TEXT="Stagefright">
<node CREATED="1356654418916" FOLDED="true" ID="ID_1255489437" MODIFIED="1412246885897" POSITION="right" TEXT="overview">
<node CREATED="1354692208093" LINK="http://iamkcspa.pixnet.net/blog/post/39381174-stagefright-(1)---video-playback%E7%9A%84%E6%B5%81%E7%A8%8B" MODIFIED="1354692229015" TEXT="&#x5f9e;Android2.3 (Gingerbread) &#x958b;&#x59cb;&#xff0c;&#x9810;&#x8a2d;&#x7684;&#x591a;&#x5a92;&#x9ad4;&#x6846;&#x67b6;"/>
<node CREATED="1356654345615" ID="ID_1234569640" LINK="http://iamkcspa.pixnet.net/blog/post/39381174-stagefright-(1)---video-playback%E7%9A%84%E6%B5%81%E7%A8%8B" MODIFIED="1356654363789" TEXT="Stagefright&#x7684;&#x67b6;&#x69cb;&#x5c1a;&#x4e0d;&#x65b7;&#x5728;&#x6f14;&#x9032;&#x4e2d;"/>
<node CREATED="1356932068581" FOLDED="true" ID="ID_263821991" LINK="http://ffmpeg.org/pipermail/ffmpeg-devel/2012-May/124566.html" MODIFIED="1412232243779" TEXT="is a wrapper over the iomx/omx layer in android.">
<node CREATED="1358145547234" ID="ID_363771910" MODIFIED="1369376785281" TEXT="The actual codec implementation in this layer"/>
<node CREATED="1376214445745" ID="ID_52255203" MODIFIED="1376214446559" TEXT=" can be either in software (as in emulators) "/>
<node CREATED="1358145570500" ID="ID_1790334552" MODIFIED="1376214444282" TEXT="or hardware (most devices)."/>
</node>
<node CREATED="1356616666216" FOLDED="true" ID="ID_1936480781" LINK="http://vec.io/tags/ffmpeg" MODIFIED="1412232250315" TEXT="Android API dosen&apos;t expose interface to the device&apos;s hardware decoding module">
<node CREATED="1356616693196" MODIFIED="1356616710487" TEXT="but the OS does have a beautiful private library called stagefright"/>
<node CREATED="1356616729544" MODIFIED="1356616731329" TEXT="which encapsulates elegant hardware accelerated decoding &amp; encoding API"/>
<node CREATED="1356616743253" ID="ID_1606971985" MODIFIED="1356616745041" TEXT="which can be used accompanied with FFmpeg or GStreamer"/>
<node CREATED="1369374792593" ID="ID_157471293" MODIFIED="1409392039157" TEXT="android:hardwareAccelerated">
<node CREATED="1369374823750" MODIFIED="1369374825593" TEXT=" The default value is &quot;true&quot;"/>
<node CREATED="1369374734031" LINK="http://developer.android.com/guide/topics/manifest/application-element.html#hwaccel" MODIFIED="1369374822968" TEXT="if you&apos;ve set either minSdkVersion or targetSdkVersion to &quot;14&quot; or higher">
<font NAME="SansSerif" SIZE="12"/>
</node>
</node>
</node>
<node CREATED="1356928310844" FOLDED="true" ID="ID_486023189" LINK="http://freepine.blogspot.tw/2010/01/overview-of-stagefrighter-player.html" MODIFIED="1412232265227" TEXT="An overview of Stagefright player">
<node CREATED="1356929151156" ID="ID_961933155" MODIFIED="1409392050212" TEXT=" how to leverage this framework">
<icon BUILTIN="info"/>
<node CREATED="1356929169433" MODIFIED="1356929171550" TEXT=" adding a new codec?"/>
<node CREATED="1356929338272" ID="ID_33950446" MODIFIED="1356929340349" TEXT="add my own codec while compiling android source."/>
<node CREATED="1356929389239" ID="ID_1684052340" MODIFIED="1356929392453" TEXT="own openMAX compliant codec"/>
</node>
<node CREATED="1356929080116" ID="ID_1625334525" MODIFIED="1358388973921" TEXT="Google decided to push Stagefright as the default engine for local&amp;http playback">
<icon BUILTIN="info"/>
</node>
<node CREATED="1356929251489" ID="ID_234683639" MODIFIED="1362836428095" TEXT="change various places in OMXCodec.cpp">
<icon BUILTIN="help"/>
</node>
<node CREATED="1356929217465" ID="ID_1895028592" MODIFIED="1356929222494" TEXT=" add code for retrieving the track from the corresponding MediaExtractor"/>
<node CREATED="1376237158362" ID="ID_349113965" LINK="http://2.bp.blogspot.com/_QB83bh_YCwU/S0G5-sigfRI/AAAAAAAAABk/5ee0fijMFXs/s1600/StageFrighter+overview.bmp" MODIFIED="1376237167500" TEXT="chart"/>
<node CREATED="1376272617125" ID="ID_1741413329" LINK="http://techandcrack.com/uml-class-diagram-arrows" MODIFIED="1376272648698" TEXT="UML Class Diagram arrows"/>
</node>
<node CREATED="1360931251248" ID="ID_624688683" LINK="http://androidxref.com/4.0.4/xref/frameworks/base/include/media/stagefright/" MODIFIED="1362833697784" TEXT="/frameworks/base/include/media/stagefright/"/>
<node CREATED="1354587851562" ID="ID_1033688283" LINK="http://developer.android.com/training/graphics/opengl/index.html" MODIFIED="1376278766275" TEXT=" OpenGL ES APIs"/>
<node CREATED="1409392345332" ID="ID_310221241" LINK="http://goo.gl/EhZhnt" MODIFIED="1409392367433" TEXT="best method to render video frames?">
<node CREATED="1409392245546" ID="ID_606372944" MODIFIED="1409392391502" TEXT="a comment notes"/>
<node CREATED="1354676282667" ID="ID_1007182945" LINK="http://stackoverflow.com/questions/5666513/what-is-the-best-method-to-render-video-frames" MODIFIED="1409392244161" TEXT="that OpenGL isn&apos;t the best method for rendering video"/>
</node>
<node CREATED="1354407575286" FOLDED="true" ID="ID_650632771" MODIFIED="1412246885895" TEXT="codec">
<node CREATED="1354407584335" ID="ID_1039792442" MODIFIED="1409392418743" TEXT="support">
<node CREATED="1354407849033" LINK="http://stackoverflow.com/questions/6309931/android-dev-3rd-party-media-player-sdks-or-other-options" MODIFIED="1354407922165" TEXT="All you have is the default codecs."/>
<node CREATED="1357015524162" ID="ID_1007590154" LINK="http://comments.gmane.org/gmane.comp.video.ffmpeg.devel/144570" MODIFIED="1357015541309" TEXT="can support software (Google implement AVC, MPEG4, VP8, AAC, MP3, etc)"/>
<node CREATED="1357015559422" ID="ID_1010561748" MODIFIED="1357015561264" TEXT="and hardware decoder (some IC Vendors implement HW decoder core, TI, ST, etc.)"/>
</node>
<node CREATED="1354407592291" MODIFIED="1354407594746" TEXT="detect"/>
<node CREATED="1354407595436" ID="ID_1216020425" MODIFIED="1409392433926" TEXT="toggle">
<node CREATED="1354407868176" LINK="http://stackoverflow.com/questions/6309931/android-dev-3rd-party-media-player-sdks-or-other-options" MODIFIED="1354407916904" TEXT=" You can&apos;t &quot;toggle&quot; anything."/>
<node CREATED="1354412483994" ID="ID_1650363218" LINK="http://stackoverflow.com/questions/11321825/how-to-use-hardware-accelerated-video-decoding-on-android" MODIFIED="1409392437102" TEXT="MediaCodec">
<node CREATED="1354412509410" MODIFIED="1354412513339" TEXT="4.0"/>
<node CREATED="1354412514197" FOLDED="true" MODIFIED="1376031857281" TEXT="4.1">
<node CREATED="1354412590881" LINK="http://stackoverflow.com/questions/11321825/how-to-use-hardware-accelerated-video-decoding-on-android" MODIFIED="1354412608701" TEXT="Android seems to provide access to hardware accelerated decoders at application level"/>
</node>
<node CREATED="1354412771818" ID="ID_139033882" LINK="http://developer.android.com/reference/android/media/MediaCodec.html" MODIFIED="1354412784317" TEXT="MediaCodec class"/>
</node>
</node>
<node CREATED="1354675792105" ID="ID_977787265" MODIFIED="1409392445836" TEXT="software">
<node CREATED="1354675804824" MODIFIED="1354675806386" TEXT="NEON"/>
</node>
<node CREATED="1354675797324" MODIFIED="1354675803574" TEXT="hardware"/>
<node CREATED="1358374134289" ID="ID_1409060266" LINK="http://vec.io/tags/openmax" MODIFIED="1409392449828" TEXT="Android Hardware Decoding with MediaCodec">
<node CREATED="1358374183950" ID="ID_1012537349" MODIFIED="1409392460637" TEXT="new Android version 4.2 has been released,">
<node CREATED="1358374095725" LINK="https://developers.google.com/events/io/sessions/gooio2012/117/" MODIFIED="1358374115671" TEXT="New Low-Level Media APIs in Android"/>
</node>
<node CREATED="1409392461233" ID="ID_1341780628" MODIFIED="1409392461986" TEXT=" those low-level APIs are still too hard to use."/>
</node>
</node>
</node>
<node CREATED="1411642001874" ID="ID_367590006" MODIFIED="1411642002721" POSITION="left" TEXT="UNDERSTANDING ANDROID STAGEFRIGHT INTERNALS">
<node CREATED="1411641822402" ID="ID_1283183413" LINK="http://goo.gl/5x5kKE" MODIFIED="1411641834592" TEXT=" Take form of a binder service"/>
<node CREATED="1411641975618" ID="ID_286689428" LINK="http://goo.gl/pk4RRx" MODIFIED="1411641990081" TEXT="present in a reactor pattern in concurrent computing"/>
</node>
<node CREATED="1354586628656" FOLDED="true" ID="ID_162681295" LINK="http://elinux.org/images/5/52/Elc2011_garcia.pdf" MODIFIED="1412246884170" POSITION="left" TEXT="integration">
<node CREATED="1376279679144" ID="ID_1308740951" LINK="http://stackoverflow.com/questions/15356629/how-to-create-a-stagefright-plugin" MODIFIED="1376279695470" TEXT="The integration of codecs is different across different releases of Android."/>
<node CREATED="1354587271296" ID="ID_384791502" LINK="http://stackoverflow.com/questions/6779741/decoding-and-rendering-video-on-android" MODIFIED="1376214492875" TEXT="does not seem trivial"/>
<node CREATED="1354587257171" ID="ID_1281935126" MODIFIED="1376214555055" TEXT="or using FFMPEG player instead of stagefright"/>
<node CREATED="1354587231750" ID="ID_1049508439" MODIFIED="1376214558713" TEXT="Using FFMPEG components in stagefright"/>
<node CREATED="1372722897523" ID="ID_203759113" MODIFIED="1410914430505" TEXT="into stagefright">
<node CREATED="1356928529541" FOLDED="true" ID="ID_1049744253" LINK="http://blog.csdn.net/woker/article/details/7631834" MODIFIED="1376141776996" TEXT="Android 2.3&#x7528;ffmpeg&#x66ff;&#x4ee3;stagefright&#x81ea;&#x5e26;&#x7684;swdecoders">
<node CREATED="1358145283406" ID="ID_1366815567" LINK="http://blog.csdn.net/woker/article/details/7631834" MODIFIED="1358145300656" TEXT="&#x5199;&#x4e2a;ffdecoder, &#x5728;stagefright&#x4e2d;&#x8c03;&#x7528;ffmpeg"/>
<node CREATED="1358145409718" ID="ID_991346990" MODIFIED="1358145428078" TEXT="   ffmpeg&#x653e;&#x5165;stagefright&#x540e;&#x592a;&#x5927;">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1356928792157" FOLDED="true" ID="ID_1662440087" LINK="http://blog.sina.com.cn/s/blog_8bca26940100v757.html" MODIFIED="1376141789777" TEXT="&#x628a;ffmpeg&#x7684;&#x89e3;&#x7801;&#x5668;&#x52a0;&#x5165;&#x5230;stagefright&#x4e2d;">
<node CREATED="1360121292031" ID="ID_1773537204" MODIFIED="1360121294093" TEXT="stagefright&#x81ea;&#x5e26;&#x7684;&#x89e3;&#x7801;&#x5668;&#x592a;&#x5c11;"/>
<node CREATED="1360121330296" ID="ID_665944864" LINK="http://blog.sina.com.cn/s/blog_8bca26940100v757.html" MODIFIED="1360121353515" TEXT="stagefright&#x7684;&#x6846;&#x67b6;&#x63a5;&#x53e3;&#x5199;&#x7684;&#x771f;&#x4e0d;&#x9519;&#xff0c;&#x6dfb;&#x52a0;&#x8282;&#x70b9;&#x5f88;&#x65b9;&#x4fbf;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1360121391781" ID="ID_1452804965" MODIFIED="1360121395796" TEXT="&#x6d4b;&#x8bd5;&#x540e;&#x53d1;&#x73b0;ffh264&#x6bd4; android&#x81ea;&#x5e26;&#x7684;h264&#x8f6f;&#x89e3;&#x7801;&#x6548;&#x7387;&#x9ad8;10%&#x5de6;&#x53f3;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1356928761372" FOLDED="true" ID="ID_279538031" MODIFIED="1376031859453" TEXT="&#x7528;ndk&#x7f16;&#x8bd1;ffmpeg,&#x7136;&#x540e;&#x518d;&#x81ea;&#x5df1;&#x5199;jni&#x7a0b;&#x5e8f;&#x8c03;&#x7528;ndk ffmpeg">
<node CREATED="1357015706912" FOLDED="true" ID="ID_312308251" LINK="http://stackoverflow.com/questions/11312465/can-i-just-use-the-libraries-from-ffmpeg-in-an-android-app" MODIFIED="1376031858312" TEXT="Can I just use the libraries from FFmpeg in an Android app?">
<node CREATED="1357016019784" ID="ID_1862711439" LINK="http://code.google.com/p/android-fplayer/source/browse/trunk/src/cz/havlena/?r=2#havlena%2Fffmpeg%2Fui%253Fstate%253Dclosed" MODIFIED="1357016053449" TEXT="android-fplayer">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1357024217326" FOLDED="true" ID="ID_851071432" LINK="http://stackoverflow.com/questions/11207101/android-what-should-i-use-when-making-a-native-video-player" MODIFIED="1376031858312" TEXT="the performance of this method is not good">
<icon BUILTIN="help"/>
<icon BUILTIN="info"/>
<node CREATED="1357024306118" ID="ID_856293010" MODIFIED="1357024309634" TEXT="whether there is anything else that I could use to display frames other then passing to java?"/>
<node CREATED="1357024334803" ID="ID_1760658708" MODIFIED="1357024337303" TEXT=" just display the result via OpenGL ES 2"/>
<node CREATED="1357024348768" FOLDED="true" ID="ID_1910659458" LINK="http://stackoverflow.com/questions/11207101/android-what-should-i-use-when-making-a-native-video-player" MODIFIED="1376031858218" TEXT="using render-to-texture">
<node CREATED="1357024518522" ID="ID_541040888" LINK="http://www.gamedev.net/topic/570295-opengl-and-xvidtheoraanything" MODIFIED="1357024543353" TEXT="example"/>
</node>
<node CREATED="1357024505203" ID="ID_1335228501" MODIFIED="1357024507925" TEXT="For audio you can use OpenAL"/>
</node>
<node CREATED="1357025919732" FOLDED="true" ID="ID_1125233916" LINK="http://stackoverflow.com/questions/8180884/ffmpeg-with-neon-optimization" MODIFIED="1376031858312" TEXT="The performace is very low.">
<icon BUILTIN="info"/>
<node CREATED="1358145869343" ID="ID_1444152835" LINK="http://stackoverflow.com/questions/8180884/ffmpeg-with-neon-optimization" MODIFIED="1358145899578" TEXT="Inspite of adding the neon related commands in the config file"/>
<node CREATED="1358145882156" ID="ID_842268541" LINK="http://stackoverflow.com/questions/8180884/ffmpeg-with-neon-optimization" MODIFIED="1358146906625" TEXT="I don&apos;t see performance gain">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1357628531250" FOLDED="true" ID="ID_1239152480" LINK="http://blog.csdn.net/scut1135/article/details/6537258" MODIFIED="1376031858312" TEXT="&#x5728;&#x6211;&#x7684;10&#x5bf8;&#x5c4f;&#x4e0a;&#xff0c;&#x64ad;&#x653e;&#x9ad8;&#x6e05;&#xff0c;&#x7b80;&#x76f4;&#x662f;&#x707e;&#x96be;&#xff0c;&#x56fe;&#x50cf;&#x5f88;&#x5361;">
<node CREATED="1358146226515" ID="ID_608563232" MODIFIED="1358146228390" TEXT="&#x6211;&#x7684;android2.2"/>
<node CREATED="1358146159609" ID="ID_1887807553" MODIFIED="1358146162515" TEXT="Ffmpeg&#x89e3;&#x7801;&#x51fa;&#x6765;&#x662f;YUV420P&#x7684;&#x683c;&#x5f0f;&#x6570;&#x636e;"/>
<node CREATED="1358146261609" ID="ID_450474746" MODIFIED="1358146263500" TEXT="&#x5176;Surface&#x53e5;&#x67c4;&#x4f20;&#x9012;&#x7ed9;C&#x4ee3;&#x7801;&#x5c42;"/>
<node CREATED="1357628566718" ID="ID_1059501481" LINK="http://blog.csdn.net/scut1135/article/details/6537258" MODIFIED="1357628579156" TEXT="&#x8f6f;&#x4ef6;&#x89e3;&#x7801;&#xff0c;&#x53ea;&#x80fd;&#x9002;&#x5408;&#x4f4e;&#x5206;&#x8fa8;&#x7387;&#xff0c;&#x5c0f;&#x5c4f;&#x5e55;&#x7684;&#x4ea7;&#x54c1;&#x3002;"/>
</node>
</node>
<node CREATED="1356928785387" FOLDED="true" ID="ID_230401955" MODIFIED="1376031859453" TEXT="&#x628a;ffmpeg&#x76f4;&#x63a5;&#x52a0;&#x5165;stagefright&#x6846;&#x67b6;&#x4e2d;">
<icon BUILTIN="idea"/>
<node CREATED="1356928937473" ID="ID_1594959697" MODIFIED="1358145652562" TEXT="&#x754c;&#x9762;&#x5199;&#x4e00;&#x6b21;&#x5c31;&#x53ef;&#x4ee5;&#x4e00;&#x76f4;&#x7528;&#x4e0b;&#x53bb;.">
<icon BUILTIN="help"/>
</node>
<node CREATED="1358331496957" FOLDED="true" ID="ID_1151941114" LINK="https://groups.google.com/forum/m/#!msg/android-platform/PWr35yKsuRM/Cw6ogqT2kYQJ" MODIFIED="1376031858312" TEXT=" How to create codec using ffmpeg android">
<node CREATED="1358146543265" FOLDED="true" ID="ID_446107110" LINK="https://github.com/Unhelpful/ffmpeg/tree/android/doc" MODIFIED="1376031858218" TEXT="Unhelpful / ffmpeg">
<node CREATED="1358146578656" ID="ID_913895685" LINK="https://groups.google.com/forum/m/#!msg/android-platform/PWr35yKsuRM/Cw6ogqT2kYQJ" MODIFIED="1358146635140" TEXT="Take a look at the android branch of ffmpeg by Unhelpful."/>
<node CREATED="1358146597593" FOLDED="true" ID="ID_118512484" LINK="https://groups.google.com/forum/m/#!msg/android-platform/PWr35yKsuRM/Cw6ogqT2kYQJ" MODIFIED="1376031858125" TEXT="He looks like he&apos;s working on porting ffmpeg as a standard set of codecs">
<icon BUILTIN="info"/>
<node CREATED="1358146611656" ID="ID_278742312" MODIFIED="1358146614406" TEXT="that can be included with Android for when hardware support is lacking."/>
</node>
</node>
<node CREATED="1358331600489" ID="ID_835091766" MODIFIED="1358331602004" TEXT="i added ffmpegextractor class similar to MPEG4Extractor class "/>
<node CREATED="1358331613082" ID="ID_542018137" MODIFIED="1358331614520" TEXT=" which can demux any video format in stagefright using ffmpeg libavformat api "/>
<node CREATED="1358331625942" ID="ID_478991640" LINK="https://groups.google.com/forum/m/#!msg/android-platform/PWr35yKsuRM/Cw6ogqT2kYQJ" MODIFIED="1358331638020" TEXT="and rest protocols of stagefright remains same http,rtsp and hardware decoder."/>
<node CREATED="1358331660004" ID="ID_1882888985" MODIFIED="1358331662192" TEXT=".in ffmpegExtractor how did you by passed read/seek in FFMPEG"/>
</node>
<node CREATED="1358146820765" ID="ID_998220735" LINK="https://groups.google.com/forum/m/#!msg/android-platform/PWr35yKsuRM/Cw6ogqT2kYQJ" MODIFIED="1358147048375" TEXT=" Linaro Android platform team is working on this">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1357111182209" ID="ID_452987716" LINK="http://stackoverflow.com/questions/8613436/how-to-use-ffmpeg-libavcodec-libstagefright" MODIFIED="1410914432092" TEXT="how to use ffmpeg/libavcodec/libstagefright">
<node CREATED="1365891888261" ID="ID_1858113916" LINK="https://github.com/appunite/AndroidFFmpeg" MODIFIED="1410914434432" TEXT="appunite / AndroidFFmpeg">
<icon BUILTIN="info"/>
<node CREATED="1366557537966" ID="ID_692708534" LINK="http://stackoverflow.com/questions/12419093/local-src-files-points-to-a-missing-file" MODIFIED="1366557564141" TEXT="LOCAL_SRC_FILES points to a missing file">
<icon BUILTIN="help"/>
</node>
<node CREATED="1366070740380" ID="ID_1825905694" MODIFIED="1366070746538" TEXT="FFmpegExample"/>
<node CREATED="1366070714971" ID="ID_1408841944" MODIFIED="1410914435641" TEXT="FFmpegLibrary">
<node CREATED="1369387131140" ID="ID_1129097637" LINK="https://code.google.com/p/android-native-egl-example/source/browse/jni/jniapi.cpp" MODIFIED="1369387149171" TEXT="Sample that shows how to do native rendering"/>
<node CREATED="1410914452294" ID="ID_829853056" LINK="#ID_855637781" MODIFIED="1410914458301" TEXT="OpenMAX and the NDK: Where I can get the surface?"/>
<node CREATED="1366070688180" FOLDED="true" ID="ID_1520982703" MODIFIED="1410916253137" TEXT="player.c">
<node CREATED="1369387111843" ID="ID_1049284175" MODIFIED="1369387115437" TEXT="trace/learn how decoded data were transmit to Surface">
<icon BUILTIN="yes"/>
</node>
<node CREATED="1366070668653" ID="ID_724322750" MODIFIED="1366070671560" TEXT="jni_player_init"/>
<node CREATED="1366688479546" ID="ID_1431471679" MODIFIED="1366688480937" TEXT="player_open_input"/>
<node CREATED="1366700382687" ID="ID_1718807936" MODIFIED="1366700386218" TEXT="player_decode_video"/>
<node CREATED="1366700400718" ID="ID_25643358" MODIFIED="1366700402390" TEXT="player_decode_audio"/>
<node CREATED="1369388090140" ID="ID_635492245" MODIFIED="1369388090765" TEXT="player_wait_for_frame"/>
<node CREATED="1369386956859" FOLDED="true" ID="ID_723533680" MODIFIED="1410916253134" TEXT="jni_player_render">
<node CREATED="1369387732687" ID="ID_1501788910" MODIFIED="1369387734812" TEXT="ANativeWindow_acquire"/>
</node>
<node CREATED="1369388499000" FOLDED="true" ID="ID_1956304712" MODIFIED="1376031858125" TEXT="player_start_decoding_threads">
<node CREATED="1369388561828" ID="ID_1990549306" MODIFIED="1369388564296" TEXT="player_decode"/>
<node CREATED="1369388048953" ID="ID_1947961755" MODIFIED="1369390187984" TEXT="player_read_from_stream">
<icon BUILTIN="yes"/>
</node>
</node>
</node>
</node>
</node>
<node CREATED="1369385162531" FOLDED="true" ID="ID_1432363691" MODIFIED="1376031859453" TEXT="Meta Data">
<node CREATED="1369385171031" ID="ID_71888240" MODIFIED="1369385174671" TEXT="sps"/>
<node CREATED="1369385175828" ID="ID_621284079" MODIFIED="1369385184031" TEXT="pps"/>
</node>
<node CREATED="1369385410140" ID="ID_516693468" MODIFIED="1369385412218" TEXT="How can I use libstagefright sucessfully in ffmpeg?"/>
<node CREATED="1369385520906" ID="ID_1392455748" LINK="http://stackoverflow.com/questions/8613436/how-to-use-ffmpeg-libavcodec-libstagefright" MODIFIED="1369385533796" TEXT="To use this library you have call standard ffmpeg methods"/>
<node CREATED="1369385545750" ID="ID_836271629" LINK="http://stackoverflow.com/questions/8613436/how-to-use-ffmpeg-libavcodec-libstagefright" MODIFIED="1369385559343" TEXT="and open insteed of standard h264 codec libstagefright_h264 codec"/>
<node CREATED="1369385849921" ID="ID_1962318627" MODIFIED="1369385850968" TEXT="avcodec_find_decoder_by_name"/>
</node>
<node CREATED="1365895624722" FOLDED="true" ID="ID_1832022353" MODIFIED="1376277246412" TEXT="register">
<node CREATED="1365896999530" ID="ID_525942090" LINK="http://stackoverflow.com/questions/8613436/how-to-use-ffmpeg-libavcodec-libstagefright" MODIFIED="1365897037039" TEXT="To use this library you have call standard ffmpeg methods and "/>
<node CREATED="1365897014160" ID="ID_606915976" MODIFIED="1365897016168" TEXT="open insteed of standard h264 codec libstagefright_h264 codec"/>
<node CREATED="1365902222201" ID="ID_387173949" LINK="http://stackoverflow.com/questions/8613436/how-to-use-ffmpeg-libavcodec-libstagefright" MODIFIED="1365902237228" TEXT="avcodec_find_decoder_by_name"/>
<node CREATED="1376143222371" ID="ID_1804411799" MODIFIED="1376143250366" TEXT="how &apos;ff_libstagefright_h264&apos;_decoder is registered?"/>
<node CREATED="1376143251332" ID="ID_1406133904" MODIFIED="1376143280681" TEXT="can be used by av_find_filter?"/>
<node CREATED="1375173549847" ID="ID_1350184391" LINK="http://code.metager.de/source/xref/ffmpeg/libavcodec/libstagefright.cpp" MODIFIED="1375173582904" TEXT="libstagefright.cpp"/>
</node>
<node CREATED="1357283911015" FOLDED="true" ID="ID_1047524235" LINK="http://stackoverflow.com/questions/10438978/linker-errors-when-trying-to-enable-ffmpeg-stagefright-support" MODIFIED="1376277248179" TEXT="Linker errors when trying to enable FFmpeg stagefright support">
<node CREATED="1357283573796" FOLDED="true" ID="ID_1076547398" MODIFIED="1376031859453" TEXT="ffmpeg/tools/build_stagefright.sh">
<arrowlink DESTINATION="ID_421042304" ENDARROW="Default" ENDINCLINATION="206;0;" ID="Arrow_ID_1130942731" STARTARROW="None" STARTINCLINATION="206;0;"/>
<node CREATED="1357283634437" ID="ID_540729446" LINK="http://stackoverflow.com/questions/10438978/linker-errors-when-trying-to-enable-ffmpeg-stagefright-support" MODIFIED="1357283647765" TEXT="if you wanna build it, you should follow the build instruction in ffmpeg"/>
</node>
<node CREATED="1362833193381" ID="ID_421042304" MODIFIED="1362833634710" TEXT="--enable-libstagefright-h264">
<linktarget COLOR="#b0b0b0" DESTINATION="ID_421042304" ENDARROW="Default" ENDINCLINATION="206;0;" ID="Arrow_ID_1130942731" SOURCE="ID_1076547398" STARTARROW="None" STARTINCLINATION="206;0;"/>
<linktarget COLOR="#b0b0b0" DESTINATION="ID_421042304" ENDARROW="Default" ENDINCLINATION="263;0;" ID="Arrow_ID_45452709" SOURCE="ID_950180640" STARTARROW="None" STARTINCLINATION="263;0;"/>
</node>
<node CREATED="1362834222190" ID="ID_1148216502" MODIFIED="1362834223362" TEXT="enable H.264 decoding via libstagefright"/>
<node CREATED="1357283559265" ID="ID_1437104792" LINK="http://stackoverflow.com/questions/10438978/linker-errors-when-trying-to-enable-ffmpeg-stagefright-support" MODIFIED="1357283614562" TEXT=" I don&apos;t recommend you use the libstagefright.cpp in ffmpeg"/>
<node CREATED="1362833475468" ID="ID_1442428336" MODIFIED="1362833587960" TEXT="you may try this configure">
<arrowlink DESTINATION="ID_1109542517" ENDARROW="Default" ENDINCLINATION="251;0;" ID="Arrow_ID_705803818" STARTARROW="None" STARTINCLINATION="251;0;"/>
</node>
</node>
<node CREATED="1357112290256" FOLDED="true" ID="ID_1369163895" LINK="http://stackoverflow.com/questions/9832503/android-include-native-stagefright-features-in-my-own-project" MODIFIED="1376031860406" TEXT="Include native StageFright features in my own project">
<node CREATED="1357112340318" ID="ID_1939683206" LINK="http://stackoverflow.com/questions/9832503/android-include-native-stagefright-features-in-my-own-project" MODIFIED="1363396814301" TEXT="stagefright is not exposed to NDK">
<icon BUILTIN="info"/>
</node>
<node CREATED="1357112368412" ID="ID_1915526122" MODIFIED="1357112369725" TEXT="so you will have to do extra work"/>
<node CREATED="1357112383553" FOLDED="true" ID="ID_954449859" MODIFIED="1376031859453" TEXT="There are two ways">
<node CREATED="1357112401397" FOLDED="true" ID="ID_1196336887" MODIFIED="1376031858312" TEXT="build your project using android full source tree">
<node CREATED="1363396919795" ID="ID_1414034720" MODIFIED="1363396921736" TEXT="takes a few days to setup"/>
<node CREATED="1363396936489" ID="ID_802922209" MODIFIED="1363396937963" TEXT="take full advantage"/>
</node>
<node CREATED="1357112421943" FOLDED="true" ID="ID_101354621" MODIFIED="1376031858312" TEXT="just copy include file to your project">
<node CREATED="1357112524412" ID="ID_204548944" MODIFIED="1357112527381" TEXT="When copying, beware that the JNI function is C and Stagefright is C++"/>
</node>
</node>
<node CREATED="1357112461537" ID="ID_305128937" MODIFIED="1357112463756" TEXT="To encode/decode using statgefright"/>
<node CREATED="1357112558615" ID="ID_152713757" MODIFIED="1357112561240" TEXT="Note that not all Android devices have stagefright"/>
<node CREATED="1363397139462" ID="ID_1994031191" LINK="http://stackoverflow.com/questions/9832503/android-include-native-stagefright-features-in-my-own-project" MODIFIED="1363397239420" TEXT="the following is a snippet"/>
</node>
<node CREATED="1364256983667" ID="ID_463814276" LINK="http://stackoverflow.com/questions/13798602/how-to-build-include-ffmpeg-into-an-existing-android-project" MODIFIED="1372734171065" TEXT="How to build + include FFMPEG into an existing Android project">
<icon BUILTIN="info"/>
</node>
<node CREATED="1357015156300" FOLDED="true" ID="ID_163670921" MODIFIED="1376031860406" TEXT="Why you doesn&apos;t add Android Stagefright library codec?">
<node CREATED="1357015108407" ID="ID_114759766" LINK="https://groups.google.com/forum/?fromgroups=#!topic/mx-videoplayer/lqokn61U9yE" MODIFIED="1357015193925" TEXT="all stagefright classes are unofficial and varies version by version"/>
</node>
</node>
<node CREATED="1376215536681" ID="ID_1785848617" MODIFIED="1376215538370" TEXT="Adding other video formats and codecs to stagefright"/>
<node CREATED="1365895614609" FOLDED="true" ID="ID_630268895" MODIFIED="1376279674538" TEXT="steps">
<node CREATED="1365895634918" ID="ID_1761179465" MODIFIED="1365895643766" TEXT="read/write"/>
<node CREATED="1365895644230" ID="ID_770970537" MODIFIED="1365895651983" TEXT="deallocate"/>
</node>
<node CREATED="1357265898265" ID="ID_413145887" MODIFIED="1410914470125" TEXT="trial">
<node CREATED="1357117995975" FOLDED="true" ID="ID_1021429433" MODIFIED="1410610605860" TEXT="program">
<node CREATED="1357118006568" FOLDED="true" ID="ID_1971829474" MODIFIED="1376031859453" TEXT="open socket at java side">
<node CREATED="1357118049022" ID="ID_83823919" MODIFIED="1357118062912" TEXT="pass data down to ffmpeg"/>
<node CREATED="1357118065162" ID="ID_10884117" MODIFIED="1357118071068" TEXT="less efficient"/>
</node>
<node CREATED="1357118019084" ID="ID_1891765858" MODIFIED="1357118045662" TEXT="open rtsp connection in native code with ffmpeg"/>
<node CREATED="1357788048562" ID="ID_1175733254" MODIFIED="1357788062281" TEXT="pass url down to ffmpeg">
<icon BUILTIN="button_ok"/>
</node>
<node CREATED="1358427277389" ID="ID_1768948351" LINK="http://stackoverflow.com/questions/9605757/using-ffmpeg-with-android-ndk" MODIFIED="1358427320791" TEXT="use ffmpeg via commandline"/>
<node CREATED="1357718675934" FOLDED="true" ID="ID_1588127871" MODIFIED="1376031859453" TEXT="Passing url to ffmpeg for opening RTSP connection">
<node CREATED="1357718680590" ID="ID_1871907213" MODIFIED="1357718691199" TEXT="same as activeX"/>
</node>
<node CREATED="1358121913125" ID="ID_55831851" MODIFIED="1360118647781" TEXT="in ffplay.c, replace SDL layer with android one">
<icon BUILTIN="idea"/>
</node>
</node>
<node CREATED="1354524152703" ID="ID_734578380" MODIFIED="1410914471655" TEXT="verify">
<node CREATED="1354524157390" FOLDED="true" ID="ID_1784483898" MODIFIED="1376031859453" TEXT="file">
<icon BUILTIN="button_ok"/>
<node CREATED="1354606854515" ID="ID_1527401469" MODIFIED="1354606865609" TEXT="how to deploy .so file">
<icon BUILTIN="help"/>
</node>
<node CREATED="1354524659015" ID="ID_1760882699" MODIFIED="1354524672046" TEXT="where to place libmylib.so">
<icon BUILTIN="help"/>
</node>
<node CREATED="1354610261843" ID="ID_1211523871" LINK="http://www.eclipse.org/forums/index.php/mv/tree/94766/#page_top" MODIFIED="1354610276718" TEXT="Remember to use System.loadLibrary(&quot;me&quot;) to load a library &apos;libme.so&apos; "/>
<node CREATED="1354611518562" FOLDED="true" ID="ID_1498706986" MODIFIED="1376031858312" TEXT="import .so file into eclipse project">
<node CREATED="1354613051390" ID="ID_1848408669" MODIFIED="1354613056656" TEXT="reinstall"/>
</node>
</node>
<node CREATED="1354524159500" ID="ID_1587989657" MODIFIED="1354524162578" TEXT="function"/>
<node CREATED="1354528145593" FOLDED="true" ID="ID_891198796" MODIFIED="1376031859453" TEXT="sample to test">
<node CREATED="1354528168203" ID="ID_653149889" LINK="http://support.apple.com/kb/HT1425" MODIFIED="1354528194109" TEXT="apple"/>
</node>
<node CREATED="1357283882562" ID="ID_1109542517" LINK="http://stackoverflow.com/questions/9098167/ffmpeg-android-stagefright-sigsegv-error-h264-decode" MODIFIED="1410914474454" TEXT="FFMpeg Android Stagefright SIGSEGV error (h264 decode)">
<linktarget COLOR="#b0b0b0" DESTINATION="ID_1109542517" ENDARROW="Default" ENDINCLINATION="251;0;" ID="Arrow_ID_705803818" SOURCE="ID_1442428336" STARTARROW="None" STARTINCLINATION="251;0;"/>
<node CREATED="1357285181062" ID="ID_452157782" LINK="http://stackoverflow.com/questions/9098167/ffmpeg-android-stagefright-sigsegv-error-h264-decode" MODIFIED="1357285236484" TEXT="As I understand I need to communicate with Stagefright"/>
<node CREATED="1357285207937" ID="ID_186789135" MODIFIED="1357285209171" TEXT="as it`s the only way now"/>
<node CREATED="1357285221031" ID="ID_66011472" MODIFIED="1357285222671" TEXT="after closing access with OpenMAX IL implementations"/>
<node CREATED="1357283862937" ID="ID_950180640" MODIFIED="1362833634710" TEXT="You enabled libstagefright-h264 in your ffmpeg configure flags">
<arrowlink DESTINATION="ID_421042304" ENDARROW="Default" ENDINCLINATION="263;0;" ID="Arrow_ID_45452709" STARTARROW="None" STARTINCLINATION="263;0;"/>
</node>
<node CREATED="1358373554558" ID="ID_1078465724" MODIFIED="1358373556050" TEXT="but didn&apos;t enable it as a decoder&#xfeff; as such"/>
</node>
</node>
</node>
<node CREATED="1369634368140" ID="ID_1802255920" LINK="http://stackoverflow.com/questions/4725773/ffmpeg-on-android" MODIFIED="1369634382484" TEXT="Here are the steps I went through in getting ffmpeg to work on Android"/>
<node CREATED="1354094323125" FOLDED="true" ID="ID_1722796708" MODIFIED="1410610619028" TEXT="checklist">
<node CREATED="1354094333656" ID="ID_1270096527" MODIFIED="1410600887758" TEXT="target">
<node CREATED="1354095980703" ID="ID_184521274" MODIFIED="1410600888854" TEXT="hardware">
<node CREATED="1354094358312" ID="ID_913209035" MODIFIED="1354094360062" TEXT="x86"/>
<node CREATED="1354094355500" ID="ID_343025918" MODIFIED="1354094357812" TEXT="arm"/>
</node>
<node CREATED="1354095905593" FOLDED="true" ID="ID_1184703295" MODIFIED="1376031859453" TEXT="android">
<node CREATED="1354096078156" ID="ID_1176869370" MODIFIED="1354096080062" TEXT="version"/>
<node CREATED="1354096080437" ID="ID_535613401" MODIFIED="1354096082765" TEXT="level"/>
</node>
</node>
<node CREATED="1354094350078" FOLDED="true" ID="ID_198869667" MODIFIED="1376031860406" TEXT="host">
<node CREATED="1354094362312" ID="ID_1429288928" MODIFIED="1354094366281" TEXT="ubuntu"/>
<node CREATED="1354094366828" FOLDED="true" ID="ID_1203241865" MODIFIED="1376031859453" TEXT="windows">
<node CREATED="1354094370906" ID="ID_1072779369" MODIFIED="1354094373843" TEXT="cygwin"/>
<node CREATED="1354172475515" FOLDED="true" ID="ID_1473557946" MODIFIED="1376031858312" TEXT="windows">
<node CREATED="1354172419140" ID="ID_572208972" LINK="http://stackoverflow.com/questions/11551742/ndk-build-error-with-cygwin" MODIFIED="1354172529625" TEXT="change it&apos;s premissions to full control"/>
</node>
</node>
</node>
<node CREATED="1354094405625" FOLDED="true" ID="ID_648470795" MODIFIED="1376031860406" TEXT="ndk">
<node CREATED="1354095289453" ID="ID_228203553" MODIFIED="1354095292562" TEXT="version"/>
<node CREATED="1354155117171" ID="ID_1433281289" MODIFIED="1354155124062" TEXT="toolchain"/>
</node>
<node CREATED="1354095282453" FOLDED="true" ID="ID_1240538929" MODIFIED="1376031860406" TEXT="ffmpeg">
<node CREATED="1354095294078" ID="ID_224851541" MODIFIED="1354095296796" TEXT="version"/>
</node>
</node>
<node CREATED="1357110556303" ID="ID_597544510" MODIFIED="1357110556303" TEXT="libbinder"/>
<node CREATED="1357110577584" ID="ID_1502039402" MODIFIED="1357110577584" TEXT="libutils"/>
<node CREATED="1357110591100" FOLDED="true" ID="ID_906964160" MODIFIED="1376236934481" TEXT="libmedia">
<node CREATED="1357110622334" ID="ID_1280068069" MODIFIED="1357110627912" TEXT="MediaPlayer"/>
</node>
<node CREATED="1361265626390" FOLDED="true" ID="ID_1256189022" MODIFIED="1412246884167" TEXT="STLport">
<node CREATED="1361265638359" FOLDED="true" ID="ID_1326255706" LINK="http://www.sunnyu.com/?p=205" MODIFIED="1376031858296" TEXT="&#x5728;ANDROID NDK &#x4e2d;&#x4f7f;&#x7528;STLPORT(&#x8bd1;)">
<node CREATED="1361266433734" MODIFIED="1361266441484" TEXT="ndk 1.5">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1410610477524" ID="ID_131108856" LINK="http://goo.gl/eNwLVp" MODIFIED="1410610497145" TEXT="ported ffmpeg&apos;s libavformat to Awesomeplayer as ffextractor">
<icon BUILTIN="help"/>
</node>
<node CREATED="1410610610403" ID="ID_980044410" MODIFIED="1410610618029" TEXT="ffextractor"/>
</node>
<node CREATED="1356929479173" FOLDED="true" ID="ID_301742206" MODIFIED="1376236441153" POSITION="left" TEXT="AVCDecoder">
<node CREATED="1356929487398" LINK="http://freepine.blogspot.tw/2010/01/overview-of-stagefrighter-player.html" MODIFIED="1356929504839" TEXT=" is a software codec"/>
</node>
<node CREATED="1357110473022" FOLDED="true" ID="ID_769685231" MODIFIED="1410609960880" POSITION="right" TEXT="structure">
<node CREATED="1356654382429" ID="ID_610004356" MODIFIED="1409988120683" TEXT="video">
<node CREATED="1356653917985" ID="ID_1370387559" LINK="http://stackoverflow.com/questions/6779741/decoding-and-rendering-video-on-android" MODIFIED="1409392545093" TEXT="Decoding and Rendering Video on Android">
<node CREATED="1356929125711" ID="ID_207159053" MODIFIED="1360202208031" TEXT=" which component is resposable for A/V sync in video playback?">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1354697939328" ID="ID_491803052" LINK="http://stackoverflow.com/questions/11321825/how-to-use-hardware-accelerated-video-decoding-on-android" MODIFIED="1354697953359" TEXT="How to use hardware accelerated video decoding on Android?"/>
<node CREATED="1354585332031" FOLDED="true" ID="ID_1374438974" MODIFIED="1409456143498" TEXT="handle decoded video frame">
<node CREATED="1354585361906" MODIFIED="1354585367593" TEXT="native side"/>
<node CREATED="1354585369640" MODIFIED="1354585378046" TEXT="java side"/>
<node CREATED="1354588189281" LINK="http://stackoverflow.com/questions/6779741/decoding-and-rendering-video-on-android" MODIFIED="1356655385765" TEXT=" Increasing buffer will definitely improve the performance"/>
<node CREATED="1354588248171" LINK="http://stackoverflow.com/questions/6779741/decoding-and-rendering-video-on-android" MODIFIED="1354588259562" TEXT="Can optimize or use opensource library to improve performance."/>
<node CREATED="1354588163296" MODIFIED="1354588164796" TEXT="YUV to RGB conversion"/>
<node CREATED="1354588141468" MODIFIED="1354588145343" TEXT="Usually Open GL is not used for Video Rendering"/>
</node>
<node CREATED="1354678407496" ID="ID_639046038" LINK="https://groups.google.com/forum/?fromgroups=#!topic/android-developers/dc3_5IaGH1A" MODIFIED="1354678425261" TEXT="Video rendering performance on android">
<icon BUILTIN="idea"/>
</node>
</node>
<node CREATED="1356654375249" FOLDED="true" ID="ID_108505" MODIFIED="1409988109007" TEXT="audio">
<node CREATED="1354588278093" LINK="http://stackoverflow.com/questions/6779741/decoding-and-rendering-video-on-android" MODIFIED="1354588289531" TEXT="Audio time is used as reference."/>
<node CREATED="1356590000312" ID="ID_1312542004" LINK="http://textopia.org/androidsoundformats.html" MODIFIED="1356590028437" TEXT="test of sound formats"/>
<node CREATED="1354772180156" ID="ID_1843576695" LINK="http://forum.xda-developers.com/showthread.php?t=737111" MODIFIED="1356654716214" TEXT="how to disable player temporarily"/>
<node CREATED="1362623646265" FOLDED="true" MODIFIED="1376031858203" TEXT="AudioFlinger">
<icon BUILTIN="help"/>
<node CREATED="1362623883156" FOLDED="true" LINK="http://fecbob.pixnet.net/blog/post/36115277-audiotrack%E8%88%87audioflinger%E4%BA%A4%E6%8F%9B%E9%9F%B3%E8%A8%8A%E8%B3%87%E6%96%99" MODIFIED="1376031858125" TEXT="AudioTrack&#x8207;AudioFlinger&#x4ea4;&#x63db;&#x97f3;&#x8a0a;&#x8cc7;&#x6599;">
<font NAME="SansSerif" SIZE="12"/>
<icon BUILTIN="info"/>
<node CREATED="1362623948984" MODIFIED="1362623951343" TEXT="&#x6211;&#x5011;&#x53ef;&#x4ee5;&#x9019;&#x6a23;&#x7406;&#x89e3;"/>
<node CREATED="1362623958109" MODIFIED="1362623958859" TEXT="AudioTrack&#x662f;FIFO&#x7684;&#x8cc7;&#x6599;&#x751f;&#x7522;&#x8005;"/>
<node CREATED="1362623969390" MODIFIED="1362623969984" TEXT="AudioFlinger&#x662f;FIFO&#x7684;&#x8cc7;&#x6599;&#x6d88;&#x8cbb;&#x8005;"/>
</node>
</node>
<node CREATED="1362624750250" ID="ID_253891796" LINK="http://fecbob.pixnet.net/blog/post/35994193-android-a2dp(%E8%BD%89%E8%BC%89)" MODIFIED="1409410308043" TEXT="Android A2DP(&#x8f49;&#x8f09;)">
<node CREATED="1362624811312" LINK="http://fecbob.pixnet.net/blog/post/35994193-android-a2dp(%E8%BD%89%E8%BC%89)" MODIFIED="1362624821000" TEXT="&#x672c;&#x6587;&#x7c21;&#x55ae;&#x4ecb;&#x7d39;&#x4e00;&#x4e0b;Android&#x97f3;&#x8a0a;&#x9069;&#x914d;&#x5c64;"/>
</node>
<node CREATED="1363141869968" MODIFIED="1363142089875" TEXT="AudioHardwareInterface">
<icon BUILTIN="help"/>
</node>
<node CREATED="1363142139375" MODIFIED="1363142142250" TEXT="AudioTrack">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1357698197328" FOLDED="true" ID="ID_922603989" MODIFIED="1376236512626" TEXT="RTSP">
<node CREATED="1357701612359" FOLDED="true" LINK="http://code.google.com/p/android/issues/detail?id=13715" MODIFIED="1376031858203" TEXT="RTSP playback does not work with 2.3 (Tried with Nexus S)">
<node CREATED="1357701616812" MODIFIED="1357701620281" TEXT="2.3.3"/>
</node>
<node CREATED="1357697863671" FOLDED="true" LINK="http://code.google.com/p/android/issues/detail?id=13715" MODIFIED="1376031858203" TEXT="The error checking and exception handling in the rtsp">
<node CREATED="1357697882468" MODIFIED="1357697884250" TEXT="is either non-existence or very very badly done"/>
</node>
<node CREATED="1357698204015" LINK="http://code.google.com/p/android/issues/detail?id=15229" MODIFIED="1357698226796" TEXT="No RTSP keep-alive packets in 2.3 causing streaming server to close the connection"/>
<node CREATED="1358142877687" LINK="http://fecbob.pixnet.net/blog/post/38383045" MODIFIED="1358142905468" TEXT="&#x8b93;android&#x652f;&#x63f4;RTSP&#x53ca;live555&#x5206;&#x6790;">
<icon BUILTIN="info"/>
</node>
</node>
</node>
<node CREATED="1376969440154" ID="ID_89658367" MODIFIED="1376969479614" POSITION="right" TEXT="&#x91cd;&#x65b0;&#x53d6;&#x5f97;libmedia.so&#x5728;4.3&#x7684;symbol&#x4f5c;mapping"/>
<node CREATED="1407116833935" ID="ID_526647572" LINK="http://goo.gl/4HvF82" MODIFIED="1407116948635" POSITION="right" TEXT="Access StageFright.so directly to decode H.264 stream from JNIlayer in Android">
<icon BUILTIN="info"/>
<node CREATED="1407116928889" ID="ID_1078612590" MODIFIED="1407116932575" TEXT="AwesomePlayer"/>
<node CREATED="1409413317437" ID="ID_10639247" MODIFIED="1409413318263" TEXT="The main challenges"/>
<node CREATED="1407116881873" ID="ID_452374154" MODIFIED="1407116883104" TEXT="stagefright command line"/>
</node>
<node CREATED="1407116898257" ID="ID_1175254515" MODIFIED="1407116899024" POSITION="right" TEXT="SimplePlayer"/>
<node CREATED="1407116950481" ID="ID_1310513081" MODIFIED="1407116959475" POSITION="right" TEXT="performance">
<icon BUILTIN="help"/>
</node>
<node CREATED="1354410649206" FOLDED="true" ID="ID_317198920" LINK="http://androidxref.com/4.2_r1/xref/frameworks/av/media/libmediaplayerservice/nuplayer/NuPlayer.h" MODIFIED="1407116758588" POSITION="left" TEXT="NuPlayer">
<node CREATED="1354410656441" LINK="http://freepine.blogspot.tw/2011/05/nuplayer-for-http-live-streaming.html" MODIFIED="1356653700775" TEXT="NuPlayer for HTTP live streaming"/>
<node CREATED="1354410716351" LINK="http://blog.csdn.net/ameyume/article/details/7359829" MODIFIED="1356653683647" TEXT="ICS4.0.3&#x521b;&#x5efa;NuPlayer&#x7684;&#x5904;&#x7406;&#x6d41;&#x7a0b;"/>
<node CREATED="1354771568578" ID="ID_1310391895" LINK="http://blog.csdn.net/ameyume/article/details/7387949" MODIFIED="1354771652390" TEXT="rtsp&#x6d41;&#x5a92;&#x4f53;buffer&#x586b;&#x5145;&#x7684;&#x5904;&#x7406;&#x8fc7;&#x7a0b;"/>
<node CREATED="1376535438069" ID="ID_769894550" LINK="http://diousk.blogspot.tw/2012/03/android-40-ice-cream-sandwich-media.html" MODIFIED="1376535454914" TEXT="NuPlayer - If URL start with http/https and contains m3u8, or start with rtsp"/>
</node>
<node CREATED="1408615678825" ID="ID_593759214" LINK="http://goo.gl/e0Zg1J" MODIFIED="1412232786649" POSITION="left" TEXT="libstagefright.cpp"/>
<node CREATED="1408615714308" ID="ID_1906886900" LINK="http://goo.gl/3d6h05" MODIFIED="1408615734875" POSITION="left" TEXT="Today libstagefright.cpp is part of the official ffmpeg source."/>
<node CREATED="1408615766451" ID="ID_273285120" MODIFIED="1408615767316" POSITION="left" TEXT="You can see it as an example, if you want to write your wrapper."/>
<node CREATED="1408581249949" FOLDED="true" ID="ID_667323676" LINK="http://goo.gl/08PdeU" MODIFIED="1409456124314" POSITION="right" TEXT="Android: How to integrate a decoder to multimedia framework">
<node CREATED="1408581315532" ID="ID_1632702083" LINK="http://goo.gl/08PdeU" MODIFIED="1408581329964" TEXT="as a plug-in"/>
<node CREATED="1408581364025" ID="ID_730638036" MODIFIED="1408581365023" TEXT="1. Codec Registration">
<node CREATED="1408581537471" ID="ID_202097863" MODIFIED="1408581538524" TEXT="add a new entry"/>
<node CREATED="1408581553140" ID="ID_272341741" MODIFIED="1408581554107" TEXT="ensure that your codec is listed as the first"/>
</node>
<node CREATED="1408581396479" ID="ID_1554647731" MODIFIED="1408581397183" TEXT="2. OMX Core Registration"/>
</node>
<node CREATED="1408790903488" ID="ID_800719082" LINK="http://goo.gl/QNrN5s" MODIFIED="1408790917139" POSITION="right" TEXT="Implementing Custom Codecs"/>
<node CREATED="1412232981385" ID="ID_1659536029" MODIFIED="1412232982344" POSITION="right" TEXT="Creating an OMX component for a video decoder">
<node CREATED="1412232508289" FOLDED="true" ID="ID_86851258" LINK="http://goo.gl/5kHdfF" MODIFIED="1412232959691" TEXT="steps">
<node CREATED="1412232458393" ID="ID_1379301217" LINK="http://goo.gl/5kHdfF" MODIFIED="1412232473073" TEXT="create an OMX component"/>
<node CREATED="1412232486976" ID="ID_537164253" LINK="http://goo.gl/5kHdfF" MODIFIED="1412232504532" TEXT="register my codec in media_codecs.xml"/>
<node CREATED="1412232529209" ID="ID_539107489" MODIFIED="1412232529952" TEXT="OMX component registration in OMXCore"/>
</node>
<node CREATED="1412232808137" ID="ID_86646920" LINK="http://goo.gl/VUcdCO" MODIFIED="1412232823462" TEXT="command line utility"/>
<node CREATED="1412232944273" ID="ID_851386664" LINK="http://goo.gl/5kHdfF" MODIFIED="1412232957072" TEXT="public domain OMX implementations"/>
</node>
<node CREATED="1410609917782" ID="ID_1909873216" MODIFIED="1410609931063" POSITION="right" TEXT="build single module">
<icon BUILTIN="help"/>
<node CREATED="1412232602761" ID="ID_259602077" MODIFIED="1412232607956" TEXT="mm or mmm"/>
</node>
<node CREATED="1410609999472" ID="ID_1940126179" MODIFIED="1411354273093" POSITION="right" TEXT="logcat single module">
<node CREATED="1411354347923" ID="ID_1331978057" LINK="http://goo.gl/crbtQ1" MODIFIED="1411354446796" TEXT="Access AwesomePlayer Info And Error Messages From An Application?">
<node CREATED="1411354398739" ID="ID_1467140637" MODIFIED="1411354399938" TEXT="onInfoListener, onBufferingUpdateListener, onErrorListener originates from AwesomePlayer"/>
<node CREATED="1411354430771" ID="ID_175607143" MODIFIED="1411354431466" TEXT=" This information is deemed to be sufficient for any application developer"/>
<node CREATED="1411354255468" ID="ID_246468019" LINK="http://goo.gl/crbtQ1" MODIFIED="1411354270547" TEXT=" information is actually communicated through the listeners"/>
<node CREATED="1411354307091" ID="ID_453294330" MODIFIED="1411354308009" TEXT=" Currently, there is no scheme to get this information"/>
<node CREATED="1411354322451" ID="ID_662486111" MODIFIED="1411354323393" TEXT="unless the developer explicitly customizes the AOSP distribution."/>
</node>
</node>
<node CREATED="1410610258233" ID="ID_1693849822" MODIFIED="1410610262752" POSITION="right" TEXT="emulator">
<node CREATED="1410610560858" ID="ID_1763246004" MODIFIED="1410610561768" TEXT="Running emulator after building Android from source"/>
<node CREATED="1410610263942" ID="ID_341908629" MODIFIED="1410610291101" TEXT="Initialize"/>
<node CREATED="1410610300716" ID="ID_1214362851" LINK="http://goo.gl/YVsnB1" MODIFIED="1410610316190" TEXT="Choose a Target"/>
</node>
<node CREATED="1376237208655" FOLDED="true" ID="ID_1221774819" MODIFIED="1412247077434" POSITION="left" TEXT="flow">
<node CREATED="1362953855484" FOLDED="true" ID="ID_82832820" LINK="http://blog.csdn.net/menguio/article/details/6323954" MODIFIED="1412232831715" TEXT="StageFright&#x6846;&#x67b6;&#x6d41;&#x7a0b;&#x89e3;&#x8bfb;">
<icon BUILTIN="info"/>
<node CREATED="1362953181795" ID="ID_1585306752" LINK="http://blog.csdn.net/menguio/article/details/6323954" MODIFIED="1362953195997" TEXT="&#x4ee5;shared library&#x7684;&#x5f62;&#x5f0f;&#x5b58;&#x5728;"/>
<node CREATED="1362955103951" ID="ID_1476909999" MODIFIED="1362955106205" TEXT=" StageFright&#x6570;&#x636e;&#x6d41;&#x5c01;&#x88c5;"/>
<node CREATED="1362955122701" ID="ID_651347703" MODIFIED="1362955124608" TEXT="StageFright&#x7684;Decode"/>
</node>
<node CREATED="1375155539186" FOLDED="true" ID="ID_1792717962" MODIFIED="1412232833179" TEXT="tonight&apos;s launchbox">
<icon BUILTIN="info"/>
<node CREATED="1357110801678" ID="ID_958841736" LINK="http://iamkcspa.pixnet.net/blog/post/39381174" MODIFIED="1357110844522" TEXT="Stagefright&#x6240;&#x6db5;&#x84cb;&#x7684;&#x6a21;&#x7d44;"/>
</node>
<node CREATED="1354692342312" ID="ID_1214363286" LINK="http://iamkcspa.pixnet.net/blog/post/39502968" MODIFIED="1356655056150" TEXT="Stagefright (4) - Video Buffer&#x50b3;&#x8f38;&#x6d41;&#x7a0b;">
<icon BUILTIN="info"/>
</node>
<node CREATED="1410914499837" ID="ID_153271107" LINK="#ID_847901010" MODIFIED="1410914505285" TEXT="Stagefright (2) - &#x548c;OpenMAX&#x7684;&#x904b;&#x4f5c;"/>
</node>
<node CREATED="1410044460051" ID="ID_645786039" MODIFIED="1410916187255" POSITION="left" TEXT="mynotes">
<node CREATED="1410044468215" ID="ID_9641503" MODIFIED="1410044489515" TEXT="aosp-build.sh"/>
<node CREATED="1410916190445" ID="ID_1745973840" MODIFIED="1410916193399" TEXT="readme.txt"/>
</node>
<node CREATED="1356655849541" FOLDED="true" ID="ID_155808997" LINK="http://androidxref.com/4.1.1/xref/frameworks/av/include/media/stagefright/MediaSource.h" MODIFIED="1412246880245" POSITION="left" TEXT="MediaSource">
<node CREATED="1360840240783" ID="ID_947893143" LINK="http://vec.io/tags/ffmpeg#toc-mediasource" MODIFIED="1360840309706" TEXT="is one of the most important keys">
<icon BUILTIN="info"/>
</node>
<node CREATED="1362843428159" MODIFIED="1362843432159" TEXT="CustomSource"/>
<node CREATED="1362885581903" MODIFIED="1362885585920" TEXT="ctor"/>
<node CREATED="1362836551632" MODIFIED="1362836582455" TEXT="read"/>
<node CREATED="1362954817591" LINK="http://androidxref.com/4.1.1/xref/frameworks/av/include/media/stagefright/MediaSource.h#37" MODIFIED="1362954956137" TEXT="start"/>
</node>
<node CREATED="1412232195417" ID="ID_934580760" MODIFIED="1412232199551" POSITION="left" TEXT="MediaCodec"/>
<node CREATED="1358329252770" ID="ID_1396060428" LINK="http://androidxref.com/4.2_r1/xref/frameworks/av/media/libstagefright/omx/OMXNodeInstance.cpp" MODIFIED="1358329265942" POSITION="left" TEXT="OMXNodeInstance.cpp"/>
<node CREATED="1360836658437" ID="ID_434054998" MODIFIED="1360836664493" POSITION="left" TEXT="IOMXRenderer">
<icon BUILTIN="help"/>
</node>
<node CREATED="1376534677981" ID="ID_679227481" LINK="MediaPlayerService, is the interface with MediaPlayer in Android SDK" MODIFIED="1410610914661" POSITION="left" TEXT="MediaPlayerService">
<icon BUILTIN="help"/>
<node CREATED="1376535077525" ID="ID_711382957" LINK="http://diousk.blogspot.tw/2012/03/android-40-ice-cream-sandwich-media.html" MODIFIED="1376535091714" TEXT="MediaPlayerService, is the interface with MediaPlayer in Android SDK"/>
<node CREATED="1409739648437" FOLDED="true" ID="ID_1721439231" LINK="http://goo.gl/ImHkhu" MODIFIED="1410610914042" TEXT="::Client::createPlayer">
<node CREATED="1409739581909" ID="ID_1997546691" LINK="http://goo.gl/ImHkhu" MODIFIED="1409739611228" TEXT="setDataSource&#x4e2d;&#x901a;&#x8fc7;getPlayerTyep&#x53bb;&#x6839;&#x636e;url&#x7684;&#x7c7b;&#x578b;&#x5224;&#x65ad;&#x8981;&#x521b;&#x5efa;&#x54ea;&#x79cd;Player"/>
<node CREATED="1409739597557" ID="ID_1191498412" LINK="http://goo.gl/ImHkhu" MODIFIED="1409739615813" TEXT="&#x7136;&#x540e;&#x8c03;&#x7528;creatPlayer, &#x5e76;&#x628a;&#x8fd4;&#x56de;&#x503c;&#x4ed8;&#x7ed9;&#x6210;&#x5458;&#x53d8;&#x91cf;mPlayer"/>
</node>
<node CREATED="1409740395773" ID="ID_382974433" LINK="http://goo.gl/XOpgK5" MODIFIED="1409740410698" TEXT="MediaPlayerService.cpp"/>
<node CREATED="1410967355716" FOLDED="true" ID="ID_1368361157" MODIFIED="1412232059315" TEXT="mOMX">
<node CREATED="1410967373526" ID="ID_1751160223" MODIFIED="1410967374561" TEXT="sp&lt;IOMX&gt;">
<node CREATED="1410967378316" ID="ID_120546057" MODIFIED="1410967389836" TEXT="mutable">
<node CREATED="1410967543061" ID="ID_455846584" LINK="http://goo.gl/EF1GMs" MODIFIED="1410967558011" TEXT="volatile vs. mutable in C++"/>
</node>
</node>
<node CREATED="1410967583914" ID="ID_862056951" MODIFIED="1410967584683" TEXT="&#x8fd9;&#x4e2a;&#x5c31;&#x662f;&#x548c;OMX&#x670d;&#x52a1;&#x8fdb;&#x884c;binder&#x901a;&#x8baf;&#x7684;"/>
</node>
</node>
<node CREATED="1411119858768" ID="ID_1249158837" LINK="http://goo.gl/q4IH5X" MODIFIED="1411119874551" POSITION="left" TEXT="android&#x591a;&#x5a92;&#x4f53;&#x672c;&#x5730;&#x64ad;&#x653e;&#x6d41;&#x7a0b;video playback--base on jellybean (&#x56db;)"/>
<node CREATED="1411963296898" ID="ID_1616683974" MODIFIED="1411963297835" POSITION="left" TEXT="MediaBufferObserver"/>
<node CREATED="1411963324018" FOLDED="true" ID="ID_1972710601" MODIFIED="1412232062243" POSITION="left" TEXT="MediaBuffer">
<node CREATED="1411977243592" ID="ID_1189536765" LINK="http://goo.gl/9TDs0m" MODIFIED="1411977265327" TEXT="the memory in it are allocated from kernel ashmem driver"/>
</node>
<node CREATED="1411987489586" ID="ID_536957693" MODIFIED="1411987514619" POSITION="left" TEXT="OMXCodecObserver interface">
<icon BUILTIN="help"/>
</node>
<node CREATED="1360840765464" ID="ID_157532288" LINK="http://goo.gl/WqbMkt" MODIFIED="1412245123300" POSITION="right" TEXT="AwesomePlayer.cpp">
<node CREATED="1354589124796" FOLDED="true" ID="ID_219858252" LINK="http://stackoverflow.com/questions/9230864/what-is-awesomeplayer-in-android" MODIFIED="1409456109034" TEXT="what is this">
<node CREATED="1365891223583" LINK="http://iamkcspa.pixnet.net/blog/post/39381174" MODIFIED="1365891248975" TEXT="&#x7528;&#x4f86;&#x64ad;&#x653e;video/audio"/>
</node>
<node CREATED="1360840747651" ID="ID_229409014" LINK="http://vec.io/tags/ffmpeg#toc-mediasource" MODIFIED="1360840783151" TEXT="some sample usage from libstagefright/AwesomePlayer.cpp">
<icon BUILTIN="info"/>
</node>
<node CREATED="1354588354203" FOLDED="true" ID="ID_1363136152" LINK="http://stackoverflow.com/questions/6779741/decoding-and-rendering-video-on-android" MODIFIED="1410609905944" TEXT="awesome player">
<node CREATED="1409410136737" ID="ID_1247856750" LINK="http://goo.gl/eBEWUt" MODIFIED="1409410169585" TEXT="implement Stagefright media extractor plug-in"/>
<node CREATED="1409410155705" ID="ID_1324503062" LINK="http://goo.gl/eBEWUt" MODIFIED="1409410173567" TEXT=" integrate into awesome player"/>
<node CREATED="1357701889171" ID="ID_1423466339" LINK="https://groups.google.com/forum/?fromgroups=#!msg/android-ndk/pHQI0WcHCs0/dnYVq4XxDXUJ" MODIFIED="1409392530683" TEXT=" if the decoder gives outptut YUV420 format"/>
</node>
<node CREATED="1409392531175" ID="ID_1120827452" MODIFIED="1409392532040" TEXT=" then the conversion is done in the stagefright"/>
<node CREATED="1357703545140" FOLDED="true" ID="ID_1627933725" MODIFIED="1409456115842" TEXT="if the decoded frame arrives later 40ms ">
<node CREATED="1357703565953" ID="ID_825320861" LINK="https://groups.google.com/forum/?fromgroups=#!msg/android-ndk/pHQI0WcHCs0/dnYVq4XxDXUJ" MODIFIED="1357703579125" TEXT="Awesome player is dropping the frame and displaying the blank screen"/>
<node CREATED="1357704030781" ID="ID_988975490" LINK="http://androidxref.com/4.2_r1/xref/frameworks/base/core/java/android/view/Choreographer.java" MODIFIED="1409392818422" TEXT="Choreographer">
<node CREATED="1357704050031" LINK="http://androidxref.com/4.2_r1/xref/frameworks/base/core/java/android/view/Choreographer.java#503" MODIFIED="1357704094125" TEXT="Skipped xxx frames!"/>
</node>
</node>
<node CREATED="1376280013009" ID="ID_109402161" MODIFIED="1376280063034" TEXT="&#x5982;&#x4f55;&#x8b93;awesomePlayer&#x9078;&#x64c7;&#x81ea;&#x8a02;&#x7684;MediaSource">
<icon BUILTIN="help"/>
</node>
<node CREATED="1360201927890" ID="ID_1616180018" MODIFIED="1409412781822" TEXT="uses Audio Player for playing out audio">
<icon BUILTIN="info"/>
</node>
<node CREATED="1409456077756" ID="ID_1884603163" MODIFIED="1409456105905" TEXT="how is the connection between OMXClient">
<icon BUILTIN="help"/>
</node>
<node CREATED="1409455257069" ID="ID_562663828" MODIFIED="1413291136884" TEXT="beginPrepareAsync_l">
<node CREATED="1409455287620" ID="ID_60516850" MODIFIED="1409455288870" TEXT="initVideoDecoder()">
<node CREATED="1409737029332" ID="ID_355493559" MODIFIED="1409737033478" TEXT="mVideoSource-&gt;start()"/>
</node>
<node CREATED="1409455305891" ID="ID_1295747694" MODIFIED="1409455306854" TEXT="initAudioDecoder()">
<node CREATED="1409736015123" ID="ID_1064133599" LINK="http://goo.gl/QLNK85" MODIFIED="1409736429910" TEXT="mAudioSource"/>
</node>
<node CREATED="1409737204540" ID="ID_1404825716" LINK="http://goo.gl/Fr5UHB" MODIFIED="1409738374366" TEXT="finishAsyncPrepare_l">
<node CREATED="1409737589805" ID="ID_1665521615" LINK="#ID_737704556" MODIFIED="1409738308335" TEXT="play_l"/>
</node>
</node>
<node CREATED="1409737574612" FOLDED="true" ID="ID_737704556" LINK="http://goo.gl/fQSbCq" MODIFIED="1410609907832" TEXT="play_l">
<node CREATED="1409737700268" ID="ID_416893546" MODIFIED="1409737704182" TEXT="createAudioPlayer_l">
<icon BUILTIN="help"/>
</node>
<node CREATED="1410603056219" ID="ID_511413712" LINK="#ID_665088678" MODIFIED="1410603073838" TEXT="postVideoLagEvent_l()"/>
</node>
<node CREATED="1409738345332" ID="ID_1541046122" LINK="http://goo.gl/oXGvt2" MODIFIED="1409738364122" TEXT="reset_l"/>
<node CREATED="1410601943639" ID="ID_1605464077" MODIFIED="1410601943639" TEXT="pause_l"/>
<node CREATED="1410041834767" ID="ID_1053137845" MODIFIED="1410041835612" TEXT="mOmxSource">
<node CREATED="1410041843977" ID="ID_816192742" LINK="#ID_155808997" MODIFIED="1410041851248" TEXT="MediaSource"/>
</node>
<node CREATED="1409739899805" ID="ID_636893763" LINK="http://goo.gl/ImHkhu" MODIFIED="1409739913198" TEXT="&#x7528;mStats&#x6765;&#x4fdd;&#x5b58;&#x64ad;&#x653e;&#x6587;&#x4ef6;&#x7684;&#x4e00;&#x4e9b;&#x53c2;&#x6570;"/>
<node CREATED="1409993036831" ID="ID_1289277167" MODIFIED="1409993040015" TEXT="timesource"/>
<node CREATED="1409993026249" ID="ID_1782874632" MODIFIED="1409993028064" TEXT="mTimeSourceDeltaUs"/>
<node CREATED="1410042871072" FOLDED="true" ID="ID_1792073656" MODIFIED="1410609898448" TEXT="ANativeBuffers">
<node CREATED="1410043061306" ID="ID_1711086810" MODIFIED="1410043338693" TEXT="Hardware decoders avoid the CPU color conversion">
<icon BUILTIN="help"/>
</node>
<node CREATED="1410043893805" ID="ID_764280354" LINK="#ID_1437708079" MODIFIED="1410043902904" TEXT="Bypassing default renderer"/>
<node CREATED="1410042976412" ID="ID_1758472865" MODIFIED="1410395444157" TEXT="initRenderer_l">
<node CREATED="1410043015264" ID="ID_1615977155" MODIFIED="1410043021224" TEXT="component"/>
<node CREATED="1410043202540" ID="ID_475500588" MODIFIED="1410043203560" TEXT="mVideoRenderer"/>
<node CREATED="1410395366945" ID="ID_732024731" MODIFIED="1410395368305" TEXT="AwesomeNativeWindowRenderer"/>
<node CREATED="1410395399975" ID="ID_1188152074" MODIFIED="1410395400594" TEXT="AwesomeLocalRenderer"/>
</node>
</node>
<node CREATED="1410395243808" ID="ID_1208358225" MODIFIED="1410395246284" TEXT="mNativeWindow">
<icon BUILTIN="help"/>
</node>
<node CREATED="1410400215459" ID="ID_1714810182" MODIFIED="1410609892640" TEXT="postVideoEvent_l">
<node CREATED="1410400280043" FOLDED="true" ID="ID_647418917" MODIFIED="1410609891770" TEXT="mQueue">
<node CREATED="1410482289881" ID="ID_3355945" MODIFIED="1410482290838" TEXT="List&lt;QueueEntry&gt;"/>
<node CREATED="1410602197743" ID="ID_1610288310" MODIFIED="1410602200764" TEXT="postEventWithDelay">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1410601122213" ID="ID_1121695256" MODIFIED="1410601123363" TEXT="latenessUs"/>
<node CREATED="1410601207666" ID="ID_653304333" MODIFIED="1410603109188" TEXT="wasSeeking">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1410602098625" ID="ID_40614972" MODIFIED="1410609888337" TEXT="events">
<node CREATED="1409455789949" FOLDED="true" ID="ID_389709478" MODIFIED="1410609887741" TEXT="AwesomeEvent">
<icon BUILTIN="help"/>
<node CREATED="1409455911833" ID="ID_907051990" MODIFIED="1410603247149" TEXT="&#x555f;&#x52d5;mQueue&#xff0c;&#x4f5c;&#x70ba;event handler"/>
<node CREATED="1354589323296" ID="ID_1074264066" LINK="http://iamkcspa.pixnet.net/blog/post/39381174-stagefright-(1)---video-playback%E7%9A%84%E6%B5%81%E7%A8%8B" MODIFIED="1354589344796" TEXT="Video Playback&#x7684;&#x6d41;&#x7a0b;"/>
</node>
<node CREATED="1410395202482" FOLDED="true" ID="ID_1924034530" MODIFIED="1411963317270" TEXT="onVideoEvent">
<icon BUILTIN="help"/>
<node CREATED="1410395469681" ID="ID_550282888" LINK="#ID_1758472865" MODIFIED="1410395476089" TEXT="initRenderer_l"/>
<node CREATED="1410395944723" FOLDED="true" ID="ID_1875549895" MODIFIED="1411963317268" TEXT="mVideoBuffer">
<node CREATED="1356656006202" ID="ID_274410996" MODIFIED="1411963314582" TEXT="MediaBuffer">
<node CREATED="1362923192313" ID="ID_551076624" LINK="http://www.360doc.com/content/11/1020/16/11192_157742254.shtml" MODIFIED="1362923220199" TEXT="MediaBuffer&#x4f7f;&#x7528;&#x8981;&#x9ede;"/>
</node>
</node>
<node CREATED="1410396230320" ID="ID_771205887" MODIFIED="1410609755807" TEXT="startAudioPlayer_l()"/>
<node CREATED="1410398995323" FOLDED="true" ID="ID_1790552580" MODIFIED="1410609887742" TEXT="mVideoEvent">
<node CREATED="1410399999159" ID="ID_1973418541" MODIFIED="1410400004805" TEXT="TimedEventQueue::Event">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1410399164314" ID="ID_411295413" MODIFIED="1410399165193" TEXT="mVideoEventPending"/>
</node>
<node CREATED="1410601778578" FOLDED="true" ID="ID_1922393517" MODIFIED="1410602058789" TEXT="onStreamDone">
<node CREATED="1410601439684" ID="ID_264002638" MODIFIED="1410601459551" TEXT="mStreamDoneEvent"/>
<node CREATED="1410601509527" ID="ID_963732421" MODIFIED="1410601510299" TEXT="mStreamDoneEventPending"/>
<node CREATED="1410601891548" ID="ID_969682101" MODIFIED="1410601892176" TEXT="notifyListener_l"/>
</node>
<node CREATED="1410602091433" FOLDED="true" ID="ID_951293483" MODIFIED="1410609887743" TEXT="onBufferingUpdate">
<node CREATED="1410602261643" ID="ID_943044697" MODIFIED="1410602265980" TEXT="mWVMExtractor">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1410602771316" FOLDED="true" ID="ID_665088678" MODIFIED="1410609887743" TEXT="onVideoLagUpdate">
<node CREATED="1410602964300" ID="ID_483880186" MODIFIED="1410602965186" TEXT="notifyListener_l"/>
</node>
<node CREATED="1410603169303" FOLDED="true" ID="ID_1523097509" MODIFIED="1410609887744" TEXT="onCheckAudioStatus">
<node CREATED="1410603235983" ID="ID_354732632" MODIFIED="1410603251932" TEXT="notifyIfMediaStarted_l">
<icon BUILTIN="help"/>
</node>
<node CREATED="1410609493442" ID="ID_174460414" MODIFIED="1410609496887" TEXT="FIRST_FRAME">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1410609589087" ID="ID_284694102" MODIFIED="1410609589793" TEXT="onAudioTearDownEvent"/>
</node>
<node CREATED="1410602920604" ID="ID_907432555" MODIFIED="1410602921327" TEXT="mFlags"/>
<node CREATED="1410609750181" ID="ID_793006598" MODIFIED="1410609750975" TEXT="mClockEstimator"/>
<node CREATED="1410915967519" ID="ID_1110358153" MODIFIED="1410915969631" TEXT="mVideoTrack">
<node CREATED="1410916009361" ID="ID_459533795" LINK="#ID_155808997" MODIFIED="1410916015177" TEXT="MediaSource"/>
</node>
<node CREATED="1410915189645" ID="ID_1632512900" MODIFIED="1410915721797" TEXT="mVideoSource">
<node CREATED="1410915192981" ID="ID_962068871" MODIFIED="1410915708276" TEXT="point to OMXCodec instance">
<node CREATED="1410916006808" ID="ID_1311506432" LINK="#ID_155808997" MODIFIED="1410916022081" TEXT="MediaSource"/>
</node>
<node CREATED="1410915408324" ID="ID_1468456359" MODIFIED="1410915409024" TEXT="OMXCodec::Create">
<node CREATED="1410915502862" ID="ID_872335396" MODIFIED="1410915503782" TEXT="mClient.interface()">
<node CREATED="1410915644079" ID="ID_165907206" LINK="#ID_1369458708" MODIFIED="1410915650250" TEXT="OMXClient"/>
</node>
<node CREATED="1410915936842" ID="ID_517088105" LINK="#ID_1110358153" MODIFIED="1410916281768" TEXT="mVideoTrack-&gt;getFormat()"/>
<node CREATED="1410916125258" ID="ID_147113271" MODIFIED="1410916127326" TEXT="flags"/>
<node CREATED="1410916127686" ID="ID_1195292086" MODIFIED="1410916128720" TEXT="mNativeWindow">
<node CREATED="1410916247260" ID="ID_1055297633" MODIFIED="1410916260757" TEXT="ANativeWindow">
<icon BUILTIN="help"/>
</node>
</node>
</node>
<node CREATED="1412245131503" ID="ID_1198612676" MODIFIED="1412245133685" TEXT="read">
<node CREATED="1412245178735" ID="ID_282121168" LINK="http://goo.gl/U26Ny7" MODIFIED="1412245215189" TEXT="onVideoEvent&#x65b9;&#x6cd5;">
<node CREATED="1412245200336" ID="ID_1081159866" MODIFIED="1412245201245" TEXT=" android&#x591a;&#x5a92;&#x4f53;&#x672c;&#x5730;&#x64ad;&#x653e;&#x6d41;&#x7a0b;video playback"/>
</node>
</node>
</node>
<node CREATED="1410041792150" ID="ID_1178251485" MODIFIED="1410915630891" TEXT="mClient">
<node CREATED="1410041808346" ID="ID_1369458708" LINK="http://goo.gl/Oi3piD" MODIFIED="1410042135155" TEXT="OMXClient">
<node CREATED="1410042050500" ID="ID_1371348964" MODIFIED="1410042055227" TEXT="connect()"/>
<node CREATED="1410042096157" ID="ID_1486591863" MODIFIED="1410042096935" TEXT="disconnect()"/>
<node CREATED="1410042153788" ID="ID_1232407260" MODIFIED="1410042154932" TEXT="interface()"/>
<node CREATED="1410966675697" ID="ID_1248857753" MODIFIED="1410966676363" TEXT="&#x6709;&#x4e2a;IOMX &#x7684;&#x53d8;&#x91cf; mOMX"/>
<node CREATED="1410966694344" ID="ID_1711411492" MODIFIED="1410966695017" TEXT="&#x8fd9;&#x4e2a;&#x5c31;&#x662f;&#x548c;OMX&#x670d;&#x52a1;&#x8fdb;&#x884c;binder&#x901a;&#x8baf;&#x7684;"/>
<node CREATED="1410967687113" ID="ID_408243201" LINK="http://goo.gl/3h8bsF" MODIFIED="1410967700466" TEXT="&#x901a;&#x8fc7;binder&#x673a;&#x5236; &#x83b7;&#x5f97;&#x5230;MediaPlayerService"/>
<node CREATED="1410967799316" ID="ID_1972562236" MODIFIED="1410967799981" TEXT="&#x97f3;&#x89c6;&#x9891;&#x89e3;&#x7801;&#x5668;&#x5171;&#x7528;&#x8fd9;&#x4e2a;IOMX&#x53d8;&#x91cf;&#x6765;&#x83b7;&#x5f97;OMX&#x670d;&#x52a1;"/>
</node>
</node>
</node>
<node CREATED="1411724364539" ID="ID_1312373018" MODIFIED="1411724365460" POSITION="left" TEXT="two useful client side classes">
<node CREATED="1411724378611" ID="ID_1115990373" LINK="#ID_1595722474" MODIFIED="1413293019506" TEXT="OMXCodec">
<node CREATED="1411962869771" ID="ID_545414386" LINK="http://goo.gl/z3SUY1" MODIFIED="1411962884282" TEXT="suits well for local media content decoding"/>
<node CREATED="1411986486081" ID="ID_1956576021" MODIFIED="1411986487549" TEXT="MetaData">
<node CREATED="1411986489090" ID="ID_852339065" MODIFIED="1411986496195" TEXT="structure">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1412245395455" ID="ID_1204488767" MODIFIED="1412245396374" TEXT="start"/>
</node>
<node CREATED="1411724326982" ID="ID_1300055591" MODIFIED="1413290880438" TEXT="ACodec ">
<icon BUILTIN="help"/>
<node CREATED="1411962956866" ID="ID_164560977" LINK="http://goo.gl/z3SUY1" MODIFIED="1411962976555" TEXT="is the best effort to serve playback of streamed data."/>
<node CREATED="1412046257357" ID="ID_1135815391" LINK="http://goo.gl/MEeJQ9" MODIFIED="1412046273178" TEXT="no subclass of MediaSource"/>
<node CREATED="1412231629456" ID="ID_556823449" LINK="http://goo.gl/MEeJQ9" MODIFIED="1412231665031" TEXT="tracks the components states">
<node CREATED="1412231647968" ID="ID_375956157" MODIFIED="1412231648657" TEXT="OpenMAX spec V1.1.2"/>
</node>
</node>
</node>
<node CREATED="1409993351281" ID="ID_913184454" MODIFIED="1409993354001" POSITION="left" TEXT="ALooper"/>
<node CREATED="1412231305552" ID="ID_827213294" MODIFIED="1412231308857" POSITION="left" TEXT="AHandler"/>
<node CREATED="1412231518400" ID="ID_626736210" MODIFIED="1412231523314" POSITION="left" TEXT="ABuffer"/>
<node CREATED="1357718694934" ID="ID_732612997" LINK="http://androidxref.com/4.1.1/xref/frameworks/av/media/libstagefright/MediaExtractor.cpp" MODIFIED="1413290983274" POSITION="left" TEXT="MediaExtractor">
<node CREATED="1362953297975" LINK="http://blog.csdn.net/menguio/article/details/6323954" MODIFIED="1362953312053" TEXT="&#x7531;&#x6570;&#x636e;&#x6e90;DataSource&#x751f;&#x6210;MediaExtractor"/>
<node CREATED="1362954399780" MODIFIED="1362954402581" TEXT="&#x901a;&#x8fc7;MediaExtractor::Create(dataSource)&#x6765;&#x5b9e;&#x73b0;&#x3002;"/>
<node CREATED="1362953518769" LINK="http://androidxref.com/4.1.1/xref/frameworks/av/media/libstagefright/MediaExtractor.cpp" MODIFIED="1362953531771" TEXT="MediaExtractor.cpp"/>
<node CREATED="1362954641022" ID="ID_901334616" MODIFIED="1362954643415" TEXT="&#x628a;&#x97f3;&#x89c6;&#x9891;&#x8f68;&#x9053;&#x5206;&#x79bb;&#xff0c;&#x751f;&#x6210;mVideoTrack&#x548c;mAudioTrack&#x4e24;&#x4e2a;MediaSource&#x3002;"/>
<node CREATED="1362954667466" ID="ID_111540005" MODIFIED="1362954668201" TEXT="&#x5f97;&#x5230;&#x7684;&#x8fd9;&#x4e24;&#x4e2a;MediaSource&#xff0c;&#x53ea;&#x5177;&#x6709;parser&#x529f;&#x80fd;&#xff0c;&#x6ca1;&#x6709;decode&#x529f;&#x80fd;&#x3002;"/>
<node CREATED="1362954790817" ID="ID_355037898" LINK="#ID_935488597" MODIFIED="1362954853965" TEXT="&#x5f53;&#x8c03;&#x7528;MediaSource.start()&#x65b9;&#x6cd5;&#x540e;&#xff0c;&#x5b83;&#x7684;&#x5185;&#x90e8;&#x5c31;&#x4f1a;&#x5f00;&#x59cb;&#x4ece;&#x6570;&#x636e;&#x6e90;&#x83b7;&#x53d6;&#x6570;&#x636e;&#x5e76;&#x89e3;&#x6790;&#xff0c;&#x7b49;&#x5230;&#x7f13;&#x51b2;&#x533a;&#x6ee1;&#x540e;&#x4fbf;&#x505c;&#x6b62;&#x3002;"/>
<node CREATED="1413290985537" ID="ID_1321543319" LINK="http://goo.gl/Ev2tx1" MODIFIED="1413291000213" TEXT="&#x89e3;&#x6790;&#x6587;&#x4ef6;"/>
</node>
<node CREATED="1354587158296" ID="ID_712281451" LINK="http://www.khronos.org/openmax/" MODIFIED="1412247126868" POSITION="left" TEXT="OpenMax">
<node CREATED="1360811699537" LINK="http://www.celinux.org/elc08_presentations/gst-openmax.pdf" MODIFIED="1362817251093" TEXT="what is it">
<icon BUILTIN="info"/>
</node>
<node CREATED="1361761858484" ID="ID_1248928156" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=6&amp;cad=rja&amp;ved=0CGAQFjAF&amp;url=http%3A%2F%2Fmmlab.disi.unitn.it%2Fuploads%2Ftutorials%2FTutorial_FFMPEG.pdf&amp;ei=YtYqUaysOMihkAXHwoD4DQ&amp;usg=AFQjCNFyUvacOtEQ3rPY01EXy0K-5srWaw&amp;sig2=SD3mpQ7oKxKsGN-98VeIcw" MODIFIED="1361761916218" TEXT="Open Media Acceleration">
<icon BUILTIN="info"/>
</node>
<node CREATED="1354772442718" FOLDED="true" ID="ID_202657323" LINK="http://fecbob.pixnet.net/blog/post/38383035" MODIFIED="1376031858203" TEXT="StageFright &#x5982;&#x4f55;&#x9078;&#x5b9a; OMX &#x5143;&#x4ef6;&#x7684;">
<node CREATED="1358142354515" MODIFIED="1358142356703" TEXT="stagefright -l  &#x5c31;&#x53ef;&#x4ee5;&#x770b;&#x5230;&#x6240;&#x6709;&#x7684;OMX&#x5143;&#x4ef6;&#x3002;"/>
<node CREATED="1358142470546" MODIFIED="1358142473578" TEXT="StageFright&#x5982;&#x4f55;&#x9078;&#x5b9a;&#x4f7f;&#x7528;&#x54ea;&#x500b;OMX&#x5143;&#x4ef6;&#x4f86;&#x670d;&#x52d9;&#x67d0;&#x500b;&#x7279;&#x5b9a;&#x7684;decode&#x6216;&#x8005;encode&#xff1f;"/>
</node>
<node CREATED="1354587183531" ID="ID_195362928" MODIFIED="1354587185281" TEXT="media extractor plug-in"/>
<node CREATED="1360811819187" FOLDED="true" ID="ID_1206243768" MODIFIED="1412247124903" TEXT="Integration Layer">
<node CREATED="1363398949846" FOLDED="true" LINK="http://www.360doc.com/content/10/1221/10/474846_79985742.shtml" MODIFIED="1376031858125" TEXT="&#x5e95;&#x5c64;&#x90e8;&#x4ef6;&#x7684;&#x96c6;&#x5408;&#x5c64;">
<icon BUILTIN="info"/>
<node CREATED="1363399400435" FOLDED="true" LINK="http://www.360doc.com/content/10/1221/10/474846_79985742.shtml" MODIFIED="1376031857281" TEXT="stagefright+omx&#x5c0f;&#x7d50;">
<icon BUILTIN="info"/>
<node CREATED="1363399427047" MODIFIED="1363399446174" TEXT="android 2.2">
<icon BUILTIN="info"/>
</node>
<node CREATED="1363399486685" LINK="http://www.360doc.com/content/10/1221/10/474846_79982389.shtml" MODIFIED="1363399515037" TEXT="stagefright&#x7c21;&#x55ae;&#x6d41;&#x7a0b;"/>
<node CREATED="1363400081401" LINK="http://www.360doc.com/content/11/1019/09/11192_157350357.shtml" MODIFIED="1363400126923" TEXT="openmax&#x5728;android&#x4e0a;&#x7684;&#x5be6;&#x73fe;"/>
</node>
</node>
<node CREATED="1357109205459" FOLDED="true" ID="ID_1401275490" LINK="http://www.slideshare.net/RaghavanVenkateswaran/iomx-in-android" MODIFIED="1412247124902" TEXT="Using IOMX in Android">
<node CREATED="1358143054390" MODIFIED="1358143060828" TEXT="Using IOMX interface"/>
<node CREATED="1358143116625" MODIFIED="1358143132125" TEXT="selecting a component is done based on role"/>
<node CREATED="1360811961947" MODIFIED="1360811985652" TEXT="refer the surface object using the surface id"/>
<node CREATED="1360812001048" MODIFIED="1360812024991" TEXT="and pass it to the native MediaPlayer">
<icon BUILTIN="info"/>
</node>
<node CREATED="1360812091882" MODIFIED="1360812113088" TEXT="how to use theIOMX interface through native code"/>
</node>
<node CREATED="1360812291880" FOLDED="true" ID="ID_1848752278" MODIFIED="1376534624940" TEXT="iOMX access from JNI">
<node CREATED="1362817996499" ID="ID_1358750150" LINK="https://groups.google.com/forum/#!msg/android-platform/50yrEHTQGno/97TVAItmKx4J" MODIFIED="1362818014172" TEXT="mediaplayerservice exposes a nice interface IOMX">
<icon BUILTIN="help"/>
</node>
<node CREATED="1362818027229" MODIFIED="1362818031220" TEXT="a way to use hardware codecs in an application with no root access.">
<icon BUILTIN="info"/>
</node>
<node CREATED="1362818042207" MODIFIED="1362818044735" TEXT=" Codec enumeration / Initialization / decoding"/>
</node>
<node CREATED="1365890383230" MODIFIED="1365890386975" TEXT="a set of C-language media component interfaces"/>
<node CREATED="1358136227875" FOLDED="true" MODIFIED="1376031858125" TEXT="interface">
<node CREATED="1360202832328" LINK="#ID_66011472" MODIFIED="1360202857156" TEXT="related works"/>
<node CREATED="1360202313234" LINK="#ID_43121092" MODIFIED="1360202745859" TEXT="how to">
<icon BUILTIN="help"/>
</node>
<node CREATED="1358388614140" FOLDED="true" LINK="#ID_403376469" MODIFIED="1376031857281" TEXT="vitamio">
<icon BUILTIN="idea"/>
<node CREATED="1358387389546" MODIFIED="1375153135249" TEXT="use OpenMax"/>
<node CREATED="1359942992843" MODIFIED="1362830514600" TEXT="how">
<icon BUILTIN="help"/>
</node>
<node CREATED="1360202377765" MODIFIED="1362830540677" TEXT="business secret">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1356592145046" FOLDED="true" LINK="http://stackoverflow.com/questions/11321825/how-to-use-hardware-accelerated-video-decoding-on-android" MODIFIED="1376031857281" TEXT="codec interface">
<node CREATED="1356592233875" MODIFIED="1356592235390" TEXT="Hence all native codecs (hardware accelerated or otherwise) provide OpenMAX interface. "/>
</node>
<node CREATED="1365856791799" LINK="http://ccppcoding.blogspot.tw/2012/09/openmax.html" MODIFIED="1365856825256" TEXT="between Media framework and Codec&#x2019;s"/>
</node>
<node CREATED="1360812342031" MODIFIED="1360812344156" TEXT="Using IOMX from jni to gain access to hardware codecs"/>
<node CREATED="1365858068581" LINK="https://www.uplinq.com/2011/sites/default/files/images/Snapdragon-Lab-Accessing-Hardware-Accelerated-Video-Codecs-Android-Steve-Lukas.pdf" MODIFIED="1365858113506" TEXT="using OpenMAX to get access to the hardware decoders on the newer Qualcomm processors"/>
<node CREATED="1360814872161" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;ved=0CDYQFjAA&amp;url=http%3A%2F%2Felinux.org%2Fimages%2Fe%2Fe0%2FGst-openmax.pdf&amp;ei=UmMcUbqCCuzLmgXR7oCoAw&amp;usg=AFQjCNFbF_WgVVpmnbN1S-aZIKnbWrfRnQ&amp;sig2=H6-vOWI-stNLQxikc8tURw" MODIFIED="1360814976960" TEXT="doesn&#x2019;t autoconnect components">
<icon BUILTIN="info"/>
</node>
<node CREATED="1360202416375" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;ved=0CDYQFjAA&amp;url=http%3A%2F%2Felinux.org%2Fimages%2Fe%2Fe0%2FGst-openmax.pdf&amp;ei=UmMcUbqCCuzLmgXR7oCoAw&amp;usg=AFQjCNFbF_WgVVpmnbN1S-aZIKnbWrfRnQ&amp;sig2=H6-vOWI-stNLQxikc8tURw" MODIFIED="1365890409534" TEXT="IL">
<icon BUILTIN="info"/>
</node>
</node>
<node CREATED="1360837211998" ID="ID_965979074" LINK="http://omxil.sourceforge.net/index.html" MODIFIED="1413292842871" TEXT="Bellagio">
<node CREATED="1362821498986" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=2&amp;cad=rja&amp;ved=0CEQQFjAB&amp;url=http%3A%2F%2Felinux.org%2Fimages%2F5%2F52%2FElc2011_garcia.pdf&amp;ei=mvQ6UaHHGuyQiAfGwIDgCA&amp;usg=AFQjCNF0iLKneBfuhJ7UsgJ8pRs6sFDE9Q&amp;sig2=rSn7Qu5JOFokmzcOTJ9p3A" MODIFIED="1362821874892" TEXT="specific">
<icon BUILTIN="info"/>
</node>
<node CREATED="1362821825128" FOLDED="true" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=2&amp;cad=rja&amp;ved=0CEQQFjAB&amp;url=http%3A%2F%2Felinux.org%2Fimages%2F5%2F52%2FElc2011_garcia.pdf&amp;ei=mvQ6UaHHGuyQiAfGwIDgCA&amp;usg=AFQjCNF0iLKneBfuhJ7UsgJ8pRs6sFDE9Q&amp;sig2=rSn7Qu5JOFokmzcOTJ9p3A" MODIFIED="1376031858125" TEXT="examples">
<icon BUILTIN="info"/>
<node CREATED="1362821588042" MODIFIED="1362821593016" TEXT="sample application"/>
<node CREATED="1362821805251" FOLDED="true" MODIFIED="1376031857281" TEXT="Gstreamer via GstOpenMax">
<node CREATED="1354678512449" LINK="http://heaven.branda.to/~thinker/GinGin_CGI.py/show_id_doc/391" MODIFIED="1354678539902" TEXT="GStreamer &#x548c; OpenMAX IL &#x7684;&#x6bd4;&#x8f03;"/>
</node>
<node CREATED="1362821816474" MODIFIED="1362821820616" TEXT="Android"/>
<node CREATED="1363397123123" LINK="#ID_1994031191" MODIFIED="1363397181446" TEXT="Include native StageFright features in my own project"/>
<node CREATED="1363398262472" MODIFIED="1363398281925" TEXT="TI&#x7684;example&#x5728;&#x54ea;&#x88cf;">
<icon BUILTIN="idea"/>
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1362822640968" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=2&amp;cad=rja&amp;ved=0CEQQFjAB&amp;url=http%3A%2F%2Felinux.org%2Fimages%2F5%2F52%2FElc2011_garcia.pdf&amp;ei=mvQ6UaHHGuyQiAfGwIDgCA&amp;usg=AFQjCNF0iLKneBfuhJ7UsgJ8pRs6sFDE9Q&amp;sig2=rSn7Qu5JOFokmzcOTJ9p3A" MODIFIED="1362822672115" TEXT="component configuration"/>
<node CREATED="1362822948774" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=2&amp;cad=rja&amp;ved=0CEQQFjAB&amp;url=http%3A%2F%2Felinux.org%2Fimages%2F5%2F52%2FElc2011_garcia.pdf&amp;ei=mvQ6UaHHGuyQiAfGwIDgCA&amp;usg=AFQjCNF0iLKneBfuhJ7UsgJ8pRs6sFDE9Q&amp;sig2=rSn7Qu5JOFokmzcOTJ9p3A" MODIFIED="1362822989050" TEXT="version must match"/>
<node CREATED="1413292823177" ID="ID_1888517590" MODIFIED="1413292824065" TEXT="hardware/xxx/libstagefrighthw">
<node CREATED="1413292872165" ID="ID_322970836" LINK="http://goo.gl/kqOEZx" MODIFIED="1413292884861" TEXT="Hardware related source code"/>
<node CREATED="1413293179543" ID="ID_1095396815" MODIFIED="1413293181050" TEXT="TIOMXPlugin"/>
</node>
</node>
<node CREATED="1360853780872" FOLDED="true" ID="ID_1702749225" LINK="http://code.metager.de/source/xref/ffmpeg/libavcodec/libstagefright.cpp" MODIFIED="1408653966981" TEXT="libstagefright.cpp">
<node CREATED="1376277409959" ID="ID_1816933716" MODIFIED="1376277411046" TEXT="Interface to the Android Stagefright library"/>
<node CREATED="1376277428263" ID="ID_1736716735" LINK="http://ffmpeg.org/doxygen/trunk/libstagefright_8cpp-source.html" MODIFIED="1376277441332" TEXT="H/W accelerated H.264 decoding"/>
<node CREATED="1360853912844" ID="ID_1857807980" LINK="http://vec.io/tags/ffmpeg#toc-mediasource" MODIFIED="1360886531549" TEXT="is the most simple start point"/>
<node CREATED="1360853979525" ID="ID_1047895082" LINK="#ID_1653600892" MODIFIED="1360854029235" TEXT="But look out, don&apos;t use it in production code, it&apos;s full of bugs."/>
<node CREATED="1360118959046" ID="ID_953316635" LINK="http://stackoverflow.com/questions/10438978/linker-errors-when-trying-to-enable-ffmpeg-stagefright-support" MODIFIED="1362832749156" TEXT="I don&apos;t recommend you use the libstagefright.cpp in ffmpeg"/>
<node CREATED="1360853903409" FOLDED="true" ID="ID_583560245" MODIFIED="1376031858125" TEXT="to understand the concepts">
<node CREATED="1360886915946" FOLDED="true" LINK="http://code.metager.de/source/xref/ffmpeg/libavcodec/avcodec.h#3275" MODIFIED="1376031857281" TEXT="AVCodec">
<node CREATED="1360887096034" MODIFIED="1360932552934" TEXT="Stagefright_init">
<icon BUILTIN="help"/>
</node>
<node CREATED="1360887137212" MODIFIED="1362833812564" TEXT="Stagefright_decode_frame">
<icon BUILTIN="help"/>
</node>
<node CREATED="1360887152477" MODIFIED="1362833815588" TEXT="Stagefright_close">
<icon BUILTIN="help"/>
</node>
<node CREATED="1362833845636" MODIFIED="1362833848844" TEXT="StagefrightContext">
<icon BUILTIN="help"/>
</node>
<node CREATED="1362833780544" MODIFIED="1362833790668" TEXT="ff_libstagefright_h264_decoder">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1360886480167" MODIFIED="1362832855157" TEXT="code reading"/>
</node>
<node CREATED="1357286601234" FOLDED="true" ID="ID_352583290" LINK="http://blog.csdn.net/huibailingyu/article/details/7569710" MODIFIED="1376278759794" TEXT=" FFmpeg&#x4e2d;libstagefright.cpp&#x7684;&#x8ba4;&#x8bc6;">
<node CREATED="1357287226531" MODIFIED="1360886753119" TEXT="how"/>
<node CREATED="1357286637062" MODIFIED="1357286638718" TEXT="&#x5b83;&#x63d0;&#x4f9b;&#x4e86;&#x4e00;&#x79cd;FFmpeg&#x8c03;&#x7528;StageFright&#x4e2d;&#x786c;&#x89e3;&#x7801;&#x7684;&#x9014;&#x5f84;"/>
<node CREATED="1362832918052" ID="ID_402829297" MODIFIED="1362832919878" TEXT="&#x4f60;&#x662f;&#x600e;&#x4e48;&#x8c03;&#x7528;ffmpeg&#x4e2d;libstagefright.cpp&#x4e2d;&#x63a5;&#x53e3;&#x7684;&#x5462;"/>
<node CREATED="1362833048699" MODIFIED="1362833051132" TEXT="&#x5176;&#x5b9e;&#x662f;&#x4f7f;&#x7528;&#x4e86;stagefright&#x4e2d;&#x7684;&#x786c;&#x4ef6;&#x89e3;&#x7801;&#x6a21;&#x5757;"/>
<node CREATED="1362833065888" MODIFIED="1362833068268" TEXT="&#x5b83;&#x628a;&#x5177;&#x4f53;&#x7684;&#x529f;&#x80fd;&#x5c01;&#x88c5;&#x6210;&#x51fd;&#x6570;&#x4e86;"/>
<node CREATED="1362833118031" MODIFIED="1362833390768" TEXT="&#x6240;&#x4ee5;&#x4f60;&#x60f3;&#x7528;&#x786c;&#x4ef6;&#x89e3;&#x7801;&#xff0c;&#x53ea;&#x8981;&#x5728;&#x914d;&#x7f6e;ffmpeg&#x7684;&#x65f6;&#x5019;&#xff0c;&#x5f00;&#x542f;&#x8fd9;&#x4e2a;&#x529f;&#x80fd;"/>
<node CREATED="1362833131424" MODIFIED="1362833132976" TEXT="&#x76ee;&#x524d;&#x53ea;&#x652f;&#x6301;mp4&#x5427;"/>
<node CREATED="1362833271121" MODIFIED="1365890950340" TEXT="stagefright&#x7684;&#x76ee;&#x5f55;&#x91cc;&#x9762;&#x4e0d;&#x662f;&#x6709;TI&#x7684;&#x786c;&#x89e3;&#x7801;&#x63a5;&#x53e3;&#x5417;&#xff0c;&#x4eff;&#x7167;&#x4ed6;&#x7684;&#x6765;&#x505a;">
<icon BUILTIN="help"/>
</node>
<node CREATED="1362833291032" MODIFIED="1362833880108" TEXT="&#x786c;&#x89e3;&#x7801;&#x5668;&#x5382;&#x5546;&#x4e5f;&#x4f1a;&#x7ed9;&#x76f8;&#x5e94;&#x7684;API&#x63a5;&#x53e3;&#x51fa;&#x6765;&#x7684;">
<icon BUILTIN="help"/>
</node>
<node CREATED="1362833904547" MODIFIED="1362833908604" TEXT="&#x5982;&#x679c;&#x60f3;&#x5b9e;&#x73b0;&#x786c;&#x89e3;&#x7801;&#xff0c;&#x9700;&#x8981;&#x600e;&#x4e48;&#x4f7f;&#x7528;libstagefright">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1376142528465" ID="ID_1558181175" LINK="https://github.com/FFmpeg/FFmpeg/blob/master/libavcodec/libstagefright.cpp" MODIFIED="1376142544637" TEXT="github.com"/>
</node>
<node CREATED="1361156492921" ID="ID_1597875166" LINK="http://iamkcspa.pixnet.net/blog/post/39502968" MODIFIED="1361156515562" TEXT="Stagefright&#x4e2d;&#x662f;&#x5982;&#x4f55;&#x548c;OMX video decoder&#x50b3;&#x905e;buffer"/>
<node CREATED="1362922721412" FOLDED="true" ID="ID_1446780102" LINK="http://www.360doc.com/content/11/1019/09/11192_157350357.shtml" MODIFIED="1412247124904" TEXT="OpenMax&#x5728;Android&#x4e0a;&#x7684;&#x5be6;&#x73fe;">
<node CREATED="1363399675724" FOLDED="true" ID="ID_1493334958" LINK="http://www.360doc.com/content/11/1019/09/11192_157350357.shtml" MODIFIED="1412247124903" TEXT="elements">
<node CREATED="1363399646870" MODIFIED="1363399649040" TEXT="client"/>
<node CREATED="1363399635973" MODIFIED="1363399671554" TEXT="component"/>
<node CREATED="1363399684965" ID="ID_137894770" MODIFIED="1363399686545" TEXT="core"/>
<node CREATED="1363399687045" FOLDED="true" ID="ID_133980210" MODIFIED="1412247124903" TEXT="port">
<node CREATED="1412246897688" FOLDED="true" ID="ID_1825283207" MODIFIED="1412247124903" TEXT="OMX_PARAM_PORTDEFINITIONTYPE">
<node CREATED="1412246919512" ID="ID_1210850994" LINK="http://goo.gl/U26Ny7" MODIFIED="1412246929842" TEXT="component&#x7684;&#x914d;&#x7f6e;&#x4fe1;&#x606f;"/>
</node>
</node>
</node>
</node>
<node CREATED="1362923417725" ID="ID_835059577" LINK="http://www.360doc.com/content/10/1221/10/474846_79985742.shtml" MODIFIED="1362923478008" TEXT="stagefright and OpenMax is on different process"/>
<node CREATED="1365890882510" FOLDED="true" ID="ID_836387282" MODIFIED="1376216045196" TEXT="examples">
<node CREATED="1361059569574" FOLDED="true" ID="ID_467536618" MODIFIED="1412247124904" TEXT="VLC">
<node CREATED="1361059534795" ID="ID_834891733" LINK="http://www.videolan.org/developers/vlc/modules/codec/omxil/iomx.cpp" MODIFIED="1361059564181" TEXT="iomx.cpp"/>
</node>
<node CREATED="1362833271121" ID="ID_794113599" LINK="#ID_1445108702" MODIFIED="1365890950340" TEXT="stagefright&#x7684;&#x76ee;&#x5f55;&#x91cc;&#x9762;&#x4e0d;&#x662f;&#x6709;TI&#x7684;&#x786c;&#x89e3;&#x7801;&#x63a5;&#x53e3;&#x5417;&#xff0c;&#x4eff;&#x7167;&#x4ed6;&#x7684;&#x6765;&#x505a;">
<icon BUILTIN="help"/>
</node>
</node>
<node CREATED="1367763475373" FOLDED="true" ID="ID_1424871982" LINK="http://elinux.org/images/5/52/Elc2011_garcia.pdf" MODIFIED="1412247124904" TEXT="Integrating a Hardware Video Codec into Android Stagefright using OpenMAX IL">
<node CREATED="1410043805056" FOLDED="true" ID="ID_1437708079" MODIFIED="1412247124904" TEXT="Bypassing default renderer">
<node CREATED="1410043824853" ID="ID_1072882532" MODIFIED="1410043825958" TEXT="H/W scaling"/>
<node CREATED="1410043837576" ID="ID_1021272440" MODIFIED="1410043838800" TEXT="color conversion"/>
</node>
</node>
<node CREATED="1410602561758" FOLDED="true" ID="ID_784224217" LINK="http://goo.gl/g5M2wG" MODIFIED="1412247101274" TEXT="Android 2.3 StageFright &#x5982;&#x4f55;&#x9078;&#x5b9a; OMX &#x5143;&#x4ef6;&#x7684;">
<node CREATED="1410610838495" FOLDED="true" ID="ID_726182959" MODIFIED="1412247124905" TEXT="command line">
<node CREATED="1410610887366" ID="ID_734956084" LINK="http://goo.gl/gq77bq" MODIFIED="1410610899963" TEXT=" if you have rooted your device"/>
</node>
<node CREATED="1410610587105" ID="ID_996094553" LINK="#ID_452374154" MODIFIED="1410610952862" TEXT="command line "/>
</node>
<node CREATED="1369387287062" FOLDED="true" ID="ID_855637781" LINK="http://stackoverflow.com/questions/13971966/openmax-and-the-ndk-where-i-can-get-the-surface" MODIFIED="1412247088882" TEXT="OpenMAX and the NDK: Where I can get the surface?">
<node CREATED="1369387318437" ID="ID_71614851" MODIFIED="1369387319375" TEXT="The surface is retrieved from the SurfaceHolder "/>
<node CREATED="1369387331203" ID="ID_1119738810" MODIFIED="1369387332921" TEXT="that is passed in as a parameter in the methods in SurfaceHolder.Callback"/>
</node>
<node CREATED="1376276650424" FOLDED="true" ID="ID_847901010" LINK="http://iamkcspa.pixnet.net/blog/post/39465784" MODIFIED="1412247124905" TEXT="Stagefright (2) - &#x548c;OpenMAX&#x7684;&#x904b;&#x4f5c;">
<node CREATED="1376276818279" ID="ID_702464107" MODIFIED="1376276819271" TEXT="Stagefright&#x548c;OMX&#x662f;&#x5982;&#x4f55;&#x904b;&#x4f5c;"/>
<node CREATED="1376276829495" ID="ID_1373410022" MODIFIED="1376276830456" TEXT="OMX_Init"/>
<node CREATED="1376276842799" ID="ID_242020693" MODIFIED="1376276843534" TEXT="OMX_SendCommand"/>
<node CREATED="1376276855295" ID="ID_1747051880" MODIFIED="1376276856054" TEXT="&#x5176;&#x4ed6;&#x4f5c;&#x7528;&#x5728; OMX &#x5143;&#x4ef6;&#x7684;&#x6307;&#x4ee4;"/>
<node CREATED="1376276901303" ID="ID_1281590454" MODIFIED="1376276902286" TEXT="Callback Functions"/>
</node>
<node CREATED="1410914886141" FOLDED="true" ID="ID_1297223029" LINK="http://goo.gl/3h8bsF" MODIFIED="1412247124905" TEXT="android&#x4e2d;&#x7528;openmax&#x6765;&#x5e72;&#x5565;&#xff1f;">
<node CREATED="1410965682482" ID="ID_1475147099" MODIFIED="1410965684708" TEXT="openmax&#x63a5;&#x53e3;&#x8bbe;&#x8ba1;&#x4e2d;&#xff0c;&#x4ed6;&#x4e0d;&#x5149;&#x80fd;&#x7528;&#x6765;&#x5f53;&#x7f16;&#x89e3;&#x7801;&#x3002;"/>
<node CREATED="1410965545942" FOLDED="true" ID="ID_72473181" MODIFIED="1412247084802" TEXT="&#x4e3a;&#x4ec0;&#x4e48;android&#x53ea;&#x7528;&#x4ed6;&#x6765;&#x505a;code">
<node CREATED="1410965579033" ID="ID_342583735" MODIFIED="1410965580078" TEXT="&#x5c06;&#x82af;&#x7247;&#x4e2d;DSP&#x786c;&#x4ef6;&#x7f16;&#x89e3;&#x7801;&#x7684;&#x80fd;&#x529b;&#x901a;&#x8fc7;openmax&#x6807;&#x51c6;&#x63a5;&#x53e3;&#x5448;&#x73b0;&#x51fa;&#x6765;"/>
<node CREATED="1410965633064" ID="ID_712719988" MODIFIED="1410965634010" TEXT="&#x5927;&#x591a;&#x6570;&#x7684;&#x5bb9;&#x5668;&#x683c;&#x5f0f;&#x7684;&#x5206;&#x89e3;&#x662f;&#x4e0d;&#x9700;&#x8981;&#x901a;&#x8fc7;&#x786c;&#x4ef6;&#x6765;&#x652f;&#x6301;&#x3002;"/>
<node CREATED="1410965655775" ID="ID_1908225569" MODIFIED="1410965656626" TEXT="&#x97f3;&#x89c6;&#x9891;&#x8f93;&#x51fa;&#x90e8;&#x5206;video\audio output &#x8fd9;&#x5757;&#x548c;&#x64cd;&#x4f5c;&#x7cfb;&#x7edf;&#x5173;&#x7cfb;&#x5341;&#x5206;&#x7d27;&#x5bc6;&#x3002;"/>
</node>
<node CREATED="1410965763346" ID="ID_1862991208" MODIFIED="1410965764159" TEXT="android&#x4e2d;openmax&#x5b9e;&#x73b0;&#x6846;&#x67b6;"/>
<node CREATED="1410965901134" ID="ID_1914442176" MODIFIED="1410965901939" TEXT="OMX&#x628a;&#x8f6f;&#x7f16;&#x89e3;&#x7801;&#x548c;&#x786c;&#x4ef6;&#x7f16;&#x89e3;&#x7801;&#x7edf;&#x4e00;&#x770b;&#x4f5c;&#x63d2;&#x4ef6;&#x7684;&#x5f62;&#x5f0f;&#x7ba1;&#x7406;&#x8d77;&#x6765;&#x3002;"/>
</node>
</node>
<node CREATED="1354587164171" ID="ID_1595722474" LINK="http://goo.gl/CpkYd5" MODIFIED="1412247040674" POSITION="left" TEXT="OMXCodec">
<node CREATED="1360840936013" ID="ID_1878969878" LINK="https://vec.io/tags/ffmpeg#toc-mediasource" MODIFIED="1376236768601" TEXT="a child class of MediaSource"/>
<node CREATED="1411963364130" ID="ID_1086698097" LINK="http://goo.gl/9TDs0m" MODIFIED="1411963380145" TEXT="a subclass inheriting from MediaSource and MediaBufferObserver"/>
<node CREATED="1360839971346" ID="ID_609308199" MODIFIED="1360839974047" TEXT="do the actual decoding work"/>
<node CREATED="1362822725910" ID="ID_101153906" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=2&amp;cad=rja&amp;ved=0CEQQFjAB&amp;url=http%3A%2F%2Felinux.org%2Fimages%2F5%2F52%2FElc2011_garcia.pdf&amp;ei=mvQ6UaHHGuyQiAfGwIDgCA&amp;usg=AFQjCNF0iLKneBfuhJ7UsgJ8pRs6sFDE9Q&amp;sig2=rSn7Qu5JOFokmzcOTJ9p3A" MODIFIED="1413291416009" TEXT="OMXCodec"/>
<node CREATED="1360840665420" ID="ID_930993150" LINK="http://vec.io/tags/ffmpeg#toc-mediasource" MODIFIED="1360840683343" TEXT="to use the OMXCodec class in our own NDK code"/>
<node CREATED="1356616869273" FOLDED="true" ID="ID_823475082" LINK="http://vec.io/tags/ffmpeg" MODIFIED="1376272999288" TEXT="Use Android Hardware Decoder with OMXCodec in NDK">
<icon BUILTIN="info"/>
<node CREATED="1356658393875" MODIFIED="1356658396593" TEXT="Different color space used in the decoded frames"/>
<node CREATED="1356658409437" MODIFIED="1356658411312" TEXT="it&apos;s best to find those information from CyanogenMod&apos;s source code"/>
<node CREATED="1356660480187" MODIFIED="1376042416289" TEXT="the FFmpeg code I used, it&apos;s the patched version from VPlayer for Android">
<node CREATED="1356660518109" LINK="https://github.com/yixia/FFmpeg-Android" MODIFIED="1356660531890" TEXT="yixia / FFmpeg-Android"/>
</node>
<node CREATED="1373757768154" MODIFIED="1373757770336" TEXT="standalone toolchain"/>
</node>
<node CREATED="1362822018053" ID="ID_811020692" LINK="https://www.google.com.tw/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=2&amp;cad=rja&amp;ved=0CEQQFjAB&amp;url=http%3A%2F%2Felinux.org%2Fimages%2F5%2F52%2FElc2011_garcia.pdf&amp;ei=mvQ6UaHHGuyQiAfGwIDgCA&amp;usg=AFQjCNF0iLKneBfuhJ7UsgJ8pRs6sFDE9Q&amp;sig2=rSn7Qu5JOFokmzcOTJ9p3A" MODIFIED="1376273001672" TEXT="componet registration">
<node CREATED="1362822131377" ID="ID_1755939705" MODIFIED="1362822158348" TEXT="update component in OMXCodec.cpp"/>
<node CREATED="1413293041988" ID="ID_1353579728" LINK="#ID_965979074" MODIFIED="1413293082684" TEXT="Codec name must start with &#x201c; OMX. &#x201d;"/>
<node CREATED="1413293103778" ID="ID_959520332" LINK="#ID_965979074" MODIFIED="1413293118260" TEXT="so Stagefright knows it&#x2019;s an external codec"/>
</node>
<node CREATED="1362822795598" ID="ID_1260917926" MODIFIED="1362822797939" TEXT="configureCodec"/>
<node CREATED="1362822785842" ID="ID_1289710607" MODIFIED="1362822786956" TEXT="getComponentQuirks "/>
<node CREATED="1410042550899" ID="ID_1799312078" MODIFIED="1410042552332" TEXT="Create">
<node CREATED="1413291182831" ID="ID_640599546" LINK="http://goo.gl/Ev2tx1" MODIFIED="1413291196918" TEXT="&#x89e3;&#x7801;&#x5668;&#x7684;&#x7c7b;&#x578b;&#xff0c;&#x4f60;&#x53ef;&#x4ee5;&#x5728;&#x8fd9;&#x91cc;&#x5c06;&#x89e3;&#x7801;&#x5668;&#x6307;&#x5b9a;&#x4e3a;&#x8f6f;&#x89e3;&#x7801;"/>
<node CREATED="1413291411711" ID="ID_557216307" MODIFIED="1413291412869" TEXT="InstantiateSoftwareEncoder"/>
<node CREATED="1413291921432" ID="ID_933254066" MODIFIED="1413291922342" TEXT="findMatchingCodecs"/>
</node>
<node CREATED="1410965814099" ID="ID_476001194" LINK="http://goo.gl/3h8bsF" MODIFIED="1410965827602" TEXT="&#x901a;&#x8fc7;IOMX &#x4f9d;&#x8d56;binder&#x673a;&#x5236; &#x83b7;&#x5f97; OMX&#x670d;&#x52a1;"/>
<node CREATED="1410965843522" ID="ID_911478888" LINK="http://goo.gl/3h8bsF" MODIFIED="1410965856663" TEXT="OMX&#x670d;&#x52a1; &#x624d;&#x662f;openmax &#x5728;android&#x4e2d; &#x5b9e;&#x73b0;&#x3002;"/>
<node CREATED="1412247044303" ID="ID_386088499" MODIFIED="1412247045238" TEXT="allocateBuffersOnPort">
<node CREATED="1412247063048" ID="ID_1453013954" MODIFIED="1412247063871" TEXT="&#x7684;&#x53c2;&#x6570;&#x4ece;&#x54ea;&#x91cc;&#x6765;&#x5462;&#xff1f;&#x539f;&#x6765;&#x6765;&#x81ea;&#x89e3;&#x7801;&#x5668;&#x7aef;"/>
</node>
</node>
</node>
</map>

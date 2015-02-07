Proton cross platform 3D engine open source
=================
1.
Proton 3d engine impelement Irrlicht and Bullet Physics with OpenGL ES1.0 ES2.0

You can build on Win32, MacOS, Android, Ios

All platform play music and sound easily

2.
There is no OGLES1 OGLES2 texture loss problem on Android resume screen

3.
First run need

On Win32, Android --->

xxxxxx/media/update_media.bat

On MacOs, Ios --->

chmod 777 xxxxxx/media/update_media.sh

xxxxxx/media/update_media.sh

3.
If debug NDK c++ on Android, please set

android:installLocation="internalOnly" of AndroidManifest.xml

4.
Switch between OGLES1 and OGLES2

(a.) Find in App.cpp

return irr::video::EDT_OGLES1;

-> return irr::video::EDT_OGLES2;

(b.) Find in SharedActivity.java (Android need only)

//setEGLContextClientVersion(2); 

-> setEGLContextClientVersion(2);

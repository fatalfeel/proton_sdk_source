Proton cross platform 3D engine open source
=================
1.

(a.)
Proton 3d engine implement Irrlicht and Bullet Physics with OpenGL ES1.0 ES2.0

(b.)
Full open source

(c.)
You can build on Win32, MacOS, Android, Ios

(d.)
All platform can play music and sound easily

(e.)
GLSL shading language full control

2.

There is no OpenGLES1、2 texture loss problem after resume process on Android

3.

First run need to do

On Win32 or Android --->

xxxxxx/media/update_media.bat

On MacOs or Ios --->

chmod 777 xxxxxx/media/update_media.sh

xxxxxx/media/update_media.sh

4.

Switch between OGLES1 and OGLES2

(a.) Find in App.cpp

return irr::video::EDT_OGLES1;

-> return irr::video::EDT_OGLES2;

(b.) Find in SharedActivity.java (Android need only)

//setEGLContextClientVersion(2); 

-> setEGLContextClientVersion(2);

5.
When debug NDK c++ on Android, please set

android:installLocation="internalOnly" of AndroidManifest.xml

6. 
Enable or Disable Gui

Find define _IRR_COMPILE_WITH_GUI_ of IrrCompileConfig.h

Enable or disable it, will use irrlicht GUI or not

7.
Demo screenshots

(a) https://github.com/fatalfeel/proton_sdk_source/tree/master/DemoPicture

(b) https://plus.google.com/photos/106185541018774360364/albums/5964765088859640225

8.
Demo videos

(a) Proton 3D demos on Android by Seth

https://www.youtube.com/watch?v=nP40CUnBohY

(a) Irrlicht 3D + Cocos2D on IOS by Mun

https://www.youtube.com/watch?v=BIEafKA2IBM

9.
The Brother site combine cocos2d https://github.com/fatalfeel/proton_cm_open
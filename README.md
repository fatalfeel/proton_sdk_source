Proton cross platform 3D engine open source
=================
1.

(a.)
Proton 3d engine implement Irrlicht Engine and Bullet Physics with OpenGL ES1.0 ES2.0

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
First run need to do. (Take care of CR line ending in linux system)

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

(b.) public AppGLSurfaceView(Context context, SharedActivity _app) in SharedActivity.java

//setEGLContextClientVersion(2); 

-> setEGLContextClientVersion(2);

5.
When debug NDK c++ on Android, please set

android:installLocation="internalOnly" of AndroidManifest.xml

and Android firmware need unlock s-on to s-off.

6.
Demo screenshots

(a) https://github.com/fatalfeel/proton_sdk_source/tree/master/DemoPicture

(b) https://plus.google.com/photos/106185541018774360364/albums/5964765088859640225

7.
Demo video

Proton 3D demos on Android by Seth

https://www.youtube.com/watch?v=nP40CUnBohY

8.
The brother site with cocos2dx gui menu

https://github.com/fatalfeel/proton_cm_open

9.
Any bugs or questions please click github's [Issues] -> [New issue]

Post message, I will be there help you.

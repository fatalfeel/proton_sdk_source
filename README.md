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

Before download take care of carriage return in source files

3.
First run need to do.

(a)***Win32 or Android***

xxxxxx/media/update_media.bat

(b)***MacOs or Ios***

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

(b) https://goo.gl/photos/4HMcf4kp5opfticj9

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

10.
Product demo

https://apkpure.com/ihala/com.alphainfo.ihala

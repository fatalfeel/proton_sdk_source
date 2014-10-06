Cross Platform 3D engine with OpenGL OGLES1 OGLES2 on Proton
=================
1.
Proton 3d engine impelement irrlicht 1.9.0 with OGLES1.0, OGLES2.0 and OpenGL
You can build on Win32, MacOS, Android, Ios
-----------------
2.
Rember first run

On Win32 --->
xxxxxx/media/update_media.bat

On MacOs --->
chmod 777 xxxxxx/media/update_media.sh

xxxxxx/media/update_media.sh
=================
3.
If debug c++ in Android, please set
android:installLocation="internalOnly" of AndroidManifest.xml
=================
4.
Switch OGLES1 -> OGLES2

(a.) find App.cpp
irr::video::E_DRIVER_TYPE AppGetOGLESType()
return irr::video::EDT_OGLES1; -> return irr::video::EDT_OGLES2;

(b.) find SharedActivity.java
public AppGLSurfaceView(Context context, SharedActivity _app)
//setEGLContextClientVersion(2); -> setEGLContextClientVersion(2);
=================
5.
Quake, QuakeShader samples have a small problem.
when android resume process and reload texture, can not find image correctly.
because "maps/20kdm2.bsp.lightmap.0~10" can not find in resource path, they are packed into 20kdm2.bsp.
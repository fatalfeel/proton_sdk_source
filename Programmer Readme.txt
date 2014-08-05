1.
Proton 3d engine impelement irrlicht 1.9.0 with OGLES1.0, OGLES2.0 and OpenGL
You can build on Win32, MacOS, Android, Ios

1.
For the documentation, tutorials, wiki, and forums, please visit:
www.protonsdk.com
-Seth (seth@rtsoft.com)

2.
If debug ndk c++ please set
android:installLocation="internalOnly" of AndroidManifest.xml

3.
Rember first run
On Win32
xxxxxx/media/update_media.bat
&
On MacOs
chmod 777 xxxxxx/media/update_media.sh
xxxxxx/media/update_media.sh

4.
Switch OGLES1 -> OGLES2
a. find c++
irr::video::E_DRIVER_TYPE AppGetOGLESType()
return irr::video::EDT_OGLES1; -> return irr::video::EDT_OGLES2;
b. find java
public AppGLSurfaceView(Context context, SharedActivity _app)
//setEGLContextClientVersion(2); -> setEGLContextClientVersion(2);

5.
Quake, QuakeShader samples have a bug
when reload, can not find correct texture path name.
because "maps/20kdm2.bsp.lightmap.0~10" are packed into 20kdm2.bsp.


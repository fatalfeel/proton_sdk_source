To make this android stuff work (from Windows) you'll have to:

* Install the Java JDK and make sure it's your active java install )
* Install the Android SDK
* Install the Crystax Android NDK version (includes full stl)
* Install Ant (windows version)
* Install Cygwin with development stuff

* Set Windows environmental var CYGWIN_DIR to your base cygwin directory
* Put your android ndk dir in the path
* Put your android-sdk-windows/tools dir in your path
* Edit app_info_setup.bat and set the variables up if different, note that you can set the emulator AVD to load
* Edit local.properties and set the path
* Edit build.sh and edit the path

Phew!  If everything is done right, build.bat will make everything, start the emulator and install it.  Run ViewLog.bat to see the device log.
call app_info_setup.bat
adb wait-for-device -s %ANDROID_DEVICE2%
adb -s %ANDROID_DEVICE2% install -r bin\%APP_NAME%-debug.apk
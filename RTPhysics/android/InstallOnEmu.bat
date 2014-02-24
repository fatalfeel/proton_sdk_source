call app_info_setup.bat
adb wait-for-device -s emulator-5554
adb -s emulator-5554 install -r bin\%APP_NAME%-debug.apk
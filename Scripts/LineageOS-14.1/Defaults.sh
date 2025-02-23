#!/bin/bash
#DivestOS: A privacy focused mobile distribution
#Copyright (c) 2017-2018 Divested Computing Group
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <https://www.gnu.org/licenses/>.
umask 0022;
set -euo pipefail;
source "$DOS_SCRIPTS_COMMON/Shell.sh";

#Changes various default settings
#Last verified: 2021-10-16

#Useful commands
#nano $(find . -name "config.xml" | grep "values/" | grep -v "device" | grep -v "tests")
#nano $(find . -name "defaults.xml" | grep "values/" | grep -v "device")

echo "Changing default settings...";

#if enter "frameworks/base"; then
#sed -i 's/CMPRIVACY_GUARD_NOTIFICATION, 1/CMPRIVACY_GUARD_NOTIFICATION, 0/' services/core/java/com/android/server/am/ActivityStack.java;
#sed -i 's/VOLBTN_MUSIC_CONTROLS, 1/VOLBTN_MUSIC_CONTROLS, 0/' services/core/java/com/android/server/policy/PhoneWindowManager.java; #FIXME
#sed -i 's/VOLUME_KEYS_CONTROL_RING_STREAM, 1/VOLUME_KEYS_CONTROL_RING_STREAM, 0/' services/core/java/com/android/server/audio/AudioService.java; #FIXME
#sed -i 's/TORCH_LONG_PRESS_POWER_GESTURE, 0/TORCH_LONG_PRESS_POWER_GESTURE, 1/' services/core/java/com/android/server/policy/PhoneWindowManager.java; #FIXME
#sed -i 's/TORCH_LONG_PRESS_POWER_TIMEOUT, 0/TORCH_LONG_PRESS_POWER_TIMEOUT, 120/' services/core/java/com/android/server/policy/PhoneWindowManager.java; #FIXME
#sed -i 's/CAMERA_DOUBLE_TAP_POWER_GESTURE_DISABLED, 0/CAMERA_DOUBLE_TAP_POWER_GESTURE_DISABLED, 1/' services/core/java/com/android/server/GestureLauncherService.java; #FIXME
#sed -i 's/NAVIGATION_BAR_MENU_ARROW_KEYS, 0/NAVIGATION_BAR_MENU_ARROW_KEYS, 1/' packages/SystemUI/src/com/android/systemui/statusbar/phone/NavigationBarView.java; #FIXME
#fi;

if enter "packages/apps/Dialer"; then
sed -i 's/ENABLE_FORWARD_LOOKUP, 1)/ENABLE_FORWARD_LOOKUP, 0)/' src/com/android/dialer/*/LookupSettings*.java; #Disable FLP
sed -i 's/ENABLE_PEOPLE_LOOKUP, 1)/ENABLE_PEOPLE_LOOKUP, 0)/' src/com/android/dialer/*/LookupSettings*.java; #Disable PLP
sed -i 's/ENABLE_REVERSE_LOOKUP, 1)/ENABLE_REVERSE_LOOKUP, 0)/' src/com/android/dialer/*/LookupSettings*.java; #Disable RLP
fi;

if enter "packages/apps/Nfc"; then
sed -i 's/boolean NFC_ON_DEFAULT = true;/boolean NFC_ON_DEFAULT = false;/' src/com/android/nfc/NfcService.java; #Disable NFC
sed -i 's/boolean NDEF_PUSH_ON_DEFAULT = true;/boolean NDEF_PUSH_ON_DEFAULT = false;/' src/com/android/nfc/NfcService.java; #Disable NDEF Push
fi;

if enter "packages/apps/Settings"; then
sed -i 's/WEB_ACTION_ENABLED, 1/WEB_ACTION_ENABLED, 0/' src/com/android/settings/applications/ManageDomainUrls.java; #Disable "Instant Apps"
sed -i 's/Float.parseFloat(newValue.toString()) : 1;/Float.parseFloat(newValue.toString()) : 0.5f;/' src/com/android/settings/DevelopmentSettings.java; #Always reset animation scales to 0.5
fi;

if enter "vendor/cm"; then
sed -i 's/ro.config.notification_sound=Argon.ogg/ro.config.notification_sound=Pong.ogg/' config/common.mk;
sed -i 's/ro.config.alarm_alert=Hassium.ogg/ro.config.alarm_alert=Alarm_Buzzer.ogg/' config/common.mk;
fi;

cd "$DOS_BUILD_BASE";
echo -e "\e[0;32m[SCRIPT COMPLETE] Default settings changed\e[0m";

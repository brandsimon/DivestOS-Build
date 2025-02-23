#!/bin/bash
#DivestOS: A privacy focused mobile distribution
#Copyright (c) 2017-2021 Divested Computing Group
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

startPatcher() {
	java -jar "$DOS_BINARY_PATCHER" patch workspace "$DOS_BUILD_BASE" "$DOS_WORKSPACE_ROOT""Patches/Linux/" "$DOS_SCRIPTS_CVES" $1;
}
export -f startPatcher;

enter() {
	echo "================================================================================================"
	local dir="$1";
	local dirReal="$DOS_BUILD_BASE$dir";
	umask 0022;
	if [ -d "$dirReal" ]; then
		cd "$dirReal";
		echo -e "\e[0;32m[ENTERING] $dir\e[0m";
		return 0;
	else
		echo -e "\e[0;31m[ENTERING FAILED] $dir\e[0m";
		return 1;
	fi;
}
export -f enter;

enterAndClear() {
	if enter "$1"; then gitReset; else return 1; fi;
}
export -f enterAndClear;

gitReset() {
	git add -A && git reset --hard;
}
export -f gitReset;

applyPatchReal() {
	currentWorkingPatch=$1;
	firstLine=$(head -n1 "$currentWorkingPatch");
	if [[ "$firstLine" = *"Mon Sep 17 00:00:00 2001"* ]] || [[ "$firstLine" = *"Thu Jan  1 00:00:00 1970"* ]]; then
		if git am "$@"; then
			if [ "$DOS_REFRESH_PATCHES" = true ]; then
				if [[ "$currentWorkingPatch" == $DOS_PATCHES* ]]; then
					git format-patch -1 HEAD --zero-commit --no-signature --output="$currentWorkingPatch";
				fi;
			fi;
		fi;
	else
		git apply "$@";
		echo "Applying (as diff): $currentWorkingPatch";
	fi;
}
export -f applyPatchReal;

applyPatch() {
	currentWorkingPatch=$1;
	if [ -f "$currentWorkingPatch" ]; then
		if git apply --check "$@" &> /dev/null; then
			applyPatchReal "$@";
		else
			if git apply --reverse --check "$@" &> /dev/null; then
				echo "Already applied: $currentWorkingPatch";
			else
				if git apply --check "$@" --3way &> /dev/null; then
					applyPatchReal "$@" --3way;
					echo "Applied (as 3way): $currentWorkingPatch";
				else
					echo -e "\e[0;31mERROR: Cannot apply: $currentWorkingPatch\e[0m";
				fi;
			fi;
		fi;
	else
		echo -e "\e[0;31mERROR: Patch doesn't exist: $currentWorkingPatch\e[0m";
	fi;
}
export -f applyPatch;

gpgVerifyDirectory() {
	if [ -r "$HOME/.gnupg" ]; then
		for sig in $1/*.asc; do
			if gpg --verify $sig &>/dev/null; then
				echo -e "\e[0;32mGPG Verified Successfully: $sig\e[0m";
			else
				echo -e "\e[0;31mWARNING: GPG Verification Failed: $sig\e[0m";
				sleep 60;
			fi;
		done;
	else
		echo -e "\e[0;33mWARNING: ~/.gnupg is unavailable, GPG verification of $1 will not be performed!\e[0m";
	fi;
}
export -f gpgVerifyDirectory;

scanForMalware() {
	if [ -x /usr/bin/clamscan ] && [ -r /var/lib/clamav/main.c*d ]; then
		echo -e "\e[0;32mStarting a malware scan...\e[0m";
		local excludes="--exclude-dir=\".git\" --exclude-dir=\".repo\"";
		local scanQueue="$2";
		if [ "$1" = true ]; then
			if [ "$DOS_MALWARE_SCAN_SETTING" != "quick" ] || [ "$DOS_MALWARE_SCAN_SETTING" = "extra" ]; then
				scanQueue=$scanQueue" $DOS_BUILD_BASE/frameworks $DOS_BUILD_BASE/vendor";
			fi;
			if [ "$DOS_MALWARE_SCAN_SETTING" = "slow" ]; then
				scanQueue=$scanQueue"$DOS_BUILD_BASE/external $DOS_BUILD_BASE/prebuilts $DOS_BUILD_BASE/toolchain $DOS_BUILD_BASE/tools";
			fi;
			if [ "$DOS_MALWARE_SCAN_SETTING" = "full" ]; then
				scanQueue="$DOS_BUILD_BASE";
			fi;
		fi;
		du -hsc $scanQueue;
		/usr/bin/clamscan --recursive --detect-pua --infected --allmatch --max-filesize=4000M --max-scansize=4000M $excludes $scanQueue;
		local clamscanExit="$?";
		if [ "$clamscanExit" -eq "1" ]; then
			echo -e "\e[0;31m----------------------------------------------------------------\e[0m";
			echo -e "\e[0;31mWARNING: MALWARE WAS FOUND! PLEASE INVESTIGATE!\e[0m";
			echo -e "\e[0;31m----------------------------------------------------------------\e[0m";
			echo -e "\e[0;33mFalse positives such as the following are probably OK\e[0m";
			echo -e "\e[0;33mPUAs: Ewind, Mobidash\e[0m";
			echo -e "\e[0;31m----------------------------------------------------------------\e[0m";
			sleep 60;
		fi;
		if [ "$clamscanExit" -eq "0" ]; then
			echo -e "\e[0;32mNo malware found\e[0m";
		fi;
		if [ "$clamscanExit" -eq "2" ]; then
			echo -e "\e[0;33m----------------------------------------------------------------\e[0m";
			echo -e "\e[0;33mWARNING: AN ERROR OCCURED. PLEASE INVESTIGATE!\e[0m";
			echo -e "\e[0;33m----------------------------------------------------------------\e[0m";
			sleep 60;
		fi;
	else
		echo -e "\e[0;33mWARNING: clamscan is unavailable, a malware scan will not be performed!\e[0m";
	fi;
}
export -f scanForMalware;

generateBootAnimationMask() {
	local text=$1;
	local font=$2
	local output=$3;
	convert -background black -fill transparent -font "$font" -gravity center -size 512x128 label:"$text" "$output";
	#optipng "$output"; #XXX: breaks boot animation on 14.1?
}
export -f generateBootAnimationMask;

generateBootAnimationShine() {
	local color=$1;
	local style=$2;
	local output=$3;
	#The colors need to be symmetrical in order to make the animation smooth and not have any noticble lines
	convert -size 1024x128 -define gradient:angle=90 "$style":"$color" \( +clone -flop \) +append "$output";
	#optipng "$output";
}
export -f generateBootAnimationShine;

audit2allowCurrent() {
	adb logcat -b all -d | audit2allow -p "$OUT"/root/sepolicy;
}
export -f audit2allowCurrent;

audit2allowADB() {
	adb pull /sys/fs/selinux/policy;
	adb logcat -b all -d | audit2allow -p policy;
}
export -f audit2allowADB;

processRelease() {
	#Reference (MIT): GrapheneOS
	#https://github.com/GrapheneOS/script/blob/10/release.sh
	local DEVICE="$1";
	local BLOCK="$2";
	local VERITY="$3";

	local DATE=$(date -u '+%Y%m%d')
	local KEY_DIR="$DOS_SIGNING_KEYS/$DEVICE";
	local VERSION=$(echo $DOS_VERSION | cut -f2 -d "-");
	local PREFIX="$DOS_BRANDING_ZIP_PREFIX-$VERSION-$DATE-dos-$DEVICE";
	local ARCHIVE="$DOS_BUILDS/$DOS_VERSION/release_keys/";
	local OUT_DIR="$DOS_BUILD_BASE/out/target/product/$DEVICE/";

	local RELEASETOOLS_PREFIX="build/tools/releasetools/";
	if [[ "$DOS_VERSION" == "LineageOS-18.1" ]] || [[ "$DOS_VERSION" == "LineageOS-19.1" ]]; then
		local RELEASETOOLS_PREFIX="";
	fi;

	umask 0022;

	echo -e "\e[0;32mProcessing release for $DEVICE\e[0m";

	#Arguments
	if [ "$BLOCK" != false ]; then
		local BLOCK_SWITCHES="--block";
	fi;
	if [[ "$VERITY" == "verity" ]]; then
		local VERITY_SWITCHES=(--replace_verity_public_key "$KEY_DIR/verity_key.pub" \
			--replace_verity_private_key "$KEY_DIR/verity" \
			--replace_verity_keyid "$KEY_DIR/verity.x509.pem");
		echo -e "\e[0;32m\t+ Verified Boot 1.0\e[0m";
	elif [[ "$VERITY" == "avb" ]]; then
		local AVB_PKMD="$KEY_DIR/avb_pkmd.bin";
		local VERITY_SWITCHES=(--avb_vbmeta_key "$KEY_DIR/avb.pem" --avb_vbmeta_algorithm SHA256_RSA4096);
		echo -e "\e[0;32m\t+ Verified Boot 2.0 with VBMETA and NOCHAIN\e[0m";
	fi;
	if [[ "$DOS_VERSION" == "LineageOS-17.1" ]] || [[ "$DOS_VERSION" == "LineageOS-18.1" ]] || [[ "$DOS_VERSION" == "LineageOS-19.1" ]]; then
		local APEX_SWITCHES=(--extra_apks com.android.adbd.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.adbd.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.apex.cts.shim.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.apex.cts.shim.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.appsearch.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.appsearch.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.art.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.art.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.art.debug.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.art.debug.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.cellbroadcast.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.cellbroadcast.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.conscrypt.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.conscrypt.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.extservices.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.extservices.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.i18n.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.i18n.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.ipsec.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.ipsec.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.media.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.media.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.media.swcodec.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.media.swcodec.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.mediaprovider.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.mediaprovider.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.neuralnetworks.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.neuralnetworks.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.os.statsd.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.os.statsd.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.permission.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.permission.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.resolv.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.resolv.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.runtime.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.runtime.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.scheduling.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.scheduling.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.sdkext.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.sdkext.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.tethering.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.tethering.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.tzdata.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.tzdata.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.vndk.current.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.vndk.current.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.wifi.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.wifi.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.google.pixel.camera.hal.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.google.pixel.camera.hal.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.vibrator.sunfish.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.vibrator.sunfish.apex="$KEY_DIR/avb.pem" \
			--extra_apks com.android.vibrator.drv2624.apex="$KEY_DIR/releasekey" \
			--extra_apex_payload_key com.android.vibrator.drv2624.apex="$KEY_DIR/avb.pem");
	fi;

	#Malware Scan
	if [ "$DOS_MALWARE_SCAN_BEFORE_SIGN" = true ]; then
		echo -e "\e[0;32mScanning files for malware before signing\e[0m";
		scanForMalware false $OUT_DIR/obj/PACKAGING/target_files_intermediates/*$DEVICE-target_files-*.zip;
	fi;

	#Target Files
	echo -e "\e[0;32mSigning target files\e[0m";
	"$RELEASETOOLS_PREFIX"sign_target_files_apks -o -d "$KEY_DIR" \
		--extra_apks OsuLogin.apk,ServiceConnectivityResources.apk,ServiceWifiResources.apk="$KEY_DIR/releasekey" \
		"${APEX_SWITCHES[@]}" \
		"${VERITY_SWITCHES[@]}" \
		$OUT_DIR/obj/PACKAGING/target_files_intermediates/*$DEVICE-target_files-*.zip \
		"$OUT_DIR/$PREFIX-target_files.zip";
	sha512sum "$OUT_DIR/$PREFIX-target_files.zip" > "$OUT_DIR/$PREFIX-target_files.zip.sha512sum";
	local INCREMENTAL_ID=$(grep "ro.build.version.incremental" $OUT_DIR/system/build.prop | cut -f2 -d "=" | sed 's/\.//g');
	echo "$INCREMENTAL_ID" > "$OUT_DIR/$PREFIX-target_files.zip.id";

	#Image
	unzip -l $OUT_DIR/$PREFIX-target_files.zip | grep -q recovery.img;
	local hasRecoveryImg="$?";
	if [ "$hasRecoveryImg" == "1" ]; then
		echo -e "\e[0;32mCreating fastboot image\e[0m";
		"$RELEASETOOLS_PREFIX"img_from_target_files "$OUT_DIR/$PREFIX-target_files.zip" \
			"$OUT_DIR/$PREFIX-fastboot.zip";
		sha512sum "$OUT_DIR/$PREFIX-fastboot.zip" > "$OUT_DIR/$PREFIX-fastboot.zip.sha512sum";
	fi

	#OTA
	echo -e "\e[0;32mCreating OTA\e[0m";
	"$RELEASETOOLS_PREFIX"ota_from_target_files $BLOCK_SWITCHES -k "$KEY_DIR/releasekey" \
		"$OUT_DIR/$PREFIX-target_files.zip" \
		"$OUT_DIR/$PREFIX-ota.zip";
	md5sum "$OUT_DIR/$PREFIX-ota.zip" > "$OUT_DIR/$PREFIX-ota.zip.md5sum";
	sha512sum "$OUT_DIR/$PREFIX-ota.zip" > "$OUT_DIR/$PREFIX-ota.zip.sha512sum";

	#Deltas
	if [ "$DOS_GENERATE_DELTAS" = true ]; then
		if [[ " ${DOS_GENERATE_DELTAS_DEVICES[@]} " =~ " ${DEVICE} " ]]; then
			for LAST_TARGET_FILES in $ARCHIVE/target_files/$DOS_BRANDING_ZIP_PREFIX-$VERSION-*-dos-$DEVICE-target_files.zip; do
				if [[ -f "$LAST_TARGET_FILES.id" ]]; then
					local LAST_INCREMENTAL_ID=$(cat "$LAST_TARGET_FILES.id");
					echo -e "\e[0;32mGenerating incremental OTA against $LAST_INCREMENTAL_ID\e[0m";
					#TODO: Verify GPG signature and checksum of previous target-files first!
					"$RELEASETOOLS_PREFIX"ota_from_target_files $BLOCK_SWITCHES -t 8 -k "$KEY_DIR/releasekey" -i \
						"$LAST_TARGET_FILES" \
						"$OUT_DIR/$PREFIX-target_files.zip" \
						"$OUT_DIR/$PREFIX-incremental_$LAST_INCREMENTAL_ID.zip";
					sha512sum "$OUT_DIR/$PREFIX-incremental_$LAST_INCREMENTAL_ID.zip" > "$OUT_DIR/$PREFIX-incremental_$LAST_INCREMENTAL_ID.zip.sha512sum";
				fi;
			done;
		fi;
	fi;

	#Extract signed recovery
	if [ "$hasRecoveryImg" == "0" ]; then
		echo -e "\e[0;32mExtracting signed recovery.img\e[0m";
		mkdir "$OUT_DIR/rec_tmp";
		unzip "$OUT_DIR/$PREFIX-target_files.zip" "IMAGES/recovery.img" -d "$OUT_DIR/rec_tmp";
		mv "$OUT_DIR/rec_tmp/IMAGES/recovery.img" "$OUT_DIR/$PREFIX-recovery.img";
		sha512sum "$OUT_DIR/$PREFIX-recovery.img" > "$OUT_DIR/$PREFIX-recovery.img.sha512sum";
	fi;

	#File name fixes
	sed -i "s|$OUT_DIR/||" $OUT_DIR/*.md5sum $OUT_DIR/*.sha512sum;
	sed -i 's/-ota\././' $OUT_DIR/*.md5sum $OUT_DIR/*.sha512sum;
	sed -i 's/-incremental_/-/' $OUT_DIR/*.md5sum $OUT_DIR/*.sha512sum;

	#GPG signing
	if [ "$DOS_GPG_SIGNING" = true ]; then
		for checksum in $OUT_DIR/*.sha512sum; do
			echo -e "\e[0;32mGPG signing $checksum\e[0m";
			if gpg --homedir "$DOS_SIGNING_GPG" --sign --local-user "$DOS_GPG_SIGNING_KEY" --clearsign "$checksum"; then
				mv -f "$checksum.asc" "$checksum";
			fi;
		done;
	fi;

	pkill java && sleep 10; #XXX: ugly hack

	#Copy to archive
	if [ "$DOS_AUTO_ARCHIVE_BUILDS" = true ]; then
		echo -e "\e[0;32mCopying files to archive\e[0m";
		mkdir -vp $ARCHIVE;
		mkdir -vp $ARCHIVE/target_files;
		mkdir -vp $ARCHIVE/fastboot;
		mkdir -vp $ARCHIVE/incrementals;

		if [[ " ${DOS_GENERATE_DELTAS_DEVICES[@]} " =~ " ${DEVICE} " ]]; then cp -v $OUT_DIR/$PREFIX-target_files.zip* $ARCHIVE/target_files/; fi;
		cp -v $OUT_DIR/$PREFIX-fastboot.zip* $ARCHIVE/fastboot/ || true;
		cp -v $OUT_DIR/$PREFIX-ota.zip* $ARCHIVE/;
		cp -v $OUT_DIR/$PREFIX-incremental_*.zip* $ARCHIVE/incrementals/ || true;
		cp -v $OUT_DIR/$PREFIX-recovery.img* $ARCHIVE/ || true;

		rename -- "-ota." "." $ARCHIVE/$PREFIX-ota.zip*;
		rename -- "-incremental_" "-" $ARCHIVE/incrementals/$PREFIX-incremental_*.zip*;
		sync;

		#Remove to make space for next build
		if [ "$DOS_REMOVE_AFTER" = true ]; then
			echo -e "\e[0;32mRemoving to reclaim space\e[0m";
			#TODO: add a sanity check
			rm -rf --one-file-system "$OUT_DIR";
			if [ "$DOS_REMOVE_AFTER_FULL" = true ]; then rm -rf --one-file-system "$DOS_BUILD_BASE/out"; fi; #clobber entire workspace
		fi;
	fi;

	sync;
	echo -e "\e[0;32mRelease processing complete\e[0m";
}
export -f processRelease;

pushToServer() {
	rsync -Pau --no-perms --no-owner --no-group incrementals/divested-*-dos-$1-*.zip* root@divestos.org:/var/www/divestos.org/builds/LineageOS/$1/incrementals/ || true;
	rsync -Pau --no-perms --no-owner --no-group divested-*-dos-$1.zip* root@divestos.org:/var/www/divestos.org/builds/LineageOS/$1/ || true;
	rsync -Pau --no-perms --no-owner --no-group divested-*-dos-$1-recovery.img root@divestos.org:/var/www/divestos.org/builds/LineageOS/$1/ || true;
	rsync -Pau --no-perms --no-owner --no-group fastboot/divested-*-dos-$1-*.zip* root@divestos.org:/var/www/divestos.org/builds/LineageOS/$1/ || true;
}
export -f pushToServer;

removeBuildFingerprints() {
	#Removes the stock/vendor fingerprint, allowing one to be generated instead
	find device -maxdepth 3 -name "lineage*.mk" -type f -exec sh -c "awk -i inplace '!/BUILD_FINGERPRINT/' {}" \;
	find device -maxdepth 3 -name "lineage*.mk" -type f -exec sh -c "awk -i inplace '!/PRIVATE_BUILD_DESC/' {}" \;
	echo "Removed stock build fingerprints";
}
export -f removeBuildFingerprints;

compressRamdisks() {
	if [ -f BoardConfig.mk ]; then
		echo "LZMA_RAMDISK_TARGETS := boot,recovery" >> BoardConfig.mk;
		echo "Enabled ramdisk compression";
	fi;
}
export -f compressRamdisks;

smallerSystem() {
	echo "BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0" >> BoardConfig.mk;
	echo "PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true" >> device.mk;
	echo "EXCLUDE_SERIF_FONTS := true" >> BoardConfig.mk;
	echo "SMALLER_FONT_FOOTPRINT := true" >> BoardConfig.mk;
	#echo "MINIMAL_FONT_FOOTPRINT := true" >> BoardConfig.mk;
	sed -i 's/common_full_phone.mk/common_mini_phone.mk/' *.mk &>/dev/null || true;
	echo "Set smaller system args for $PWD";
}
export -f smallerSystem;

deblobAudio() {
	awk -i inplace '!/BOARD_SUPPORTS_SOUND_TRIGGER/' hardware/qcom/audio-caf/*/configs/*/*.mk &>/dev/null || true;
	awk -i inplace '!/android.hardware.soundtrigger/' hardware/qcom/audio-caf/*/configs/*/*.mk &>/dev/null || true;
	if [ "$DOS_DEBLOBBER_REMOVE_AUDIOFX" = true ]; then
		awk -i inplace '!/DOLBY_/' hardware/qcom/audio-caf/*/configs/*/*.mk &>/dev/null || true;
		#awk -i inplace '!/vendor.audio.dolby/' hardware/qcom/audio-caf/*/configs/*/*.mk &>/dev/null || true;
	fi;
	echo "Deblobbed audio!";
}
export -f deblobAudio;

volteOverride() {
	cd "$DOS_BUILD_BASE$1";
	if grep -sq "config_device_volte_available" "overlay/frameworks/base/core/res/res/values/config.xml"; then
		if [ -f vendor.prop ] && ! grep -sq "volte_avail_ovr" "vendor.prop"; then
			echo -e 'persist.dbg.volte_avail_ovr=1\npersist.dbg.vt_avail_ovr=1' >> vendor.prop;
			echo "Set VoLTE override in vendor.prop for $1";
		elif [ -f system.prop ] && ! grep -sq "volte_avail_ovr" "system.prop"; then
			echo -e 'persist.dbg.volte_avail_ovr=1\npersist.dbg.vt_avail_ovr=1' >> system.prop;
			echo "Set VoLTE override in system.prop for $1";
		fi;
		if [ -f vendor_prop.mk ] && ! grep -sq "volte_avail_ovr" "vendor_prop.mk"; then
			echo -e '\nPRODUCT_PROPERTY_OVERRIDES += \\\n    persist.dbg.volte_avail_ovr=1 \\\n    persist.dbg.vt_avail_ovr=1' >> vendor_prop.mk;
			echo "Set VoLTE override in vendor_prop.mk for $1";
		fi;
		#TODO: init/init*.cpp, device*.mk
	fi;
	cd "$DOS_BUILD_BASE";
}
export -f volteOverride;

hardenLocationConf() {
	local gpsConfig=$1;
	#Debugging: adb logcat -b all | grep -i -e locsvc -e izat -e gps -e gnss -e location -e xtra
	#sed -i 's|DEBUG_LEVEL = .|DEBUG_LEVEL = 4|' "$gpsConfig" &> /dev/null || true;
	#Enable GLONASS
	if [ "$DOS_GPS_GLONASS_FORCED" = true ]; then
	sed -i 's/#A_GLONASS_POS_PROTOCOL_SELECT =/A_GLONASS_POS_PROTOCOL_SELECT =/' "$gpsConfig" &>/dev/null || true;
	sed -i 's/A_GLONASS_POS_PROTOCOL_SELECT = 0.*/A_GLONASS_POS_PROTOCOL_SELECT = 15/' "$gpsConfig" &>/dev/null || true;
	fi;
	#Change capabilities
	sed -i 's|CAPABILITIES=.*|CAPABILITIES=0x13|' "$gpsConfig" &> /dev/null || true; #Disable MSA (privacy) and geofencing/ULP (both broken by deblobber)
	sed -i 's/#SUPL_MODE=/SUPL_MODE=/' "$gpsConfig" &>/dev/null || true;
	sed -i 's/SUPL_MODE=$/SUPL_MODE=1/' "$gpsConfig" &>/dev/null || true; #Set to MSB if blank (to prevent MSA+MSB default)
	sed -i "s|SUPL_MODE=3|SUPL_MODE=1|" "$gpsConfig" &> /dev/null || true; #Disable MSA (privacy)
	#CVE-2018-9526 - See: https://android.googlesource.com/device/google/marlin/+/fa7f7382e8b39f7ca209824f97788ab25c44f6a3
	sed -i 's/#SUPL_ES=/SUPL_ES=/' "$gpsConfig" &>/dev/null || true;
	sed -i "s|SUPL_ES=0|SUPL_ES=1|" "$gpsConfig" &> /dev/null || true;
	#Change servers
	sed -i "s|SUPL_HOST=.*|SUPL_HOST=$DOS_GPS_SUPL_HOST|" "$gpsConfig" &> /dev/null || true;
	sed -i "s|NTP_SERVER=.*|NTP_SERVER=$DOS_GPS_NTP_SERVER|" "$gpsConfig" &> /dev/null || true;
	#CVE-2016-5341 - See: https://wwws.nightwatchcybersecurity.com/2016/12/05/cve-2016-5341/
	#XTRA: Only use specified URLs
	sed -i 's|XTRA_SERVER_QUERY=1|XTRA_SERVER_QUERY=0|' "$gpsConfig" &>/dev/null || true;
	sed -i 's|#XTRA_SERVER|XTRA_SERVER|' "$gpsConfig" &>/dev/null || true;
	#Switch gpsOneXtra to IZatCloud (invalid certificate)
	sed -i '/xtrapath/!s|://xtra|://xtrapath|' "$gpsConfig" &>/dev/null || true;
	sed -i 's|gpsonextra.net|izatcloud.net|' "$gpsConfig" &>/dev/null || true;
	sed -i 's|xtrapath1|xtrapath4|' "$gpsConfig" &>/dev/null || true;
	sed -i 's|xtrapath2|xtrapath5|' "$gpsConfig" &>/dev/null || true;
	sed -i 's|xtrapath3|xtrapath6|' "$gpsConfig" &>/dev/null || true;
	#Enable HTTPS (IZatCloud supports HTTPS)
	sed -i 's|http://xtrapath|https://xtrapath|' "$gpsConfig" &>/dev/null || true;
	#sed -i 's|http://gllto|https://gllto|' "$gpsConfig" &>/dev/null || true; XXX: GLPals has an invaid certificate
	echo "Enhanced location services for $gpsConfig";
}
export -f hardenLocationConf;

hardenLocationFWB() {
	local dir=$1;
	#Enable GLONASS
	if [ "$DOS_GPS_GLONASS_FORCED" = true ]; then
	sed -i 's|A_GLONASS_POS_PROTOCOL_SELECT=0.*</item>|A_GLONASS_POS_PROTOCOL_SELECT=15</item>|' "$dir"/frameworks/base/core/res/res/values*/*.xml &>/dev/null || true;
	fi;
	#Change capabilities
	sed -i "s|SUPL_MODE=3|SUPL_MODE=1|" "$dir"/frameworks/base/core/res/res/values*/*.xml &> /dev/null || true; #Disable MSA (privacy)
	#CVE-2018-9526 - See: https://android.googlesource.com/device/google/marlin/+/fa7f7382e8b39f7ca209824f97788ab25c44f6a3
	sed -i "s|SUPL_ES=0|SUPL_ES=1|" "$dir"/frameworks/base/core/res/res/values*/*.xml &> /dev/null || true;
	#Change servers
	sed -i "s|NTP_SERVER=.*</item>|NTP_SERVER=$DOS_GPS_NTP_SERVER</item>|" "$dir"/frameworks/base/core/res/res/values*/*.xml &> /dev/null || true;
	#CVE-2016-5341 - See: https://wwws.nightwatchcybersecurity.com/2016/12/05/cve-2016-5341/
	#Switch gpsOneXtra to IZatCloud (invalid certificate)
	sed -i '/xtrapath/!s|://xtra|://xtrapath|' "$dir"/frameworks/base/core/res/res/values*/*.xml &>/dev/null || true;
	sed -i 's|gpsonextra.net|izatcloud.net|' "$dir"/frameworks/base/core/res/res/values*/*.xml &>/dev/null || true;
	sed -i 's|xtrapath1|xtrapath4|' "$dir"/frameworks/base/core/res/res/values*/*.xml &>/dev/null || true;
	sed -i 's|xtrapath2|xtrapath5|' "$dir"/frameworks/base/core/res/res/values*/*.xml &>/dev/null || true;
	sed -i 's|xtrapath3|xtrapath6|' "$dir"/frameworks/base/core/res/res/values*/*.xml &>/dev/null || true;
	#Enable HTTPS (IZatCloud supports HTTPS)
	sed -i 's|http://xtrapath|https://xtrapath|' "$dir"/frameworks/base/core/res/res/values*/*.xml &>/dev/null || true;
	#sed -i 's|http://gllto|https://gllto|' "$dir"/frameworks/base/core/res/res/values*/*.xml &>/dev/null || true; XXX: GLPals has an invaid certificate
	echo "Enhanced location services for $dir";
}
export -f hardenLocationFWB;

hardenUserdata() {
	cd "$DOS_BUILD_BASE$1";

	#awk -i inplace '!/f2fs/' *fstab* */*fstab* */*/*fstab* &>/dev/null || true;

	#Remove latemount to allow selinux contexts be restored upon /cache wipe
	#Fixes broken OTA updater and broken /recovery updater
	sed -i '/\/cache/s|latemount,||' *fstab* */*fstab* */*/*fstab* &>/dev/null || true;

	#TODO: Ensure: noatime,nosuid,nodev
	sed -i '/\/data/{/discard/!s|nosuid|discard,nosuid|}' *fstab* */*fstab* */*/*fstab* &>/dev/null || true;
	if [ "$1" != "device/samsung/tuna" ] && [ "$1" != "device/amazon/hdx-common" ]; then #tuna needs first boot to init, hdx-c has broken encryption
		sed -i 's|encryptable=/|forceencrypt=/|' *fstab* */*fstab* */*/*fstab* &>/dev/null || true;
	fi;
	echo "Hardened /data for $1";
	cd "$DOS_BUILD_BASE";
}
export -f hardenUserdata;

hardenBootArgs() {
	cd "$DOS_BUILD_BASE$1";
	sed -i 's/BOARD_KERNEL_CMDLINE := /BOARD_KERNEL_CMDLINE := slub_debug=FZP /' BoardConfig*.mk */BoardConfig*.mk &>/dev/null || true; #TODO: inline this
	echo "Hardened kernel command line arguments for $1";
	cd "$DOS_BUILD_BASE";
}
export -f hardenBootArgs;

enableAutoVarInit() {
	DOS_AUTOVARINIT_KERNELS=('essential/msm8998' 'fxtec/msm8998' 'google/coral' 'google/msm-4.9' 'google/sunfish' 'google/wahoo' 'oneplus/msm8996' 'oneplus/msm8998' 'oneplus/sdm845' 'oneplus/sm7250' 'oneplus/sm8150' 'razer/msm8998' 'razer/sdm845' 'sony/sdm660' 'sony/sdm845' 'xiaomi/sdm660' 'xiaomi/sdm845' 'xiaomi/sm6150' 'xiaomi/sm8150' 'xiaomi/sm8250' 'zuk/msm8996'); #redbull already supports init_stack_all_zero
	cd "$DOS_BUILD_BASE";
	echo "auto-var-init: Starting!";
	for kernel in "${DOS_AUTOVARINIT_KERNELS[@]}"
	do
		if [ -d "$DOS_BUILD_BASE/kernel/$kernel" ]; then
			cd "$DOS_BUILD_BASE/kernel/$kernel";
			if git apply --check "$DOS_PATCHES_COMMON/android_kernel_common/0001-auto_var_init.patch" &> /dev/null; then
				if git apply "$DOS_PATCHES_COMMON/android_kernel_common/0001-auto_var_init.patch" &> /dev/null; then #(GrapheneOS)
					echo "auto-var-init: Enabled for $kernel";
				else
					echo "auto-var-init: Failed to enable for $kernel";
				fi;
			elif git apply --check --reverse "$DOS_PATCHES_COMMON/android_kernel_common/0001-auto_var_init.patch" &> /dev/null; then
				echo "auto-var-init: Already enabled for $kernel";
			elif grep -q "trivial-auto-var-init=pattern" Makefile; then
				sed -i 's/ftrivial-auto-var-init=pattern/ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang/' Makefile; #(GrapheneOS)
				grep -q "trivial-auto-var-init=pattern" Makefile;
				if [ $? -eq 0 ]; then
					echo "auto-var-init: Failed to switch from pattern to zero on $kernel";
				else
					echo "auto-var-init: Switched from pattern to zero on $kernel";
				fi;
			elif grep -q "trivial-auto-var-init=zero" Makefile; then
				echo "auto-var-init: Already enabled for $kernel";
			else
				echo "auto-var-init: Could not enable for $kernel";
			fi;
#		else
#			echo "auto-var-init: $kernel not in tree";
		fi;
	done;
	echo "auto-var-init: Finished!";
	cd "$DOS_BUILD_BASE";
}
export -f enableAutoVarInit;

disableEnforceRRO() {
	cd "$DOS_BUILD_BASE$1";
	awk -i inplace '!/PRODUCT_ENFORCE_RRO_TARGETS .= framework-res/' *.mk &>/dev/null || true;
	awk -i inplace '!/PRODUCT_ENFORCE_RRO_TARGETS .= \*/' *.mk &>/dev/null || true;
	sed -i '/PRODUCT_ENFORCE_RRO_TARGETS .= \\/,+1 d' *.mk &>/dev/null || true;
	#TODO: Find a new home for these two
	awk -i inplace '!/persist.device_config.runtime_native.usap_pool_enabled=true/' *.prop &>/dev/null || true;
	awk -i inplace '!/config_pinnerCameraApp/' overlay/frameworks/base/core/res/res/values/config.xml &>/dev/null || true;
	echo "Disabled enforced RRO for $1";
	cd "$DOS_BUILD_BASE";
}
export -f disableEnforceRRO;

disableAPEX() {
	cd "$DOS_BUILD_BASE$1";
	awk -i inplace '!/DEXPREOPT_GENERATE_APEX_IMAGE/' *.mk &>/dev/null || true;
	awk -i inplace '!/updatable_apex.mk/' *.mk &>/dev/null || true;
	echo "Disabled APEX for $1";
	cd "$DOS_BUILD_BASE";
}
export -f disableAPEX;

enableStrongEncryption() {
	cd "$DOS_BUILD_BASE$1";
	if [ -f BoardConfig.mk ]; then
		echo "TARGET_WANTS_STRONG_ENCRYPTION := true" >> BoardConfig.mk;
		echo "Enabled AES-256 encryption for $1";
	fi;
	cd "$DOS_BUILD_BASE";
}
export -f enableStrongEncryption;

addAdbKey() {
	if [ -f ~/.android/adbkey.pub ]; then
		cp ~/.android/adbkey.pub "$DOS_BUILD_BASE/vendor/divested/";
		echo "PRODUCT_ADB_KEYS := vendor/divested/adbkey.pub" >> "$DOS_BUILD_BASE/vendor/divested/divestos.mk";
	fi;
}
export -f addAdbKey;

changeDefaultDNS() {
	local dnsPrimary="";
	local dnsPrimaryV6="";
	local dnsSecondary="";
	local dnsSecondaryV6="";
	if [ ! -z "$DOS_DEFAULT_DNS_PRESET" ]; then
		if [[ "$DOS_DEFAULT_DNS_PRESET" == "AdGuard" ]]; then #https://adguard.com/en/adguard-dns/overview.html
			dnsHex="0xb0678282L";
			dnsPrimary="176.103.130.130";
			dnsPrimaryV6="2a00:5a60::ad1:0ff";
			dnsSecondary="176.103.130.131";
			dnsSecondaryV6="2a00:5a60::ad2:0ff";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "AdGuard-NOBL" ]]; then #https://adguard.com/en/adguard-dns/overview.html
			dnsHex="0xb0678288L";
			dnsPrimary="176.103.130.136";
			dnsPrimaryV6="2a00:5a60::01:ff";
			dnsSecondary="176.103.130.137";
			dnsSecondaryV6="2a00:5a60::02:ff";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "CensurfriDNS" ]]; then #https://uncensoreddns.org
			dnsHex="0x5bef6464L";
			dnsPrimary="91.239.100.100";
			dnsPrimaryV6="2001:67c:28a4::";
			dnsSecondary="89.233.43.71";
			dnsSecondaryV6="2a01:3a0:53:53::";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Cloudflare" ]]; then #https://developers.cloudflare.com/1.1.1.1/commitment-to-privacy/privacy-policy/privacy-policy
			dnsHex="0x01000001L";
			dnsPrimary="1.0.0.1";
			dnsPrimaryV6="2606:4700:4700::1001";
			dnsSecondary="1.1.1.1";
			dnsSecondaryV6="2606:4700:4700::1111";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Cloudflare-BL" ]]; then #https://developers.cloudflare.com/1.1.1.1/commitment-to-privacy/privacy-policy/privacy-policy
			dnsHex="0x01000002L";
			dnsPrimary="1.0.0.2";
			dnsPrimaryV6="2606:4700:4700::1002";
			dnsSecondary="1.1.1.2";
			dnsSecondaryV6="2606:4700:4700::1112";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "DNSWATCH" ]]; then #https://dns.watch
			dnsHex="0x54c84550L";
			dnsPrimary="84.200.69.80";
			dnsPrimaryV6="2001:1608:10:25::1c04:b12f";
			dnsSecondary="84.200.70.40";
			dnsSecondaryV6="2001:1608:10:25::9249:d69b";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Google" ]]; then #https://developers.google.com/speed/public-dns/privacy
			dnsHex="0x08080808L";
			dnsPrimary="8.8.8.8";
			dnsPrimaryV6="2001:4860:4860::8888";
			dnsSecondary="8.8.4.4";
			dnsSecondaryV6="2001:4860:4860::8844";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Neustar" ]]; then #https://www.security.neustar/digital-performance/dns-services/recursive-dns
			dnsHex="0x9c9a4602L";
			dnsPrimary="156.154.70.2";
			dnsPrimaryV6="2610:a1:1018::2";
			dnsSecondary="156.154.71.2";
			dnsSecondaryV6="2610:a1:1019::2";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Neustar-NOBL" ]]; then #https://www.security.neustar/digital-performance/dns-services/recursive-dns
			dnsHex="0x9c9a4605L";
			dnsPrimary="156.154.70.5";
			dnsPrimaryV6="2610:a1:1018::5";
			dnsSecondary="156.154.71.5";
			dnsSecondaryV6="2610:a1:1019::5";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "OpenDNS" ]]; then #https://www.cisco.com/c/en/us/about/legal/privacy-full.html
			dnsHex="0xd043dedeL";
			dnsPrimary="208.67.222.222";
			dnsPrimaryV6="2620:0:ccc::2";
			dnsSecondary="208.67.220.220";
			dnsSecondaryV6="2620:0:ccd::2";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Quad9" ]]; then #https://www.quad9.net/privacy
			dnsHex="0x09090909L";
			dnsPrimary="9.9.9.9";
			dnsPrimaryV6="2620:fe::fe";
			dnsSecondary="149.112.112.112";
			dnsSecondaryV6="2620:fe::9";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Quad9-EDNS" ]]; then #https://www.quad9.net/privacy
			dnsHex="0x0909090bL";
			dnsPrimary="9.9.9.11";
			dnsPrimaryV6="2620:fe::11";
			dnsSecondary="149.112.112.11";
			dnsSecondaryV6="2620:fe::fe:11";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Quad9-NOBL" ]]; then #https://www.quad9.net/privacy
			dnsHex="0x0909090aL";
			dnsPrimary="9.9.9.10";
			dnsPrimaryV6="2620:fe::10";
			dnsSecondary="149.112.112.10";
			dnsSecondaryV6="2620:fe::fe:10";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Verisign" ]]; then #https://www.verisign.com/en_US/security-services/public-dns/terms-of-service/index.xhtml
			dnsHex="0x40064006L";
			dnsPrimary="64.6.64.6";
			dnsPrimaryV6="2620:74:1b::1:1";
			dnsSecondary="64.6.65.6";
			dnsSecondaryV6="2620:74:1c::2:2";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Yandex" ]]; then #https://dns.yandex.com/advanced
			dnsHex="0x4d580858L";
			dnsPrimary="77.88.8.88";
			dnsPrimaryV6="2a02:6b8::feed:bad";
			dnsSecondary="77.88.8.2";
			dnsSecondaryV6="2a02:6b8:0:1::feed:bad";
		elif [[ "$DOS_DEFAULT_DNS_PRESET" == "Yandex-NOBL" ]]; then #https://dns.yandex.com/advanced
			dnsHex="0x4d580808L";
			dnsPrimary="77.88.8.8";
			dnsPrimaryV6="2a02:6b8::feed:0ff";
			dnsSecondary="77.88.8.1";
			dnsSecondaryV6="2a02:6b8:0:1::feed:0ff";
		fi;
	else
		echo "You must first set a preset via the DOS_DEFAULT_DNS_PRESET variable in init.sh!";
	fi;

	local files="$DOS_BUILD_BASE/bionic/libc/dns/net/getaddrinfo.c $DOS_BUILD_BASE/packages/apps/Dialer/java/com/android/voicemail/impl/sync/VvmNetworkRequestCallback.java $DOS_BUILD_BASE/packages/modules/Connectivity/framework/src/android/net/util/DnsUtils.java $DOS_BUILD_BASE/packages/modules/Connectivity/service/src/com/android/server/connectivity/NetworkDiagnostics.java $DOS_BUILD_BASE/packages/modules/Connectivity/Tethering/src/com/android/networkstack/tethering/TetheringConfiguration.java $DOS_BUILD_BASE/packages/modules/DnsResolver/DnsResolver/doh.rs $DOS_BUILD_BASE/packages/modules/DnsResolver/DnsResolver/getaddrinfo.cpp $DOS_BUILD_BASE/packages/modules/DnsResolver/getaddrinfo.cpp core/java/android/net/util/DnsUtils.java core/java/com/android/internal/net/VpnProfile.java core/res/res/values/config.xml packages/SettingsLib/res/values/strings.xml packages/Tethering/src/com/android/networkstack/tethering/TetheringConfiguration.java services/core/java/com/android/server/connectivity/NetworkDiagnostics.java services/core/java/com/android/server/connectivity/Tethering.java services/core/java/com/android/server/connectivity/tethering/TetheringConfiguration.java services/java/com/android/server/connectivity/Tethering.java tests/BandwidthTests/src/com/android/tests/bandwidthenforcement/BandwidthEnforcementTestService.java";
	sed -i "s/8\.8\.8\.8/$dnsPrimary/" $files &>/dev/null || true;
	sed -i "s/2001:4860:4860::8888/$dnsPrimaryV6/" $files &>/dev/null || true;
	sed -i "s/8\.8\.4\.4/$dnsSecondary/" $files &>/dev/null || true;
	sed -i "s/4\.4\.4\.4/$dnsSecondary/" $files &>/dev/null || true;
	sed -i "s/2001:4860:4860::8844/$dnsSecondaryV6/" $files &>/dev/null || true;
	sed -i "s/0x08080808L/$dnsHex/" $files &>/dev/null || true;
}
export -f changeDefaultDNS;

editKernelLocalversion() {
	local defconfigPath=$(getDefconfig)
	sed -i 's/CONFIG_LOCALVERSION=".*"/CONFIG_LOCALVERSION="'"$1"'"/' $defconfigPath &>/dev/null || true;
	sed -zi '/CONFIG_LOCALVERSION="'"$1"'"/!s/$/\nCONFIG_LOCALVERSION="'"$1"'"/' $defconfigPath &>/dev/null;
}
export -f editKernelLocalversion;

getDefconfig() {
	if ls arch/arm/configs/lineage*defconfig 1> /dev/null 2>&1; then
		local defconfigPath="arch/arm/configs/lineage*defconfig";
	elif ls arch/arm64/configs/lineage*defconfig 1> /dev/null 2>&1; then
		local defconfigPath="arch/arm64/configs/lineage*defconfig";
	else
		#grep TARGET_KERNEL_CONFIG /mnt/dos/Build/*/device/ -Rih | sed 's|TARGET_KERNEL_CONFIG .= |arch/arm\*/configs/|' | grep -v lineage | sort -u
		#grep TARGET_KERNEL_VARIANT_CONFIG /mnt/dos/Build/*/device/ -Rih | sed 's|TARGET_KERNEL_VARIANT_CONFIG .= |arch/arm\*/configs/|' | grep -v lineage | sort -u
		local defconfigPath="arch/arm*/configs/lineage*defconfig arch/arm*/configs/apollo_defconfig arch/arm*/configs/apq8084_sec_defconfig arch/arm*/configs/apq8084_sec_kccat6_eur_defconfig arch/arm*/configs/apq8084_sec_lentislte_skt_defconfig arch/arm*/configs/aura_defconfig arch/arm*/configs/b1c1_defconfig arch/arm*/configs/beryllium_defconfig arch/arm*/configs/bonito_defconfig arch/arm*/configs/clark_defconfig arch/arm*/configs/discovery_defconfig arch/arm*/configs/enchilada_defconfig arch/arm*/configs/exynos8890-herolte_defconfig arch/arm*/configs/floral_defconfig arch/arm*/configs/griffin_defconfig arch/arm*/configs/grouper_defconfig arch/arm*/configs/harpia_defconfig arch/arm*/configs/jf_eur_defconfig arch/arm*/configs/lavender_defconfig arch/arm*/configs/m1s1_defconfig arch/arm*/configs/m7_defconfig arch/arm*/configs/m8_defconfig arch/arm*/configs/merlin_defconfig arch/arm*/configs/msm8930_serrano_eur_3g_defconfig arch/arm*/configs/msm8930_serrano_eur_lte_defconfig arch/arm*/configs/msm8974-hdx_defconfig arch/arm*/configs/msm8974-hdx-perf_defconfig arch/arm*/configs/oneplus2_defconfig arch/arm*/configs/osprey_defconfig arch/arm*/configs/pioneer_defconfig arch/arm*/configs/redbull_defconfig arch/arm*/configs/samsung_serrano_defconfig arch/arm*/configs/samsung_serrano_usa_defconfig arch/arm*/configs/shamu_defconfig arch/arm*/configs/sunfish_defconfig arch/arm*/configs/surnia_defconfig arch/arm*/configs/tama_akari_defconfig arch/arm*/configs/tama_apollo_defconfig arch/arm*/configs/tama_aurora_defconfig arch/arm*/configs/thor_defconfig arch/arm*/configs/tuna_defconfig arch/arm*/configs/twrp_defconfig arch/arm*/configs/vendor/alioth_defconfig arch/arm*/configs/vendor/lineage_davinci_defconfig arch/arm*/configs/vendor/lito-perf_defconfig arch/arm*/configs/vendor/lmi_defconfig arch/arm*/configs/vendor/raphael_defconfig arch/arm*/configs/vendor/sm8150-perf_defconfig arch/arm*/configs/vendor/vayu_defconfig arch/arm*/configs/voyager_defconfig arch/arm*/configs/yellowstone_defconfig arch/arm*/configs/Z00T_defconfig arch/arm*/configs/z2_plus_defconfig arch/arm*/configs/zenfone3-perf_defconfig ";
	fi;
	echo $defconfigPath;
}
export -f getDefconfig;

hardenDefconfig() {
	cd "$DOS_BUILD_BASE$1";

	#Attempts to enable/disable supported options to increase security
	#See https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Recommended_Settings
	#and (GPL-3.0) https://github.com/a13xp0p0v/kconfig-hardened-check/blob/master/kconfig_hardened_check/__init__.py

	local defconfigPath=$(getDefconfig)

	#Enable supported options
	#Linux <3.0
	declare -a optionsYes=("BUG" "DEBUG_CREDENTIALS" "DEBUG_KERNEL" "DEBUG_LIST" "DEBUG_NOTIFIERS" "DEBUG_RODATA" "DEBUG_SET_MODULE_RONX" "DEBUG_VIRTUAL" "IPV6_PRIVACY" "SECCOMP" "SECURITY" "SECURITY_DMESG_RESTRICT" "SLUB_DEBUG" "STRICT_DEVMEM" "SYN_COOKIES");
	#Disabled: DEBUG_SG (bootloops - https://patchwork.kernel.org/patch/8989981)

	#Linux 3.4
	optionsYes+=("SECURITY_YAMA");

	#Linux 3.5
	optionsYes+=("PANIC_ON_OOPS" "SECCOMP_FILTER");

	#Linux 3.7
	optionsYes+=("ASYMMETRIC_PUBLIC_KEY_SUBTYPE" "SECURITY_YAMA_STACKED" "X509_CERTIFICATE_PARSER");

	#Linux 3.13
	optionsYes+=("SYSTEM_TRUSTED_KEYRING");

	#Linux 3.14
	optionsYes+=("CC_STACKPROTECTOR" "CC_STACKPROTECTOR_STRONG");

	#Linux 3.17
	optionsYes+=("PKCS7_MESSAGE_PARSER");

	#Linux 3.18
	optionsYes+=("HARDENED_USERCOPY" "SCHED_STACK_END_CHECK");

	#Linux 4.3
	optionsYes+=("ARM64_PAN" "CPU_SW_DOMAIN_PAN");

	#Linux 4.4
	optionsYes+=("LEGACY_VSYSCALL_NONE");

	#Linux 4.5
	optionsYes+=("IO_STRICT_DEVMEM");

	#Linux 4.6
	optionsYes+=("ARM64_UAO" "PAGE_POISONING" "PAGE_POISONING_ZERO" "PAGE_POISONING_NO_SANITY");

	#Linux 4.7
	optionsYes+=("ASYMMETRIC_KEY_TYPE" "RANDOMIZE_BASE" "SLAB_FREELIST_RANDOM");

	#Linux 4.8
	optionsYes+=("RANDOMIZE_MEMORY");

	#Linux 4.9
	optionsYes+=("THREAD_INFO_IN_TASK" "VMAP_STACK");

	#Linux 4.10
	optionsYes+=("ARM64_SW_TTBR0_PAN" "BUG_ON_DATA_CORRUPTION");

	#Linux 4.11
	optionsYes+=("STRICT_KERNEL_RWX" "STRICT_MODULE_RWX");

	#Linux 4.13
	optionsYes+=("FORTIFY_SOURCE" "REFCOUNT_FULL");

	#Linux 4.14
	optionsYes+=("SLAB_FREELIST_HARDENED");

	#Linux 4.15
	optionsYes+=("PAGE_TABLE_ISOLATION" "RETPOLINE");

	#Linux 4.16
	optionsYes+=("UNMAP_KERNEL_AT_EL0");

	#Linux 4.17
	optionsYes+=("HARDEN_EL2_VECTORS");

	#Linux 4.18
	optionsYes+=("HARDEN_BRANCH_PREDICTOR" "STACKPROTECTOR" "STACKPROTECTOR_STRONG");

	#Linux 5.0
	optionsYes+=("ARM64_PTR_AUTH" "RODATA_FULL_DEFAULT_ENABLED" "STACKPROTECTOR_PER_TASK");

	#Linux 5.2
	optionsYes+=("INIT_STACK_ALL" "SHUFFLE_PAGE_ALLOCATOR");

	#Linux 5.8
	optionsYes+=("ARM64_BTI_KERNEL" "DEBUG_WX");

	#Linux 5.9
	optionsYes+=("INIT_STACK_ALL_ZERO");

	#Linux 5.10
	optionsYes+=("ARM64_MTE");

	#Linux 5.13
	optionsYes+=("ARM64_EPAN" "RANDOMIZE_KSTACK_OFFSET_DEFAULT");

	#GCC Plugins - 4.19								- 5.2
	#optionsYes+=("GCC_PLUGINS" "GCC_PLUGIN_LATENT_ENTROPY" "GCC_PLUGIN_RANDSTRUCT" "GCC_PLUGIN_STRUCTLEAK" "GCC_PLUGIN_STRUCTLEAK_BYREF_ALL");

	#GrapheneOS Patches
	optionsYes+=("PAGE_SANITIZE" "PAGE_SANITIZE_VERIFY" "SLAB_HARDENED" "SLAB_SANITIZE" "SLAB_SANITIZE_VERIFY");
	#Disabled: SLAB_CANARY (breakage?)

	#out of tree or renamed or removed ?
	optionsYes+=("KAISER" "KGSL_PER_PROCESS_PAGE_TABLE" "MMC_SECDISCARD" "SECURITY_PERF_EVENTS_RESTRICT" "SLUB_HARDENED" "STRICT_MEMORY_RWX");

	#Time hardware
	#if [ "$DOS_DEBLOBBER_REPLACE_TIME" = true ]; then optionsYes+=("RTC_DRV_MSM" "RTC_DRV_PM8XXX" "RTC_DRV_MSM7X00A" "RTC_DRV_QPNP"); fi;

	#Hardware enablement #XXX: This needs a better home
	optionsYes+=("HID_GENERIC" "HID_STEAM" "HID_SONY" "HID_WIIMOTE" "INPUT_JOYSTICK" "JOYSTICK_XPAD" "USB_USBNET" "USB_NET_CDCETHER");

	modernKernels=('google/coral' 'google/redbull' 'google/sunfish' 'oneplus/sm8150' 'xiaomi/sm8150' 'xiaomi/sm8250');
	for kernelModern in "${modernKernels[@]}"; do
		if [[ "$1" == *"/$kernelModern"* ]]; then
			optionsYes+=("INIT_ON_ALLOC_DEFAULT_ON" "INIT_ON_FREE_DEFAULT_ON");
			#TODO: also disable slub_debug=P for these devices
		fi;
	done;

	oldKernels=('essential/msm8998' 'fairphone/sdm632' 'fxtec/msm8998' 'google/msm-4.9' 'oneplus/msm8998' 'oneplus/sdm845' 'oneplus/sm7250' 'razer/msm8998' 'razer/sdm845' 'sony/sdm660' 'sony/sdm845' 'xiaomi/sdm660' 'xiaomi/sdm845' 'xiaomi/sm6150' 'yandex/sdm660' 'zuk/msm8996');
	for kernelOld in "${oldKernels[@]}"; do
		if [[ "$1" == *"/$kernelOld"* ]]; then
			optionsYes+=("PAGE_POISONING_ENABLE_DEFAULT");
		fi;
	done;

	for option in "${optionsYes[@]}"
	do
		#If the option is disabled, enable it
		sed -i 's/# CONFIG_'"$option"' is not set/CONFIG_'"$option"'=y/' $defconfigPath &>/dev/null || true;
		if [[ "$1" != *"kernel/oneplus/msm8996"* ]]; then
			#If the option isn't present, add it enabled
			sed -zi '/CONFIG_'"$option"'=y/!s/$/\nCONFIG_'"$option"'=y/' $defconfigPath &>/dev/null || true;
		fi;
	done
	#Disable supported options
	#Disabled: MSM_SMP2P_TEST, MAGIC_SYSRQ (breaks compile), KALLSYMS (breaks boot on select devices), IKCONFIG (breaks recovery), MSM_DLOAD_MODE (breaks compile), PROC_PAGE_MONITOR (breaks memory stats)
	declare -a optionsNo=("ACPI_APEI_EINJ" "ACPI_CUSTOM_METHOD" "ACPI_TABLE_UPGRADE" "BINFMT_AOUT" "BINFMT_MISC" "BLK_DEV_FD" "BT_HS" "CHECKPOINT_RESTORE" "COMPAT_BRK" "COMPAT_VDSO" "CP_ACCESS64" "DEBUG_KMEMLEAK" "DEVKMEM" "DEVMEM" "DEVPORT" "EARJACK_DEBUGGER" "GCC_PLUGIN_RANDSTRUCT_PERFORMANCE" "HARDENED_USERCOPY_FALLBACK" "HIBERNATION" "HWPOISON_INJECT" "IA32_EMULATION" "IOMMU_NON_SECURE" "INPUT_EVBUG" "IO_URING" "IP_DCCP" "IP_SCTP" "KEXEC" "KEXEC_FILE" "KSM" "LDISC_AUTOLOAD" "LEGACY_PTYS" "LIVEPATCH" "MEM_SOFT_DIRTY" "MMIOTRACE" "MMIOTRACE_TEST" "MODIFY_LDT_SYSCALL" "MSM_BUSPM_DEV" "NEEDS_SYSCALL_FOR_CMPXCHG" "NOTIFIER_ERROR_INJECTION" "OABI_COMPAT" "PAGE_OWNER" "PROC_KCORE" "PROC_VMCORE" "RDS" "RDS_TCP" "SECURITY_SELINUX_DISABLE" "SECURITY_WRITABLE_HOOKS" "SLAB_MERGE_DEFAULT" "STACKLEAK_METRICS" "STACKLEAK_RUNTIME_DISABLE" "TIMER_STATS" "TSC" "TSPP2" "UKSM" "UPROBES" "USELIB" "USERFAULTFD" "VIDEO_VIVID" "WLAN_FEATURE_MEMDUMP" "X86_IOPL_IOPERM" "X86_PTDUMP" "X86_VSYSCALL_EMULATION" "ZSMALLOC_STAT");

	if [ "$DOS_DEBLOBBER_REMOVE_IPA" = true ]; then optionsNo+=("IPA" "RMNET_IPA"); fi;
	optionsNo+=("WIREGUARD"); #Requires root access, which we do not provide

	for option in "${optionsNo[@]}"
	do
		#If the option is enabled, disable it
		sed -i 's/CONFIG_'"$option"'=y/CONFIG_'"$option"'=n/' $defconfigPath &>/dev/null || true;
		#If the option isn't present, add it disabled
		sed -zi '/CONFIG_'"$option"'=n/!s/$/\nCONFIG_'"$option"'=n/' $defconfigPath &>/dev/null || true;
	done

	#Extras
	sed -i 's/CONFIG_ARCH_MMAP_RND_BITS=8/CONFIG_ARCH_MMAP_RND_BITS=16/' $defconfigPath &>/dev/null || true;
	sed -i 's/CONFIG_ARCH_MMAP_RND_BITS=18/CONFIG_ARCH_MMAP_RND_BITS=24/' $defconfigPath &>/dev/null || true;
	sed -i 's/CONFIG_DEFAULT_MMAP_MIN_ADDR=4096/CONFIG_DEFAULT_MMAP_MIN_ADDR=32768/' $defconfigPath &>/dev/null || true;
	sed -zi '/CONFIG_DEFAULT_MMAP_MIN_ADDR/!s/$/\nCONFIG_DEFAULT_MMAP_MIN_ADDR=32768/' $defconfigPath &>/dev/null || true;
	sed -i 's/CONFIG_LSM_MMAP_MIN_ADDR=4096/CONFIG_LSM_MMAP_MIN_ADDR=32768/' $defconfigPath &>/dev/null || true;
	sed -zi '/CONFIG_LSM_MMAP_MIN_ADDR/!s/$/\nCONFIG_LSM_MMAP_MIN_ADDR=32768/' $defconfigPath &>/dev/null || true;

	editKernelLocalversion "-dos";

	echo "Hardened defconfig for $1";
	cd "$DOS_BUILD_BASE";
}
export -f hardenDefconfig;

PRODUCT_BRAND ?= DivestOS
PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE := 0

DEVICE_PACKAGE_OVERLAYS += vendor/divested/overlay/common

PRODUCT_PACKAGES += ModuleBlocker

PRODUCT_PROPERTY_OVERRIDES += \
	keyguard.no_require_sim=true \
	ro.config.notification_sound=Pong.ogg \
	ro.config.alarm_alert=Alarm_Buzzer.ogg \
	ro.build.selinux=1 \
	ro.storage_manager.enabled=true \
	ro.cmlegal.url=https://divestos.xyz/index.php?page=about

PRODUCT_BUILD_PROP_OVERRIDES += \
	BUILD_UTC_DATE=0

ifneq ($(TARGET_BUILD_VARIANT),eng)
	ADDITIONAL_DEFAULT_PROPERTIES += \
		ro.adb.secure=1
endif

PRODUCT_COPY_FILES += \
	vendor/divested/extras/etc/dns66.json:system/etc/dns66/settings.json

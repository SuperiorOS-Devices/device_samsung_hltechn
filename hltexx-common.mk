#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

## Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/samsung/hlte-common/hlte-common-vendor.mk)

## overlays
DEVICE_PACKAGE_OVERLAYS += device/samsung/hltexx/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Expose Irda feature
#PRODUCT_COPY_FILES += \
#    device/samsung/hltexx/etc/com.sec.feature.irda_service.xml:system/etc/permissions/com.sec.feature.irda_service.xml

# Audio configuration
PRODUCT_COPY_FILES += \
    device/samsung/hltexx/audio/snd_soc_msm_Taiko_CDP:system/etc/snd_soc_msm/snd_soc_msm_Taiko_CDP \
    device/samsung/hltexx/audio/snd_soc_msm_Taiko_CDP:system/etc/snd_soc_msm/snd_soc_msm_Taiko \
    device/samsung/hltexx/audio/audio_policy.conf:system/etc/audio_policy.conf \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

# Media Profile
PRODUCT_COPY_FILES += \
    device/samsung/hltexx/media/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_PACKAGES += \
        libloc_adapter \
        libloc_eng \
        libloc_api_v02 \
        libgps.utils \
        gps.msm8974

    GPS_CONF := device/samsung/hltexx/gps/gps.conf

PRODUCT_COPY_FILES += \
    $(GPS_CONF):/system/etc/gps.conf

# Keylayouts
PRODUCT_COPY_FILES += \
    device/samsung/hltexx/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    device/samsung/hltexx/keylayout/Button_Jack.kl:system/usr/keylayout/Button_Jack.kl \
    device/samsung/hltexx/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/samsung/hltexx/keylayout/philips_remote_ir.kl:system/usr/keylayout/philips_remote_ir.kl \
    device/samsung/hltexx/keylayout/samsung_remote_ir.kl:system/usr/keylayout/samsung_remote_ir.kl \
    device/samsung/hltexx/keylayout/sec_touchkey.kl:system/usr/keylayout/sec_touchkey.kl \
    device/samsung/hltexx/keylayout/ue_rf4ce_remote.kl:system/usr/keylayout/ue_rf4ce_remote.kl

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    initlogo.rle \
    init.bt.rc \
    init.carrier.rc \
    init.crda.rc \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.target.rc \
    ueventd.qcom.rc
# HAL
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    power.msm8974
PRODUCT_PACKAGES += \
    audio_policy.msm8974 \
    audio.primary.msm8974

# Torch
PRODUCT_PACKAGES += Torch

# Wifi
PRODUCT_PACKAGES += \
    libnetcmdiface \
    macloader \
    crda \
    regulatory.bin \
    linville.key.pub.pem

# Nfc
NFCEE_ACCESS_PATH := device/samsung/hltexx/nfc/nfcee_access.xml

ifneq ($(filter hltexx hltespr,$(TARGET_DEVICE)),)

PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8974 \
    NfcNci \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml \
    device/samsung/hltexx/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf

else
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

endif

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Lights
PRODUCT_PACKAGES += lights.MSM8974

# Irda
#PRODUCT_PACKAGES += irda.msm8974

# QC Perf
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=/system/lib/libqc-opt.so

# QRNGD
PRODUCT_PACKAGES += qrngd

#common build.props
PRODUCT_PROPERTY_OVERRIDES += \
    ro.chipname=apq8064 \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    persist.radio.add_power_save=1 \
    persist.radio.snapshot_disabled=1 \
    persist.radio.use_se_table_only=1 \
    persist.radio.fill_eons=1 \
    com.qc.hardware=true \
    persist.radio.apm_sim_not_pwdn=1 \
    ro.telephony.call_ring.multiple=0 \
    ro.sf.lcd_density=480 \
    ro.ril.transmitpower=true \
    ro.opengles.version=196608 \
    lpa.decode=true \
    persist.timed.enable=true \
    ro.emmc.sdcard.partition=17 \
    ro.use_data_netmgrd=true \
    persist.data.ds_fmc_app.mode=0 \
    persist.ims.regmanager.mode=0 \
    ro.config.ehrpd=true \
    persist.omh.enabled=1 \
    persist.data_netmgrd_nint=16 \
    rild.libpath=/system/lib/libsec-ril.so \
    ril.subscription.types=NV,RUIM \
    ro.cdma.subscribe_on_ruim_ready=true \
    persist.radio.no_wait_for_card=0 \
    keyguard.no_require_sim=true \
    media.aac_51_output_enabled=true \
    persist.rild.nitz_plmn="" \
    persist.rild.nitz_long_ons_0="" \
    persist.rild.nitz_long_ons_1="" \
    persist.rild.nitz_long_ons_2="" \
    persist.rild.nitz_long_ons_3="" \
    persist.rild.nitz_short_ons_0="" \
    persist.rild.nitz_short_ons_1="" \
    persist.rild.nitz_short_ons_2="" \
    persist.rild.nitz_short_ons_3="" \
    ro.telephony.ril.v3=newDriverCall

# Wifi
PRODUCT_COPY_FILES += \
   device/samsung/hltexx/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
   device/samsung/hltexx/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

# call common msm8960
$(call inherit-product, device/samsung/msm8960-common/msm8960.mk)

# call dalvik heap config
$(call inherit-product, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)

# call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

#
# vendor_prop for urd
#

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1 \
    audio.deep_buffer.media=true \
    ro.vendor.audio.sdk.ssr=false \
    vendor.audio_hal.period_size=192 \
    vendor.audio.rec.playback.conc.disabled=false \
    vendor.voice.playback.conc.disabled=false \
    vendor.voice.record.conc.disabled=false \
    vendor.voice.voip.conc.disabled=false \
    ro.vendor.audio.sdk.fluencetype=fluence \
    persist.vendor.audio.fluence.voicecall=true \
    persist.vendor.audio.fluence.voicerec=false \
    persist.vendor.audio.fluence.speaker=true \
    vendor.voice.path.for.pcm.voip=true \
    audio.offload.min.duration.secs=30 \
    audio.offload.video=true \
    vendor.audio.offload.buffer.size.kb=1024 \
    vendor.audio.offload.gapless.enabled=true \
    vendor.audio.offload.multiple.enabled=false \
    vendor.audio.offload.track.enable=true \
    audio.ds1.metainfo.key=273 \
    dmid=-1286820014

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.qcom.bluetooth.soc=smd

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    camera.hal1.packagelist=com.skype.raider,com.google.android.talk \
    camera.lowpower.record.enable=1 \
    camera.display.umax=1920x1080 \
    camera.display.lmax=1280x720 \
    media.camera.ts.monotonic=1 \
    persist.camera.stats.test=5

# Core Control
PRODUCT_PROPERTY_OVERRIDES += \
    ro.core_ctl_min_cpu=2 \
    ro.core_ctl_max_cpu=4

# Display
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.hw=1 \
    debug.egl.hw=1 \
    persist.hwc.mdpcomp.enable=true \
    debug.mdpcomp.logs=0 \
    dev.pm.dyn_samplingrate=1 \
    persist.demo.hdmirotationlock=false \
    debug.enable.sglscale=1 \
    ro.opengles.version=196610 \
    ro.sf.lcd_density=480 \
    debug.hwui.use_buffer_age=false

# Dex2oat optimisation
# use all Cores during bootup dex compilation
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.boot-dex2oat-threads=8

# use 4 cores durning normal dex compilation (app installations)
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-threads=4

# use 4 cores during boot image dex compilation
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.image-dex2oat-threads=4

# Enable music through deep buffer
PRODUCT_PROPERTY_OVERRIDES += \
    audio.deep_buffer.media=true

# Enable downsampling for multi-channel content > 48Khz
PRODUCT_PROPERTY_OVERRIDES += \
    audio.playback.mch.downsample=true

# Factory Reset Protection
PRODUCT_PROPERTY_OVERRIDES += \
    ro.frp.pst=/dev/block/platform/soc.0/7824900.sdhci/by-name/config

# Fingerprint
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.fingerprint=goodix

#low audio flinger standby delay to reduce power consumption
PRODUCT_PROPERTY_OVERRIDES += \
    ro.audio.flinger_standbytime_ms=300

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    mm.enable.smoothstreaming=false \
    mm.enable.sec.smoothstreaming=false \
    media.stagefright.log-uri=1 \
    media.stagefright.use-awesome=false \
    media.stagefright.enable-player=true \
    media.stagefright.enable-http=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-qcp=true \
    media.stagefright.enable-fma2dp=true \
    media.stagefright.enable-scan=true \
    media.aac_51_output_enabled=true \
    mmp.enable.3g2=true \
    ro.media.enc.aud.fileformat=qcp \
    ro.media.enc.aud.codec=qcelp \
    ro.media.enc.aud.bps=13300 \
    ro.media.enc.aud.ch=1 \
    ro.media.enc.aud.hz=8000 \
    av.offload.enable=false \
    vendor.use.voice.path.for.pcm.voip=false \
    media.msm8956.version=0 \
    media.msm8956hw=0 \
    mm.enable.qcom_parser=135715 \
    vidc.enc.dcvs.extra-buff-count=2 \
    vidc.enc.narrow.searchrange=1 \
    mm.enable.sec.smoothstreaming=false

# NITZ
PRODUCT_PROPERTY_OVERRIDES += \
    persist.rild.nitz_plmn="" \
    persist.rild.nitz_long_ons_0="" \
    persist.rild.nitz_long_ons_1="" \
    persist.rild.nitz_long_ons_2="" \
    persist.rild.nitz_long_ons_3="" \
    persist.rild.nitz_short_ons_0="" \
    persist.rild.nitz_short_ons_1="" \
    persist.rild.nitz_short_ons_2="" \
    persist.rild.nitz_short_ons_3=""

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.enable_prefetch=1 \
    vendor.iop.enable_uxe=1 \
    vendor.iop.enable_prefetch_ofr=1 \
    vendor.perf.iop_v3.enable=1 \
    persist.vendor.qti.games.gt.prof=1 \
    ro.vendor.at_library=libqti-at.so \
    ro.vendor.extension_library=libqti-perfd-client.so \
    ro.vendor.qti.core_ctl_min_cpu=2 \
    ro.vendor.qti.core_ctl_max_cpu=4 \
    ro.vendor.qti.sys.fw.bg_apps_limit=60

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
    DEVICE_PROVISIONED=1 \
    ril.subscription.types=RUIM \
    rild.libargs=-d /dev/smd0 \
    rild.libpath=/vendor/lib64/libril-qc-qmi-1.so \
    ro.telephony.default_network=22,20 \
    ro.config.vc_call_vol_steps=7 \
    telephony.lteOnCdmaDevice=1 \
    persist.dbg.ims_volte_enable=1 \
    persist.dbg.volte_avail_ovr=1 \
    persist.dbg.vt_avail_ovr=1 \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.radio.multisim.config=none \
    persist.radio.videopause.mode=1 \
    persist.radio.schd.cache=3500 \
    persist.vendor.radio.adb_log_on=1 \
    persist.vendor.radio.add_power_save=1 \
    persist.vendor.radio.cs_srv_type=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.data_ltd_sys_ind=1 \
    persist.vendor.radio.force_on_dc=true \
    persist.vendor.radio.hw_mbn_update=0 \
    persist.vendor.radio.rat_on=combine \
    persist.vendor.radio.redir_party_num=0 \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.start_ota_daemon=1 \
    persist.vendor.radio.sw_mbn_update=0 \
    persist.data.qmi.adb_logmask=0 \
    persist.radio.aosp_usr_pref_sel=true

# set cutoff voltage to 3200mV
PRODUCT_PROPERTY_OVERRIDES += \
    ro.cutoff_voltage_mv=3200

# Time services
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.delta_time.enable=true

#UI efficiency props
PRODUCT_PROPERTY_OVERRIDES += \
    ro.min.fling_velocity=160 \
    ro.max.fling_velocity=20000

# Wifi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0

# ZRAM
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.config.zram=true

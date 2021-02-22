ifeq ($(SDK_BASECFG_HI3559V200),)
SDK_BASECFG_HI3559V200 = 1

# Check Parameter
ifeq ($(SDK_ROOT),)
    $(error please specify sdk root path)
endif

##########################################################################################
#	SoC Configure
##########################################################################################
KCONFIG_CFLAGS   += -D__arm__

##########################################################################################
#	SDK Configure
##########################################################################################
SDK_ARCH            := arm
SDK_COMPILE_OPT := CHIP=$(CFG_SUBCHIP_TYPE)

endif # ifndef $(SDK_BASECFG_HI3559V200)

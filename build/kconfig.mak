ifeq ($(SDK_KCONFIG),)
SDK_KCONFIG = 1

# Check Parameter
ifeq ($(SDK_ROOT),)
    $(error please specify sdk root path)
endif

##########################################################################################
#	Kconfig Common Configure
##########################################################################################
KCONFIG_CONFIG   ?= $(SDK_ROOT)/.config
ifeq ($(KCONFIG_CONFIG), $(wildcard $(KCONFIG_CONFIG)))
include $(KCONFIG_CONFIG)
endif
KCONFIG_CFLAGS   :=

#++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Architecture Type
#++++++++++++++++++++++++++++++++++++++++++++++++++++
ifeq ($(CONFIG_ARM_ARCH), y)
CFG_ARCH    := arm
else ifeq ($(CONFIG_LINUX_X86), y)
CFG_ARCH    := linux_x86
else ifeq ($(CONFIG_LINUX_X86_64), y)
CFG_ARCH    := linux_x86_64
else ifeq ($(CONFIG_WINDOWS_X86), y)
CFG_ARCH    := windows_x86
else ifeq ($(CONFIG_WINDOWS_X86_64), y)
CFG_ARCH    := windows_x86_64
endif

#++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Chip Type
#++++++++++++++++++++++++++++++++++++++++++++++++++++
ifeq ($(CONFIG_RTL8197FH), y)
CFG_CHIP_TYPE    := rtl8197fh
CFG_SUBCHIP_TYPE := rtl8197fh
KCONFIG_CFLAGS   += -DRTL8197FH -D__RTL8197FH__
else ifeq ($(CONFIG_HI3556V100), y)
CFG_CHIP_TYPE    := hi3556av100
CFG_SUBCHIP_TYPE := hi3556av100
KCONFIG_CFLAGS   += -DHI3556V100 -D__HI3556V100__
else ifeq ($(CONFIG_HI3559V100), y)
CFG_CHIP_TYPE    := hi3559v100
CFG_SUBCHIP_TYPE := hi3559v100
KCONFIG_CFLAGS   += -DHI3559V100 -D__HI3559V100__
else ifeq ($(CONFIG_HI3559V200), y)
CFG_CHIP_TYPE    := hi3559v200
CFG_SUBCHIP_TYPE := hi3559v200
KCONFIG_CFLAGS   += -DHI3559V200 -D__HI3559V200__
else ifeq ($(CONFIG_HI3556V200), y)
CFG_CHIP_TYPE    := hi3559v200
CFG_SUBCHIP_TYPE := hi3556v200
KCONFIG_CFLAGS   += -DHI3559V200 -D__HI3559V200__ -DHI3556V200 -D__HI3556V200__
else ifeq ($(CONFIG_SSC325), y)
CFG_CHIP_TYPE    := ssc325
CFG_SUBCHIP_TYPE := ssc325
KCONFIG_CFLAGS   += -DSSC325 -D__SSC325__
endif

#++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Cross ToolChain
#++++++++++++++++++++++++++++++++++++++++++++++++++++
ifeq ($(CONFIG_LINUX_CROSS_MSDK), y)
export LINUX_CROSS      := msdk-linux
LIBC_TYPE        := glibc
KCONFIG_CFLAGS   += -D__GLIBC__
else ifeq ($(CONFIG_LINUX_CROSS_HISIV600), y)
export LINUX_CROSS      := arm-hisiv600-linux
LIBC_TYPE        := glibc
KCONFIG_CFLAGS   += -D__HI_GLIBC__
else ifeq ($(CONFIG_LINUX_CROSS_HIMIX100), y)
export LINUX_CROSS      := arm-himix100-linux
LIBC_TYPE        := uclibc
KCONFIG_CFLAGS   += -D__HI_UCLIBC__
else ifeq ($(CONFIG_LINUX_CROSS_ARCH64_HIMIX100), y)
export LINUX_CROSS      := aarch64-himix100-linux
LIBC_TYPE        := glibc
KCONFIG_CFLAGS   += -D__HI_GLIBC__
LINUX_ARCH64     := y
else ifeq ($(CONFIG_LINUX_CROSS_UCLIBC_HARD_FLOAT), y)
export LINUX_CROSS      := arm-buildroot-linux-uclibcgnueabihf
LIBC_TYPE        := uclibc
KCONFIG_CFLAGS   += -D__UCLIBC__
else ifeq ($(CONFIG_LINUX_CROSS_GNU), y)
export LINUX_CROSS      := 
LIBC_TYPE        := glibc
KCONFIG_CFLAGS   += -D__GLIBC__
ifeq ($(CONFIG_LINUX_X86_64), y)
LINUX_ARCH64     := y
endif
endif

#CoreDump
ifeq ($(CONFIG_COREDUMP_ON), y)
KCONFIG_CFLAGS   += -DCONFIG_COREDUMP_ON
endif

#Build Type
ifeq ($(CONFIG_RELEASE), y)
export CFG_VERSION := release
KCONFIG_CFLAGS   += -DCONFIG_RELEASE
endif

ifeq ($(CONFIG_DEBUG), y)
export CFG_VERSION := debug
KCONFIG_CFLAGS   += -DCONFIG_DEBUG
endif

#Log Level
ifeq ($(CONFIG_LOG_LEVEL_DEBUG), y)
KCONFIG_CFLAGS   += -DCONFIG_LOG_LEVEL_DEBUG
endif

ifeq ($(CONFIG_LOG_LEVEL_ERR), y)
KCONFIG_CFLAGS   += -DCONFIG_LOG_LEVEL_ERR
endif

#Log File
ifeq ($(CONFIG_LOG_FILE_ON), y)
KCONFIG_CFLAGS   += -DCONFIG_LOG_FILE_ON
endif

ifeq ($(CONFIG_LOG_FILE_OFF), y)
KCONFIG_CFLAGS   += -DCONFIG_LOG_FILE_OFF
endif

#Sichuan CT Mojing
ifeq ($(CONFIG_SICHUAN_CT_MOJING), y)
KCONFIG_CFLAGS   += -DCONFIG_SICHUAN_CT_MOJING
endif

endif # ifndef $(SDK_KCONFIG)

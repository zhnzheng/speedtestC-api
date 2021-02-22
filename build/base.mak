ifeq ($(SDK_BASECFG),)
SDK_BASECFG = 1

# Check Parameter
ifeq ($(SDK_ROOT),)
    $(error please specify sdk root path)
endif

# Create Directory
CreateDir = $(shell [ -d $1 ] || mkdir -p $1 || echo ":mkdir '$1' fail")
# Remove Directory
RemoveDir = $(shell [ -d $1 ] && rm -rf $1 && echo -e "rmdir '$1'\t [ OK ]" || echo ":rm dir '$1' fail")

##########################################################################################
# Kconfig Common Configure
##########################################################################################
include $(SDK_ROOT)/build/kconfig.mak

##########################################################################################
# Thirdparty (open-source) Configure
##########################################################################################
THIRDPARTY_ROOT              := $(SDK_ROOT)/thirdparty
THIRDPARTY_SCRIPT_PATH  := $(SDK_ROOT)/script
THIRDPARTY_INSTALL_PATH := $(SDK_ROOT)/output/install

# open-source is based on tar.gz
THIRDPARTY_FILES := $(shell find $(THIRDPARTY_ROOT) -name '*.tar.gz')
THIRDPARTY_SOURCES := $(THIRDPARTY_FILES:%.tar.gz=%)
THIRDPARTY_SOURCES := $(notdir $(THIRDPARTY_SOURCES))

##########################################################################################
# Application Configure
##########################################################################################
APP_ROOT              := $(SDK_ROOT)/app
APP_COMMON_PATH    := $(APP_ROOT)/common
APP_THIRDPARTY_PATH   := $(APP_ROOT)/thirdparty

dummy := $(call CreateDir, $(THIRDPARTY_INSTALL_PATH))

endif # ifndef $(SDK_BASECFG)

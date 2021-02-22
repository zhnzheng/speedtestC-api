ifeq ($(PDT_PDT_BASECFG),)
PDT_PDT_BASECFG = 1

CreateDir = $(shell [ -d $1 ] || mkdir -p $1 || echo ":mkdir '$1' fail")

##########################################################################################
# Check Parameter
##########################################################################################
ifeq ($(PDT_ROOT),)
$(error please specify app product path)
endif

##########################################################################################
#	Common Function Define
##########################################################################################

# Current Directory Name(exclude prefix)
CUR_DIR_NAME = $(shell pwd |sed 's/^\(.*\)[/]//' )

# Current Parent Directory Name(exclude prefix)
CUR_PARENT_DIR_NAME = $(shell cd ./..;pwd|sed 's/^\(.*\)[/]//')

# Make Result Check
MAKE_EXT_FLAG := || exit "$$?"

COMMIT_VERSION = $(shell git show HEAD | head -1 | grep commit | sed 's/commit\ //')

##########################################################################################
#	Common Definition
##########################################################################################
# Reference Product Define
PDT_ROOT        := $(shell cd $(PDT_ROOT); pwd)
PDT_COMM_ROOT     := $(PDT_ROOT)/common
PDT_THIRDPARTY_ROOT := $(PDT_ROOT)/thirdparty
COMPILE_ROOT      := $(PDT_ROOT)/build
PDT_APP_ROOT       := $(PDT_ROOT)/application
PDT_TOOLS_ROOT   := $(PDT_ROOT)/tools
PROJECT_ROOT       := $(shell cd $(PDT_ROOT)/..; pwd)

include $(COMPILE_ROOT)/cfg.mak
include $(COMPILE_ROOT)/debug.mak

SDK_ROOT ?= $(shell cd $(PDT_ROOT)/..; pwd)
include $(SDK_ROOT)/build/base.mak

# Toolchains
CC := $(LINUX_CROSS)-gcc
CXX := $(LINUX_CROSS)-g++
CCDEP := $(LINUX_CROSS)-gcc
CXXDEP := $(LINUX_CROSS)-g++
STRIP := $(LINUX_CROSS)-strip
AR := $(LINUX_CROSS)-ar

ifeq ($(LINUX_CROSS),)
CC := gcc
CXX := g++
CCDEP := gcc
CXXDEP := g++
STRIP := strip
AR := ar
endif

# App Out Definition
PDT_OUT_ROOT := $(PROJECT_ROOT)/output

PDT_OUT_COMM     := $(PDT_OUT_ROOT)/common
PDT_OUT_COMM_OBJ := $(PDT_OUT_COMM)/obj/$(CUR_DIR_NAME)
PDT_OUT_COMM_LIB := $(PDT_OUT_COMM)/lib
PDT_OUT_THIRD      := $(PDT_OUT_ROOT)/thirdparty
PDT_OUT_THIRD_OBJ  := $(PDT_OUT_THIRD)/obj/$(CUR_DIR_NAME)
PDT_OUT_THIRD_LIB  := $(PDT_OUT_THIRD)/lib
PDT_OUT_APP_ROOT   := $(PDT_OUT_ROOT)/bin
PDT_OUT_APP_OBJ  := $(PDT_OUT_ROOT)/app/obj/$(CUR_DIR_NAME)
PDT_OUT_APP_LIB  := $(PDT_OUT_ROOT)/app/lib
PDT_OUT_TOOLS_ROOT   := $(PDT_OUT_ROOT)/tools
PDT_OUT_TOOLS_OBJ  := $(PDT_OUT_TOOLS_ROOT)/obj/$(CUR_DIR_NAME)
PDT_OUT_TOOLS_BIN   := $(PDT_OUT_TOOLS_ROOT)/bin

##########################################################################################
#	Base Configure
##########################################################################################
# COMPILE Parameter
-include $(COMPILE_ROOT)/inc.mak
include $(PDT_COMM_ROOT)/inc.mak
include $(PDT_APP_ROOT)/inc.mak

endif # ifndef $(PDT_PDT_BASECFG)

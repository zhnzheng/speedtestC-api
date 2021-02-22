CUR_ROOT    := $(shell pwd)
PDT_ROOT    ?= $(CUR_ROOT)/../..
include $(PDT_ROOT)/build/base.mak

OPENSSL_CFLAGS = -DOPENSSL -DURL_PROTOCOL='"https"'
PDT_DEFS	+= $(OPENSSL_CFLAGS)

# Lib Name (only support static lib)
LIB_NAME := libspeedtest.a
LIB_SO_NAME := libspeedtest.so

# Source Path
SRC_ROOT    := $(CUR_ROOT)

# Source Include Path
SRC_INCLUDE_PATH := -I./include
SRC_INCLUDE_PATH += -I./src
SRC_INCLUDE_PATH += -I$(THIRDPARTY_INSTALL_PATH)/$(CFG_ARCH)/$(LINUX_CROSS)/include

# Common Path Define
OBJ_ROOT    := $(PDT_OUT_COMM_OBJ)
LIB_ROOT    := $(PDT_OUT_COMM_LIB)

include $(PDT_ROOT)/build/script/modbuild.mak

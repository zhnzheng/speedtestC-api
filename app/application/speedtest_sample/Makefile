# Base Define
SRC_ROOT := $(shell pwd)
PDT_ROOT ?= $(SRC_ROOT)/../..
include $(PDT_ROOT)/build/base.mak
include $(PDT_ROOT)/build/cfg.mak

# Bulid Info
BUILD_TIME := $(shell date +%Y%m%d)
BUILD_SOFTVERSION := $(CFG_SOFT_VERSION).$(BUILD_TIME)

# App cflags
APP_CFLAGS := -Wall -g -pipe -D_GNU_SOURCE 

APP_LIBS := -lm -lpthread -lresolv 

# Common Libs
COMM_LIBS  := -L$(PDT_OUT_COMM_LIB) 
COMM_LIBS += -lspeedtest

# Common Libs    
THIRD_LIBS  := -L$(PDT_OUT_THIRD_LIB) 
THIRD_LIBS  += -ldl -lssl -lcrypto

# App Libs
APP_LIBS += $(COMM_LIBS)
APP_LIBS += $(THIRD_LIBS)
APP_LIBS += -L$(THIRDPARTY_INSTALL_PATH)/$(CFG_ARCH)/$(LINUX_CROSS)/lib
APP_LIBS += 


PDT_INCLUDE_PATH+= -I$(THIRDPARTY_INSTALL_PATH)/$(CFG_ARCH)/$(LINUX_CROSS)/include
PDT_INCLUDE_PATH+=-I$(SRC_ROOT)/common

# Path Define
SRC_ROOT	:= $(SRC_ROOT)/
OBJ_ROOT	:= $(PDT_OUT_APP_OBJ)
EXE_ROOT	:= $(PDT_OUT_APP_ROOT)

# Target
NAME := speedtest_sample
EXE := $(EXE_ROOT)/$(NAME)

# Source and Object File 
# Cpp Source
SRCS_CPP        := $(shell find $(SRC_ROOT) -name '*.cpp')
SRCS_CPP        := $(sort $(SRCS_CPP))

OBJS_CPP        := $(SRCS_CPP:$(SRC_ROOT)%.cpp=$(OBJ_ROOT)/%.o)
OBJS_CPP        := $(sort $(OBJS_CPP))
OBJS_CPP_DIR  := $(dir $(OBJS_CPP))
SRC_CPP_DEPS := $(OBJS_CPP:%.o=%.d)

# C Source
SRCS_C        := $(shell find $(SRC_ROOT) -name '*.c')
SRCS_C        := $(sort $(SRCS_C))

OBJS_C        := $(SRCS_C:$(SRC_ROOT)%.c=$(OBJ_ROOT)/%.o)
OBJS_C        := $(sort $(OBJS_C))
OBJ_C_DIR    := $(dir $(OBJS_C))
SRC_C_DEPS := $(OBJS_C:%.o=%.d)

# Create Object and Release Directory
CreateResult :=
dummy := $(call CreateDir, $(OBJ_ROOT))
dummy += $(call CreateDir, $(EXE_ROOT))
dummy += $(foreach dir, $(OBJS_CPP_DIR), CreateResult += $(call CreateDir, $(dir)))
dummy += $(foreach dir, $(OBJ_C_DIR), CreateResult += $(call CreateDir, $(dir)))
ifneq ($(strip CreateResult),)
    err = $(error $(CreateResult))
endif

# Compile Define
COMPILE_CPP    = $(CXX) $(PDT_DEFS)  $(VSS_CFLAGS) -c "$<" -o "$@" $(PDT_INCLUDE_PATH)
COMPILEDEP_CPP = $(CXX) -MM "$<"  $(PDT_DEFS)  $(VSS_CFLAGS) $(PDT_INCLUDE_PATH)
COMPILE_C    = $(CC) $(PDT_DEFS) $(VSS_CFLAGS) -c "$<" -o "$@" $(PDT_INCLUDE_PATH)
COMPILEDEP_C = $(CC) -MM "$<"  $(PDT_DEFS) $(VSS_CFLAGS) $(PDT_INCLUDE_PATH)
LINK = $(CXX) $(APP_CFLAGS)

.PHONY: all clean distclean
all: target success

success:
	@echo -e "\e[0;32;1m--compiling '$(notdir $(EXE))' finished\e[0;36;1m" 
	@echo -e "\e[0m" 

$(OBJS_CPP): $(OBJ_ROOT)/%.o :$(SRC_ROOT)/%.cpp
	@echo "compile ------------" $(notdir $@) "------------"
	@$(COMPILE_CPP)

$(SRC_CPP_DEPS): $(OBJ_ROOT)/%.d : $(SRC_ROOT)/%.cpp
	@echo "SRC_CPP_DEPS: " $(notdir $@)
	@set -e;$(COMPILEDEP_CPP) > $@.$$$$; \
	sed 's,.*\.o[ :]*,$(@:%.d=%.o) $@ : ,g' < $@.$$$$ > $@;rm -f $@.$$$$

$(OBJS_C): $(OBJ_ROOT)/%.o :$(SRC_ROOT)/%.c
	@echo "compile ------------" $(notdir $@) "------------"
	@$(COMPILE_C)

$(SRC_C_DEPS): $(OBJ_ROOT)/%.d : $(SRC_ROOT)/%.c
	@echo "SRC_C_DEPS: " $(notdir $@)
	@set -e;$(COMPILEDEP_C) > $@.$$$$; \
	sed 's,.*\.o[ :]*,$(@:%.d=%.o) $@ : ,g' < $@.$$$$ > $@;rm -f $@.$$$$

target: $(SRC_CPP_DEPS) $(OBJS_CPP) $(SRC_C_DEPS) $(OBJS_C)
	@echo "* CREATE $(EXE)"
	@$(LINK) -o $(EXE) -Wl,--start-group $(OBJS_CPP) $(OBJS_C) $(APP_LIBS) -Wl,--end-group
#@$(STRIP) $(EXE)

clean:
	@rm -rf $(EXE)
	@rm -f $(OBJS_CPP)
	@rm -f $(OBJS_C)
	@rm -rf $(OBJ_ROOT)

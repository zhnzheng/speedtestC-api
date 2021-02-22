## common module build Makefile
ifndef $(MODULE_BUILD)
MODULE_BUILD = 1

# Check Parameter
ifeq ($(PDT_ROOT),)
    $(error please specify product root path)
endif

# Path Define
SRC_ROOT    := $(SRC_ROOT)/
OBJ_ROOT    := $(OBJ_ROOT)
LIB_ROOT    := $(LIB_ROOT)

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

# Module Include Path
PDT_INCLUDE_PATH += $(SRC_INCLUDE_PATH)

# Create Object and Release Directory
CreateResult :=
dummy := $(call CreateDir, $(OBJ_ROOT))
dummy += $(call CreateDir, $(LIB_ROOT))
dummy += $(foreach dir, $(OBJS_CPP_DIR), CreateResult += $(call CreateDir, $(dir)))
dummy += $(foreach dir, $(OBJ_C_DIR), CreateResult += $(call CreateDir, $(dir)))
ifneq ($(strip CreateResult),)
    err = $(error $(CreateResult))
endif

# Lib Name
LIB	   := $(LIB_ROOT)/$(LIB_NAME)
SOLIB  := $(LIB_ROOT)/$(LIB_SO_NAME)

PDT_DEFS  += -Wall -pipe -DLINUX_OS -DOS_LINUX
PDT_DEFS  += -D__STDC_WANT_LIB_EXT1__=1 -DCOMMIT_VERSION=\"$(COMMIT_VERSION)\"
PDT_DEFS += $(KCONFIG_CFLAGS)
COMPILE_CPP    = $(CXX) $(PDT_DEFS) -std=c++0x $(VSS_CFLAGS) -c "$<" -o "$@" $(PDT_INCLUDE_PATH)
COMPILEDEP_CPP = $(CXX) -MM "$<"  $(PDT_DEFS) -std=c++0x $(VSS_CFLAGS) $(PDT_INCLUDE_PATH)
COMPILE_C    = $(CC) $(PDT_DEFS) $(VSS_CFLAGS) -c "$<" -o "$@" $(PDT_INCLUDE_PATH)
COMPILEDEP_C = $(CC) -MM "$<"  $(PDT_DEFS) $(VSS_CFLAGS) $(PDT_INCLUDE_PATH)
LINK       = $(CXX) $(PDT_DEFS) $(VSS_CFLAGS)
ARFLAGS = sq

SRC_DEPS := $(SRC_C_DEPS)
SRC_DEPS += $(SRC_CPP_DEPS)

# Compile PHONY
.PHONY: all $(LIB) clean  distclean
default: all

all: $(LIB) success

success:
	@echo -e "\e[0;32;1m--compiling '$(notdir $(LIB))' finished\e[0;36;1m"
	@#echo "--compiling '$(notdir $(SOLIB))' finished"
	@echo -e "\e[0m"

$(OBJS_CPP): $(OBJ_ROOT)/%.o :$(SRC_ROOT)%.cpp
	@echo "compile ------------" $(notdir $@) "------------"
	@$(COMPILE_CPP)

$(SRC_CPP_DEPS): $(OBJ_ROOT)/%.d : $(SRC_ROOT)%.cpp
	@echo "SRC_CPP_DEPS: " $(notdir $@)
	@set -e;$(COMPILEDEP_CPP) > $@.$$$$; \
	sed 's,.*\.o[ :]*,$(@:%.d=%.o) $@ : ,g' < $@.$$$$ > $@;rm -f $@.$$$$

$(OBJS_C): $(OBJ_ROOT)/%.o :$(SRC_ROOT)%.c
	@echo "compile ------------" $(notdir $@) "------------"
	@$(COMPILE_C)

$(SRC_C_DEPS): $(OBJ_ROOT)/%.d : $(SRC_ROOT)%.c
	@echo "SRC_C_DEPS: " $(notdir $@)
	@set -e;$(COMPILEDEP_C) > $@.$$$$; \
	sed 's,.*\.o[ :]*,$(@:%.d=%.o) $@ : ,g' < $@.$$$$ > $@;rm -f $@.$$$$

$(LIB): $(SRC_CPP_DEPS) $(OBJS_CPP) $(SRC_C_DEPS) $(OBJS_C)
	@echo "* CREATE $(LIB)"
	@$(AR) $(ARFLAGS) $@ $(OBJS_CPP) $(OBJS_C) $(VSS_STLIB)

$(SOLIB): $(SRC_DEPS) $(OBJS_CPP) $(SRC_C_DEPS) $(OBJS_C)
	@echo "* CREATE $(SOLIB)"
	@$(CXX) -rdynamic -ldl -fPIC  -shared -o $@ $(OBJS_CPP) $(OBJS_C)

clean:
	@if [ -d $(OBJ_ROOT) ]; then rm -rf $(OBJ_ROOT);fi

cleanall: clean

-include $(SRC_DEPS)

endif # ifndef $(MODULE_BUILD)

# Base Configure
PDT_ROOT := $(shell pwd)
PDT_ROOT := $(PDT_ROOT)
include $(PDT_ROOT)/build/base.mak

# Modules List
SUBMODULES := common application

# Modules Clean
SUBMODULES_CLEAN := $(addsuffix _clean,$(SUBMODULES))

# Compile Target
.PHONY: build rebuild clean distclean
.PHONY: prepare $(SUBMODULES) $(SUBMODULES_CLEAN)
default: build

build: prepare $(SUBMODULES)

rebuild: distclean build

install:
	@echo -e "\e[0;32;1m--install '$(notdir $(PDT_ROOT))' finished\e[0;36;1m"
	@echo -e "\e[0m"

clean: $(SUBMODULES_CLEAN)
	@echo clean is over!

distclean: clean
	@rm -rf $(PDT_ROOT)/output
	@echo distclean is over!

prepare:
	@echo " "

$(SUBMODULES):
	@echo -e "\e[0;32;1m--Compiling '$@'...\e[0;36;1m"
	@echo -e "\e[0m"
	@make -C $@||exit $?
	@echo -e "\e[0;32;1m--Compile '$@' finished\e[0;36;1m"
	@echo -e "\e[0m"

$(SUBMODULES_CLEAN):
	@echo -e "\e[0;32;1m--execute '$@'...\e[0;36;1m"
	@echo -e "\e[0m"
	@-cd $(patsubst %_clean,%,$@);make clean||exit $?;cd -

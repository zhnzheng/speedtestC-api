##########################################################################################
#	help config
##########################################################################################
.PHONY: help
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
GREEN="\e[32;1m"
NORMAL="\e[39m"
RED="\e[31m"
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
help:
	@echo -e ${GREEN}
	@#cat script/Readme|less
	@echo -e ${NORMAL}
##########################################################################################
#	menuconfig config
##########################################################################################
.PHONY: menuconfig
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#++++++++++++++++++++++++++++++++++++++++++++++++++++
KCONFIG_PATH= build/scripts/kconfig/
KCONFIG_EXE = build/scripts/kconfig/mconf
KCONFIG_CFG = Kconfig
#++++++++++++++++++++++++++++++++++++++++++++++++++++
prepare_kconfig:
	@if [ ! -f $(KCONFIG_EXE) ];then cd $(KCONFIG_PATH);make;cd -;fi

menuconfig: prepare_kconfig
	@-chmod -Rf 777 $(KCONFIG_EXE)
	$(if $(wildcard $(KCONFIG_EXE)), \
		$(KCONFIG_EXE) $(KCONFIG_CFG), \
	)

#####################################################################
#	compile config
#####################################################################
export SDK_ROOT  := $(shell pwd)
include $(SDK_ROOT)/build/base.mak

.PHONY: all clean distclean prepare
.PHONY: thirdparty thirdparty_clean thirdparty_distclean
.PHONY: app app_clean app_distclean

all: prepare thirdparty app success

clean: app_clean thirdparty_clean

distclean: app_distclean thirdparty_distclean

success:
	@echo -e "\e[0;32;1m--install '$(notdir $(SDK_ROOT))' finished\e[0;36;1m"
	@echo -e "\e[0m"

prepare:
	@chmod +x $(SDK_ROOT)/build/*

prepare_clean:
	@chmod +x $(SDK_ROOT)/build/*

#++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Thirdparty Open-source Compile
#++++++++++++++++++++++++++++++++++++++++++++++++++++
thirdparty_prepare:
	@if [ -f prepare.sh ];then  ;fi;cd -

thirdparty: prepare
	@chmod 777 $(THIRDPARTY_INSTALL_PATH) -R
	@sh $(THIRDPARTY_SCRIPT_PATH)/build.sh $(SDK_ROOT) $(THIRDPARTY_INSTALL_PATH) $(CFG_ARCH) $(LINUX_CROSS)

thirdparty_clean:
	@for source in $(THIRDPARTY_SOURCES);do make -j8 -C $$source clean;done

thirdparty_distclean:
	@for source in $(THIRDPARTY_SOURCES);do rm -rf $$source;done
	@rm -rf $(THIRDPARTY_INSTALL_PATH)/$(CFG_ARCH)/$(LINUX_CROSS) || exit $?

#++++++++++++++++++++++++++++++++++++++++++++++++++++
#	Application Compile
#++++++++++++++++++++++++++++++++++++++++++++++++++++
app: prepare
	@make -C $(APP_ROOT) || exit $?

app_clean:
	@make clean -C $(APP_ROOT)||exit $?

app_distclean:
	@make distclean -C $(APP_ROOT)||exit $?

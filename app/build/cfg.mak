# software version: packet(1:uclibc).main.sub.build
CFG_SOFT_VERSION := 1.1.0.1

# chip : i6
CFG_BOARD_CHIP   := $(CHIP)
# board type : 009A
CFG_BOARD_TYPE   := $(BOARD)
# board name : SSC009A-S01A
CFG_BOARD_NAME := $(BOARD_NAME)

# storage (sdcard) filesystem check
CFG_STORAGE_FS_CHECK := no

# osd cover (reserve func)
CFG_OSD_COVER_ON := no

include $(PDT_ROOT)/build/debug.mak

################################################################################
#
# rtl88x2bu
#
################################################################################

ifeq ($(LOCAL_DOWNLOAD),y)
RTL88X2BU_OPENIPC_SITE_METHOD = git
RTL88X2BU_OPENIPC_SITE = https://github.com/morrownr/88x2bu-20210702
RTL88X2BU_OPENIPC_VERSION = $(shell git ls-remote $(RTL88X2BU_OPENIPC_SITE) HEAD | head -1 | cut -f1)
else
RTL88X2BU_OPENIPC_SITE = https://github.com/morrownr/88x2bu-20210702/archive
RTL88X2BU_OPENIPC_SOURCE = master.tar.gz
endif

RTL88X2BU_OPENIPC_LICENSE = GPL-2.0
RTL88X2BU_OPENIPC_LICENSE_FILES = COPYING

RTL88X2BU_OPENIPC_MODULE_MAKE_OPTS = CONFIG_RTL88X2BU=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR)

$(eval $(kernel-module))
$(eval $(generic-package))

MCHS_PKG_HOMEPAGE=https://www.heyu.org/
MCHS_PKG_DESCRIPTION="Program for remotely controlling lights and appliances"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.11-rc3
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/HeyuX10Automation/heyu/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6285f134e03688b5ec03986ef53cce463abc007281996156cac52b61cbeb58b2
MCHS_PKG_AUTO_UPDATE=true

mchs_step_pre_configure() {
	# rindex is an obsolete version of strrchr which is not available in Android:
	CFLAGS+=" -Drindex=strrchr"
}

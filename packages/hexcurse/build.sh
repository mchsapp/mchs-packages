MCHS_PKG_HOMEPAGE=https://github.com/LonnyGomes/hexcurse
MCHS_PKG_DESCRIPTION="Console hexeditor"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.60.0
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/LonnyGomes/hexcurse/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f6919e4a824ee354f003f0c42e4c4cef98a93aa7e3aa449caedd13f9a2db5530
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ncurses"

mchs_step_pre_configure() {
	export CFLAGS+=" -fcommon"
}

MCHS_PKG_HOMEPAGE=http://www.vanheusden.com/multitail/
MCHS_PKG_DESCRIPTION="Tool to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.5.0
MCHS_PKG_SRCURL=https://fossies.org/linux/privat/multitail-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=b29d5e77dfc663c7500f78da67de5d82d35d9417a4741a89a18ce9ee7bdba9ed
MCHS_PKG_DEPENDS="ncurses, ncurses-ui-libs, libandroid-glob"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" -DNCURSES_WIDECHAR"
	LDFLAGS+=" -landroid-glob"
}

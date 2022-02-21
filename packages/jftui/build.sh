MCHS_PKG_HOMEPAGE=https://github.com/Aanok/jftui
MCHS_PKG_DESCRIPTION="jftui is a minimalistic, lightweight C99 command line client for the open source Jellyfin media server."
MCHS_PKG_LICENSE="Unlicense"
MCHS_PKG_MAINTAINER="Maxr1998 <max.rumpf1998@gmail.com>"
MCHS_PKG_VERSION=0.5.1
MCHS_PKG_SRCURL=https://github.com/Aanok/jftui/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=406727e4f021cd0c6cf9c1a6199d81fbc4e523a881f62c323fe363e8505dc25d
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libcurl, yajl, mpv"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	sed -i 's| -march=native||' Makefile
	sed -i 's|^CFLAGS=|override CFLAGS+=|' Makefile
	sed -i 's|^LFLAGS=|override LFLAGS+=|' Makefile
}

mchs_step_make() {
	make CFLAGS="$CPPFLAGS" LFLAGS="$LDFLAGS"
}

mchs_step_make_install() {
	install -Dm700 $MCHS_PKG_SRCDIR/build/jftui "$MCHS_PREFIX/bin/jftui"
}

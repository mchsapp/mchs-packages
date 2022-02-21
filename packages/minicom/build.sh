MCHS_PKG_HOMEPAGE=https://salsa.debian.org/minicom-team/minicom
MCHS_PKG_DESCRIPTION="Friendly menu driven serial communication program"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.7.1
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://alioth-archive.debian.org/releases/minicom/Source/$MCHS_PKG_VERSION/minicom-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=532f836b7a677eb0cb1dca8d70302b73729c3d30df26d58368d712e5cca041f1
MCHS_PKG_DEPENDS="libiconv, ncurses"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-socket
--disable-music
--enable-lock-dir=$MCHS_PREFIX/var/run
"

mchs_step_pre_configure() {
	export CFLAGS+=" -fcommon"
}

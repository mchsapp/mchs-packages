MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/boinctui/
MCHS_PKG_DESCRIPTION="curses based manager for Boinc client"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.5.1
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL="https://sourceforge.net/projects/boinctui/files/boinctui_${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256=319f539535f3af342ec0bafc5228673bf12f2d7a7addf5851f2c003200e51da9
MCHS_PKG_DEPENDS="glib, libandroid-support, libexpat, ncurses, ncurses-ui-libs, openssl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-gnutls --mandir=$MCHS_PREFIX/share/man"

mchs_step_pre_configure() {
	CPPFLAGS+=" -DANDROID"
	LDFLAGS+=" -llog"
	autoconf
}

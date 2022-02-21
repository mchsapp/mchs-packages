MCHS_PKG_HOMEPAGE=http://www.irc.org/
MCHS_PKG_DESCRIPTION="An Internet Relay Chat (IRC) daemon"
MCHS_PKG_LICENSE="GPL-2.0" # GPL-1.0-or-later
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.11.2p3
MCHS_PKG_SRCURL=http://www.irc.org/ftp/irc/server/irc${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=be94051845f9be7da0e558699c4af7963af7e647745d339351985a697eca2c81
MCHS_PKG_DEPENDS="libcrypt, resolv-conf, zlib"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-resconf=$MCHS_PREFIX/etc/resolv.conf
ac_cv_func_setpgrp_void=yes
irc_cv_non_blocking_system=posix
"
MCHS_PKG_EXTRA_MAKE_ARGS="-C build"

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lcrypt"
}

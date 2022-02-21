MCHS_PKG_HOMEPAGE=https://tmate.io
MCHS_PKG_DESCRIPTION="Terminal multiplexer with instant terminal sharing"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/tmate-io/tmate/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=62b61eb12ab394012c861f6b48ba0bc04ac8765abca13bdde5a4d9105cb16138
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libandroid-support, libevent, libmsgpack, libssh, ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"

mchs_step_pre_configure() {
	CFLAGS+=" -DIOV_MAX=1024"

	./autogen.sh
}

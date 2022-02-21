MCHS_PKG_HOMEPAGE=https://www.gcd.org/sengoku/stone/
MCHS_PKG_DESCRIPTION="A TCP/IP repeater in the application layer"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4
MCHS_PKG_SRCURL=https://www.gcd.org/sengoku/stone/stone-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d5dc1af6ec5da503f2a40b3df3fe19a8fbf9d3ce696b8f46f4d53d2ac8d8eb6f
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="-e stone"

mchs_step_configure() {
	CFLAGS+=" $CPPFLAGS"
	export FLAGS="-DUSE_SSL -DUNIX_DAEMON -DNO_RINDEX -DUSE_EPOLL -DPTHREAD -DPRCTL -UANDROID"
	export LIBS="$LDFLAGS -lssl -lcrypto"
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin stone
}

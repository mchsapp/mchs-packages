MCHS_PKG_HOMEPAGE=http://www.stunprotocol.org/
MCHS_PKG_DESCRIPTION="An open source STUN server"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.16
MCHS_PKG_SRCURL=http://www.stunprotocol.org/stunserver-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=4479e1ae070651dfc4836a998267c7ac2fba4f011abcfdca3b8ccd7736d4fd26
MCHS_PKG_DEPENDS="libc++, openssl"
MCHS_PKG_BUILD_DEPENDS="boost"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="T=" # In case if environment variable `T` is defined

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin "$MCHS_PKG_BUILDDIR/stunclient"
	install -Dm700 -t $MCHS_PREFIX/bin "$MCHS_PKG_BUILDDIR/stunserver"
}

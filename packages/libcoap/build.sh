MCHS_PKG_HOMEPAGE=https://libcoap.net/
MCHS_PKG_DESCRIPTION="Implementation of CoAP, a lightweight protocol for resource constrained devices"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.3.0
MCHS_PKG_SRCURL=https://github.com/obgm/libcoap/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=1a195adacd6188d3b71c476e7b21706fef7f3663ab1fb138652e8da49a9ec556
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BREAKS="libcoap-dev"
MCHS_PKG_REPLACES="libcoap-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-openssl --disable-doxygen"

mchs_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}

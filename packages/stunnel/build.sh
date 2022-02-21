MCHS_PKG_HOMEPAGE=https://www.stunnel.org/
MCHS_PKG_DESCRIPTION="Socket wrapper which can provide TLS support to ordinary applications"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.62
MCHS_PKG_SRCURL=https://www.stunnel.org/downloads/stunnel-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9cf5bb949022aa66c736c1326554cca27d0641605a6370274edc4951eb5bd339
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-shared --with-ssl=$MCHS_PREFIX --disable-fips"
MCHS_PKG_RM_AFTER_INSTALL="bin/stunnel3 share/man/man8/stunnel.*.8"

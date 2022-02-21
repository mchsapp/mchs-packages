MCHS_PKG_HOMEPAGE=https://github.com/rakshasa/rtorrent/wiki
MCHS_PKG_DESCRIPTION="Libtorrent BitTorrent library"
MCHS_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_VERSION=0.13.8
MCHS_PKG_SRCURL=https://github.com/rakshasa/libtorrent/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0f6c2e7ffd3a1723ab47fdac785ec40f85c0a5b5a42c1d002272205b988be722
MCHS_PKG_DEPENDS="openssl, zlib"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-aligned=true
--without-fastcgi
--with-zlib=$MCHS_PREFIX
"

mchs_step_pre_configure() {
	./autogen.sh
}

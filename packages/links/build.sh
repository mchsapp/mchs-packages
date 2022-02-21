MCHS_PKG_HOMEPAGE=http://links.twibright.com
MCHS_PKG_DESCRIPTION="Links is a text and graphics mode WWW browser"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.25
MCHS_PKG_SRCURL=http://links.twibright.com/download/links-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=5c0b3b0b8fe1f3c8694f5fb7fbdb19c63278ac68ae4646da69b49640b20283b1
MCHS_PKG_DEPENDS="brotli, libbz2, libevent, liblzma, libpng, librsvg, libtiff, libx11, openssl, zlib, zstd"
MCHS_PKG_BUILD_DEPENDS="libxt"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$MCHS_PREFIX/share/man
--enable-graphics
--without-openmp
"

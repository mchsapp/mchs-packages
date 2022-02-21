MCHS_PKG_HOMEPAGE=http://www.simplesystems.org/libtiff/ # Note that http://libtiff.org/ is hijacked
MCHS_PKG_DESCRIPTION="Support for the Tag Image File Format (TIFF) for storing image data"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.3.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=http://download.osgeo.org/libtiff/tiff-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0e46e5acb087ce7d1ac53cf4f56a09b221537fc86dfc5daaad1c2e89e1b37ac8
MCHS_PKG_DEPENDS="libc++, libjpeg-turbo, liblzma, zlib, zstd"
MCHS_PKG_BREAKS="libtiff-dev"
MCHS_PKG_REPLACES="libtiff-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-cxx --disable-webp"

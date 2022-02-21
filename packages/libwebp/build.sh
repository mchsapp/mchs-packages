MCHS_PKG_HOMEPAGE=https://github.com/webmproject/libwebp
MCHS_PKG_DESCRIPTION="Library to encode and decode images in WebP format"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.1
MCHS_PKG_SRCURL=https://github.com/webmproject/libwebp/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=01bcde6a40a602294994050b81df379d71c40b7e39c819c024d079b3c56307f4
MCHS_PKG_DEPENDS="giflib, libjpeg-turbo, libpng, libtiff"
MCHS_PKG_BREAKS="libwebp-dev"
MCHS_PKG_REPLACES="libwebp-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libwebpmux
--enable-libwebpdemux
--enable-libwebpdecoder
--enable-libwebpextras
--enable-swap-16bit-csp
--enable-gif
--enable-jpeg
--enable-png
--enable-tiff
--disable-wic
"
MCHS_PKG_RM_AFTER_INSTALL="share/man/man1"

mchs_step_pre_configure() {
	./autogen.sh
}

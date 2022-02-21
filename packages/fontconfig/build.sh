MCHS_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/fontconfig/
MCHS_PKG_DESCRIPTION="Library for configuring and customizing font access"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.13.1
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://www.freedesktop.org/software/fontconfig/release/fontconfig-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=f655dd2a986d7aa97e052261b36aa67b0a64989496361eca8d604e6414006741
MCHS_PKG_DEPENDS="freetype, libxml2, libpng, libuuid, ttf-dejavu, zlib"
MCHS_PKG_BREAKS="fontconfig-dev"
MCHS_PKG_REPLACES="fontconfig-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-libxml2
--enable-iconv=no
--disable-docs
--with-default-fonts=/system/fonts
--with-add-fonts=$MCHS_PREFIX/share/fonts
"

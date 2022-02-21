MCHS_PKG_HOMEPAGE=https://libgd.github.io/
MCHS_PKG_DESCRIPTION="GD is an open source code library for the dynamic creation of images by programmers"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:2.3.3
MCHS_PKG_SRCURL=https://github.com/libgd/libgd/releases/download/gd-${MCHS_PKG_VERSION:2}/libgd-${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=dd3f1f0bb016edcc0b2d082e8229c822ad1d02223511997c80461481759b1ed2
MCHS_PKG_DEPENDS="freetype, fontconfig, libiconv, libjpeg-turbo, libpng, libtiff, libwebp, zlib"
MCHS_PKG_BREAKS="libgd-dev"
MCHS_PKG_REPLACES="libgd-dev"

# Disable vpx support for now, look at https://github.com/gagern/libgd/commit/d41eb72cd4545c394578332e5c102dee69e02ee8
# for enabling:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-vpx --without-x"

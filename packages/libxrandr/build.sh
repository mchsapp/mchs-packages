# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 RandR extension library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.2
MCHS_PKG_REVISION=24
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXrandr-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=8aea0ebe403d62330bb741ed595b53741acf45033d3bda1792f1d4cc3daee023
MCHS_PKG_DEPENDS="libx11, libxext, libxrender"
MCHS_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"

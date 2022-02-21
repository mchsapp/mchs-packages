# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 miscellaneous extensions library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.4
MCHS_PKG_REVISION=11
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXext-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=59ad6fcce98deaecc14d39a672cf218ca37aba617c9a0f691cac3bcd28edf82b
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
MCHS_PKG_DEPENDS="libx11, libxau, libxcb, libxdmcp"
MCHS_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"

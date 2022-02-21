# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 Input extension library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.10
MCHS_PKG_REVISION=23
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXi-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=36a30d8f6383a72e7ce060298b4b181fd298bc3a135c8e201b7ca847f5f81061
MCHS_PKG_DEPENDS="libx11, libxau, libxcb, libxdmcp, libxext"
MCHS_PKG_BUILD_DEPENDS="libxfixes, xorgproto, xorg-util-macros"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"

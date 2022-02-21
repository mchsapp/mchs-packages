# X11 package
MCHS_PKG_HOMEPAGE=https://xcb.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 client-side library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.14
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/lib/libxcb-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=a55ed6db98d43469801262d81dc2572ed124edc3db31059d4e9916eb9f844c34
MCHS_PKG_DEPENDS="libxau, libxdmcp"
MCHS_PKG_BUILD_DEPENDS="xcb-proto, xorg-util-macros"
MCHS_PKG_RECOMMENDS="xorg-xauth"

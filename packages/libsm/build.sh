# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 Session Management library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.3
MCHS_PKG_REVISION=17
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libSM-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=2d264499dcb05f56438dee12a1b4b71d76736ce7ba7aa6efbf15ebb113769cbb
MCHS_PKG_DEPENDS="libice, libuuid"
MCHS_PKG_BUILD_DEPENDS="xorg-util-macros, xtrans"

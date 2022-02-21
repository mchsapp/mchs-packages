# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 Testing -- Resource extension library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.3
MCHS_PKG_REVISION=26
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXtst-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=4655498a1b8e844e3d6f21f3b2c4e2b571effb5fd83199d428a6ba7ea4bf5204
MCHS_PKG_DEPENDS="libx11, libxext, libxi"
MCHS_PKG_BUILD_DEPENDS="libxfixes, xorg-util-macros"

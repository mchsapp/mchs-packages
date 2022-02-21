# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X cursor management library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.0
MCHS_PKG_REVISION=20
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXcursor-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=3ad3e9f8251094af6fe8cb4afcf63e28df504d46bfa5a5529db74a505d628782
MCHS_PKG_DEPENDS="libx11, libxfixes, libxrender"
MCHS_PKG_BUILD_DEPENDS="xorg-util-macros"

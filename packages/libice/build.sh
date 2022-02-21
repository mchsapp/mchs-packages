# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 Inter-Client Exchange library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.10
MCHS_PKG_REVISION=15
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libICE-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=6f86dce12cf4bcaf5c37dddd8b1b64ed2ddf1ef7b218f22b9942595fb747c348
MCHS_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros, xtrans"

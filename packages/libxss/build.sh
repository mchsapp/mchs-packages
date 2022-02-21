# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 Screen Saver extension library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.3
MCHS_PKG_REVISION=13
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=f917075a1b7b5a38d67a8b0238eaab14acd2557679835b154cf2bca576e89bf8
MCHS_PKG_DEPENDS="libx11, libxau, libxcb, libxdmcp, libxext"
MCHS_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"

# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X11 miscellaneous 'fixes' extension library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.0.3
MCHS_PKG_REVISION=25
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXfixes-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=de1cd33aff226e08cefd0e6759341c2c8e8c9faf8ce9ac6ec38d43e287b22ad6
MCHS_PKG_DEPENDS="libx11"
MCHS_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"

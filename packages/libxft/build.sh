# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="FreeType-based font drawing library for X"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.3
MCHS_PKG_REVISION=13
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXft-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=225c68e616dd29dbb27809e45e9eadf18e4d74c50be43020ef20015274529216
MCHS_PKG_DEPENDS="fontconfig, freetype, libbz2, liblzma, libpng, libuuid, libx11, libxau, libxcb, libxdmcp, libxml2, libxrender"

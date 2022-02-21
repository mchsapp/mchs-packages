MCHS_PKG_HOMEPAGE=https://cairographics.org
MCHS_PKG_DESCRIPTION="Cairo 2D vector graphics library"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.16.0
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/cairo-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=5e7b29b3f113ef870d1e3ecf8adf21f923396401604bda16d44be45e66052331
MCHS_PKG_DEPENDS="fontconfig, freetype, glib, liblzo, libpixman, libpng, libx11, libxcb, libxext, libxrender, zlib"
MCHS_PKG_BREAKS="libcairo-dev, libcairo-gobject"
MCHS_PKG_REPLACES="libcairo-dev, libcairo-gobject"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gtk-doc-html
--disable-gl
--enable-gobject
--enable-pdf
--enable-svg
--enable-ps
"

MCHS_PKG_RM_AFTER_INSTALL="share/gtk-doc/html"

mchs_step_pre_configure() {
	autoreconf -fi
}

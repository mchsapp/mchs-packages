MCHS_PKG_HOMEPAGE=https://www.pango.org/
MCHS_PKG_DESCRIPTION="Library for laying out and rendering text"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.48.7
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/pango/${MCHS_PKG_VERSION:0:4}/pango-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=28a82f6a6cab60aa3b75a90f04197ead2d311fa8fe8b7bfdf8666e2781d506dc
MCHS_PKG_DEPENDS="fontconfig, fribidi, glib, harfbuzz, libcairo, libxft, zlib"
MCHS_PKG_BREAKS="pango-dev"
MCHS_PKG_REPLACES="pango-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Dintrospection=disabled"

mchs_step_post_make_install() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/pango-view.1 \
		$MCHS_PREFIX/share/man/man1/pango-view.1
}

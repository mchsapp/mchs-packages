MCHS_PKG_HOMEPAGE=https://wiki.gnome.org/action/show/Projects/LibRsvg
MCHS_PKG_DESCRIPTION="Library to render SVG files using cairo"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.52.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://ftp.gnome.org/pub/GNOME/sources/librsvg/${MCHS_PKG_VERSION:0:4}/librsvg-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=660ec8836a3a91587bc9384920132d4c38d1d1718c67fe160c5213fe4dec2928
MCHS_PKG_DEPENDS="gdk-pixbuf, libcairo, pango, zlib"
MCHS_PKG_BREAKS="librsvg-dev"
MCHS_PKG_REPLACES="librsvg-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_GDK_PIXBUF_QUERYLOADERS=$MCHS_PREFIX/bin/gdk-pixbuf-query-loaders
--disable-introspection
--disable-static
"

mchs_step_pre_configure() {
	mchs_setup_rust

	LDFLAGS+=" -fuse-ld=lld"

	# Work around https://gitlab.gnome.org/GNOME/librsvg/-/issues/820
	if [ "$MCHS_ARCH" = "arm" ]; then
		LDFLAGS+=" -Wl,-z,muldefs"
	fi

	# See https://github.com/GNOME/librsvg/blob/master/COMPILING.md
	export RUST_TARGET=$CARGO_TARGET_NAME
}

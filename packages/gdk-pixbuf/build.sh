MCHS_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GdkPixbuf
MCHS_PKG_DESCRIPTION="Library for image loading and manipulation"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.42.6
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/archive/${MCHS_PKG_VERSION}/gdk-pixbuf-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c4f3a84a04bc7c5f4fbd97dce7976ab648c60628f72ad4c7b79edce2bbdb494d
MCHS_PKG_DEPENDS="glib, libpng, libtiff, libjpeg-turbo, zstd"
MCHS_PKG_BREAKS="gdk-pixbuf-dev"
MCHS_PKG_REPLACES="gdk-pixbuf-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Dgio_sniffing=false"

mchs_step_create_debscripts() {
	for i in postinst postrm triggers; do
		sed \
			"s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" \
			"${MCHS_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}

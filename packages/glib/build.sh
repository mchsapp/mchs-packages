MCHS_PKG_HOMEPAGE=https://developer.gnome.org/glib/
MCHS_PKG_DESCRIPTION="Library providing core building blocks for libraries and applications written in C"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.70.2
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://ftp.gnome.org/pub/gnome/sources/glib/${MCHS_PKG_VERSION:0:4}/glib-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=0551459c85cd3da3d58ddc9016fd28be5af503f5e1615a71ba5b512ac945806f
MCHS_PKG_DEPENDS="libffi, libiconv, pcre, libandroid-support, zlib"
MCHS_PKG_BREAKS="glib-dev"
MCHS_PKG_REPLACES="glib-dev"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibmount=disabled
-Diconv=external
"

MCHS_PKG_RM_AFTER_INSTALL="
lib/locale
share/gdb/auto-load
share/glib-2.0/gdb
share/glib-2.0/gettext
share/gtk-doc
bin/gtester-report
bin/glib-gettextize
"

mchs_step_pre_configure() {
	# glib checks for __BIONIC__ instead of __ANDROID__:
	CFLAGS+=" -D__BIONIC__=1"
}

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

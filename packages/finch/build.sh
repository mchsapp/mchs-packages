MCHS_PKG_HOMEPAGE=https://pidgin.im/
MCHS_PKG_DESCRIPTION="Text-based multi-protocol instant messaging client"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.14.8
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/pidgin/Pidgin/${MCHS_PKG_VERSION}/pidgin-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=3f8085c0211c4ca1ba9f8a03889b3d60738432c1673b57b0086070ef6e094cca
MCHS_PKG_DEPENDS="libiconv, libgnt, libgnutls, libsasl, libxml2, ncurses-ui-libs, glib"
MCHS_PKG_BREAKS="finch-dev"
MCHS_PKG_REPLACES="finch-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-gtkui
--disable-gstreamer
--disable-vv
--disable-idn
--disable-meanwhile
--disable-avahi
--disable-dbus
--disable-perl
--disable-tcl
--without-zephyr
--with-ncurses-headers=$MCHS_PREFIX/include
--without-python3
"
MCHS_PKG_RM_AFTER_INSTALL="share/sounds/purple lib/purple-2/libmsn.so"

mchs_step_pre_configure() {
	# For arpa:
	CFLAGS+=" -isystem $MCHS_PKG_BUILDER_DIR"
}

mchs_step_post_configure() {
	# Hack to compile first version of libpurple-ciphers.la
	cp $MCHS_PREFIX/lib/libxml2.so $MCHS_PREFIX/lib/libpurple.so

	cd $MCHS_PKG_BUILDDIR/libpurple/ciphers
	make libpurple-ciphers.la
	cd ..
	make libpurple.la

	# Put a more proper version in lib:
	cp .libs/libpurple.so $MCHS_PREFIX/lib/

	make clean
}

mchs_step_post_make_install() {
	cd $MCHS_PREFIX/lib
	for lib in jabber oscar; do
		ln -f -s purple-2/lib${lib}.so .
	done
}

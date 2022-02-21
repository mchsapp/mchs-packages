MCHS_PKG_HOMEPAGE=https://github.com/sulkasormi/frogcomposband/
MCHS_PKG_DESCRIPTION="Open world Angband variant with many additions"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_SRCURL=https://github.com/sulkasormi/frogcomposband.git
MCHS_PKG_VERSION=7.1.salmiak
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-x11 --bindir=$MCHS_PREFIX/bin --sysconfdir=$MCHS_PREFIX/share/frogcomposband"
MCHS_PKG_RM_AFTER_INSTALL="share/angband/xtra share/angband/icons"

mchs_step_pre_configure () {
	./autogen.sh
	perl -p -i -e 's|ncursesw5-config|ncursesw6-config|g' configure
}

mchs_step_post_make_install () {
	rm -Rf $MCHS_PREFIX/share/frogcomposband/fonts
}

mchs_step_install_license() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/LICENSE \
		$MCHS_PREFIX/share/doc/frogcomposband/LICENSE
}

MCHS_PKG_HOMEPAGE=https://rephial.org/
MCHS_PKG_DESCRIPTION="Dungeon exploration adventure game"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.2.3
MCHS_PKG_REVISION=2
MCHS_PKG_SHA256=f001299283fb8a81865e07983d54cf04cd0f9addfeb7daeef75ed60f6ca417ff
MCHS_PKG_SRCURL=https://github.com/angband/angband/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-x11
--bindir=$MCHS_PREFIX/bin
--sysconfdir=$MCHS_PREFIX/share/angband
"
MCHS_PKG_RM_AFTER_INSTALL="
share/angband/fonts
share/angband/icons
share/angband/sounds
share/angband/xtra
"
MCHS_PKG_GROUPS="games"

mchs_step_pre_configure () {
	./autogen.sh
	perl -p -i -e 's|ncursesw5-config|ncursesw6-config|g' configure
}

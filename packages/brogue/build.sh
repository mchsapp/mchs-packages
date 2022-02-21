MCHS_PKG_HOMEPAGE=https://sites.google.com/site/broguegame/
MCHS_PKG_DESCRIPTION="Roguelike dungeon crawling game (community edition)"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10.1
MCHS_PKG_SRCURL=https://github.com/tmewett/BrogueCE/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3e0425b3f1b59afe98a92c0282aa4dd7e8964b53f7cab969fcf437701a04c5fa
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

mchs_step_pre_configure () {
        CFLAGS+=" -fcommon"
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS"
}

mchs_step_make_install () {
	install -m700 bin/brogue $MCHS_PREFIX/bin
}

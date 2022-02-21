MCHS_PKG_HOMEPAGE=https://github.com/seehuhn/moon-buggy
MCHS_PKG_DESCRIPTION="Simple game where you drive a car across the moon's surface"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_VERSION=1.0.51
MCHS_PKG_REVISION=5
# Main site down 2017-01-06.
# MCHS_PKG_SRCURL=http://m.seehuhn.de/programs/moon-buggy-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SRCURL=ftp://ftp.netbsd.org/pub/pkgsrc/distfiles/moon-buggy-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=352dc16ccae4c66f1e87ab071e6a4ebeb94ff4e4f744ce1b12a769d02fe5d23f
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--sharedstatedir=$MCHS_PREFIX/var"
MCHS_PKG_GROUPS="games"

mchs_step_make_install () {
	mkdir -p $MCHS_PREFIX/share/man/man6
	cp moon-buggy $MCHS_PREFIX/bin
	cp moon-buggy.6 $MCHS_PREFIX/share/man/man6
}

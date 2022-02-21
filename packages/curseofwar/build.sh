MCHS_PKG_HOMEPAGE=http://a-nikolaev.github.io/curseofwar/
MCHS_PKG_DESCRIPTION="Fast-paced action strategy game focusing on high-level strategic planning"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/a-nikolaev/curseofwar/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2a90204d95a9f29a0e5923f43e65188209dc8be9d9eb93576404e3f79b8a652b
MCHS_PKG_DEPENDS="libc++, ncurses"
MCHS_PKG_GROUPS="games"

mchs_step_make_install () {
	mkdir -p $MCHS_PREFIX/share/man/man6
	cp curseofwar $MCHS_PREFIX/bin
	cp $MCHS_PKG_SRCDIR/curseofwar.6 $MCHS_PREFIX/share/man/man6
}

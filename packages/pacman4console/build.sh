MCHS_PKG_HOMEPAGE=https://sites.google.com/site/doctormike/pacman.html
MCHS_PKG_DESCRIPTION="A 9 level ncurses pacman game with editor"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://ftp.debian.org/debian/pool/main/p/pacman4console/pacman4console_${MCHS_PKG_VERSION}.orig.tar.gz
MCHS_PKG_SHA256=9a5c4a96395ce4a3b26a9896343a2cdf488182da1b96374a13bf5d811679eb90
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

mchs_step_post_make_install() {
	mkdir -p "$MCHS_PREFIX"/share/man/man1 "$MCHS_PREFIX"/share/man/man6
	install -Dm600 $MCHS_PKG_BUILDER_DIR/pacmanedit.1 "$MCHS_PREFIX"/share/man/man1/
	install -Dm600 $MCHS_PKG_BUILDER_DIR/pacman.6 "$MCHS_PREFIX"/share/man/man6/
}

MCHS_PKG_HOMEPAGE=http://jubalh.github.io/nudoku/
MCHS_PKG_DESCRIPTION="ncurses based sudoku game"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.0
MCHS_PKG_SRCURL=https://github.com/jubalh/nudoku/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=eeff7f3adea5bfe7b88bf7683d68e9a597aabd1442d1621f21760c746400b924
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

mchs_step_pre_configure() {
	autoreconf -i
}

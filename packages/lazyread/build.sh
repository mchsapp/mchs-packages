MCHS_PKG_HOMEPAGE=http://lazyread.sourceforge.net/
MCHS_PKG_DESCRIPTION="An auto-scroller, pager, and e-book reader all in one"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0
MCHS_PKG_SRCURL=https://liquidtelecom.dl.sourceforge.net/project/lazyread/lazyread/lazyread%20${MCHS_PKG_VERSION}/lazyread-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=7e462c5c9fe104d69e410c537336af838a30a030699dd9320f75fe85a20746a1
MCHS_PKG_DEPENDS="coreutils, lesspipe, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	$CC $CPPFLAGS $CFLAGS lazyread.c -o lazyread $LDFLAGS -lncurses
}

mchs_step_make_install() {
	install -Dm700 lazyread $MCHS_PREFIX/bin/lazyread
}

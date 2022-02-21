MCHS_PKG_HOMEPAGE=https://github.com/chunga2020/pomodoro_curses
MCHS_PKG_DESCRIPTION="A simple pomodoro timer written with the Ncurses library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.5
MCHS_PKG_SRCURL=https://github.com/chunga2020/pomodoro_curses/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9a0de71d1b4ba2cb3ff404e52c4eedf63afde0cc11c378663c3edd9464cd1ff8
MCHS_PKG_DEPENDS="libinih, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin bin/pomodoro_curses
	install -Dm600 -t $MCHS_PREFIX/share/man/man1 doc/pomodoro_curses.1
	install -Dm600 -t $MCHS_PREFIX/share/pomodoro-curses config-sample.ini
}

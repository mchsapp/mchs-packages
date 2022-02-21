MCHS_PKG_HOMEPAGE=https://benkibbey.wordpress.com/cboard/
MCHS_PKG_DESCRIPTION="PGN browser, editor and chess engine frontend"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.5
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/c-board/${MCHS_PKG_VERSION}/cboard-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=dd748039f3531653e1573577cd814741524e1b16e16e3a841ef512e5150da6a0
MCHS_PKG_DEPENDS="libandroid-support,libandroid-glob,gnuchess, ncurses, ncurses-ui-libs"
MCHS_PKG_GROUPS="games"

mchs_step_pre_configure() {
	CFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX -fcommon"
	LDFLAGS+=" -landroid-glob"

	if $MCHS_DEBUG_BUILD; then
		# When doing debug build, -D_FORTIFY_SOURCE=2 gives this error:
		# /home/builder/.mchs-build/cboard/src/libchess/pgn.c:2235:33: error: 'umask' called with invalid mode
		# mode = umask(600);
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}

MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gnushogi/
MCHS_PKG_DESCRIPTION="Program that plays the game of Shogi, also known as Japanese Chess"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.2
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnushogi/gnushogi-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=1ecc48a866303c63652552b325d685e7ef5e9893244080291a61d96505d52b29
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_curses_clrtoeol=yes --with-curses"
MCHS_PKG_RM_AFTER_INSTALL="info/gnushogi.info"
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_GROUPS="games"

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -fcommon"
}

mchs_step_post_configure () {
	cp $MCHS_PKG_HOSTBUILD_DIR/gnushogi/pat2inc $MCHS_PKG_BUILDDIR/gnushogi/pat2inc
	# Update timestamps so that the binaries does not get rebuilt:
	touch -d "next hour" $MCHS_PKG_BUILDDIR/gnushogi/pat2inc
}

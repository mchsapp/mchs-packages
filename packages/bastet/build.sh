MCHS_PKG_HOMEPAGE=http://fph.altervista.org/prog/bastet.html
MCHS_PKG_DESCRIPTION="Tetris clone with 'bastard' block-choosing AI"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.43.2
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://github.com/fph/bastet/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f219510afc1d83e4651fbffd5921b1e0b926d5311da4f8fa7df103dc7f2c403f
MCHS_PKG_DEPENDS="libc++, ncurses"
MCHS_PKG_BUILD_DEPENDS="boost-static"
MCHS_PKG_EXTRA_MAKE_ARGS=" BOOST_PO=$MCHS_PREFIX/lib/libboost_program_options.a"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_GROUPS="games"

MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gnugo/
MCHS_PKG_DESCRIPTION="Program that plays the game of Go"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.8
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnugo/gnugo-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72
MCHS_PKG_DEPENDS="ncurses, readline"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-readline"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_GROUPS="games"

mchs_step_post_configure () {
	cp $MCHS_PKG_HOSTBUILD_DIR/patterns/mkeyes $MCHS_PKG_BUILDDIR/patterns/mkeyes
	cp $MCHS_PKG_HOSTBUILD_DIR/patterns/uncompress_fuseki $MCHS_PKG_BUILDDIR/patterns/uncompress_fuseki
	cp $MCHS_PKG_HOSTBUILD_DIR/patterns/joseki $MCHS_PKG_BUILDDIR/patterns/joseki
	cp $MCHS_PKG_HOSTBUILD_DIR/patterns/mkmcpat $MCHS_PKG_BUILDDIR/patterns/mkmcpat
	cp $MCHS_PKG_HOSTBUILD_DIR/patterns/mkpat $MCHS_PKG_BUILDDIR/patterns/mkpat
	touch -d "next hour" $MCHS_PKG_BUILDDIR/patterns/*
}

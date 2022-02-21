MCHS_PKG_HOMEPAGE=https://www.dechifro.org/dcraw/
MCHS_PKG_DESCRIPTION="Raw digital camera images decoding utility"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=9.28.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://mirrors.dotsrc.org/pub/mirrors/exherbo/dcraw-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2890c3da2642cd44c5f3bfed2c9b2c1db83da5cec09cc17e0fa72e17541fb4b9
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="littlecms, libjasper, libjpeg-turbo"

mchs_step_make_install() {
	# See the "install" script for flags:
	$CC $CFLAGS $CPPFLAGS $LDFLAGS dcraw.c $MCHS_PKG_BUILDER_DIR/swab.c -lm -ljasper -ljpeg -llcms2 -o $MCHS_PREFIX/bin/dcraw
	chmod +w dcraw.1 # Add missing write permission
	cp dcraw.1 $MCHS_PREFIX/share/man/man1/
}

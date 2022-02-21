MCHS_PKG_HOMEPAGE=https://github.com/andmarti1424/sc-im
MCHS_PKG_DESCRIPTION="An improved version of sc, a spreadsheet calculator"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.2
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/andmarti1424/sc-im/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=7f00c98601e7f7709431fb4cbb83707c87016a3b015d48e5a7c2f018eff4b7f7
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libandroid-support, libandroid-wordexp, liblua51, libxls, libxlsxwriter, libxml2, libzip, ncurses"
MCHS_PKG_SUGGESTS="gnuplot"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -I$MCHS_PREFIX/include/libandroid-support -DGNUPLOT"
	LDFLAGS+=" -landroid-wordexp"
	MCHS_PKG_BUILDDIR+="/src"
}

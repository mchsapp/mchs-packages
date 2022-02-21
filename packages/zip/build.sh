MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/infozip/
MCHS_PKG_DESCRIPTION="Tools for working with zip files"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.0
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/infozip/zip30.tar.gz
MCHS_PKG_SHA256=f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369
MCHS_PKG_DEPENDS="libandroid-support, libbz2"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	cp unix/Makefile Makefile
}

mchs_step_make() {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" make -j $MCHS_MAKE_PROCESSES generic
}

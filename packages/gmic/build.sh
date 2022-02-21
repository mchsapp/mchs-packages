MCHS_PKG_HOMEPAGE=https://gmic.eu
MCHS_PKG_DESCRIPTION="Full-featured framework for image processing"
MCHS_PKG_LICENSE="CeCILL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.9.9
MCHS_PKG_SRCURL=https://gmic.eu/files/source/gmic_$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=9f053338752ec96a6b619718037767682c5fd58e2471c08f3740fdb070605bc0
MCHS_PKG_DEPENDS="libc++, libcurl, fftw, libpng, libjpeg-turbo, libtiff, zlib"
MCHS_PKG_BUILD_DEPENDS="graphicsmagick"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	return 0;
}

mchs_step_make() {
	cd src/
	make USR="$MCHS_PREFIX" STRIP="$STRIP" \
	     CFLAGS="$CXXFLAGS" LIBS="$LDFLAGS" cli
}

mchs_step_make_install() {
	cp src/gmic $MCHS_PREFIX/bin/
	cp src/gmic-gm $MCHS_PREFIX/bin/
	cp man/gmic.1.gz $MCHS_PREFIX/share/man/man1/
	cp man/gmic.1.gz $MCHS_PREFIX/share/man/man1/gmic-gm.1.gz
}


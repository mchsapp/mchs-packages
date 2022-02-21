MCHS_PKG_HOMEPAGE=https://www.ghostscript.com/
MCHS_PKG_DESCRIPTION="Interpreter for the PostScript language and for PDF"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=9.55.0
MCHS_PKG_SRCURL=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${MCHS_PKG_VERSION//.}/ghostpdl-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b73cdfcb7b1c2a305748d23b00a765bcba48310564940b1eff1457f19f898172
MCHS_PKG_DEPENDS="libandroid-support, libiconv, libtiff, libjpeg-turbo, libpng, libexpat, freetype, libidn, littlecms, openjpeg, zstd"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_lcms2__cmsCreateMutex=yes
ac_cv_lib_pthread_pthread_create=yes
CCAUX=gcc
--build=$MCHS_BUILD_TUPLE
--with-arch_h=$MCHS_PKG_BUILDER_DIR/arch-${MCHS_ARCH}.h
--disable-cups
--disable-compile-inits
--without-pcl
--without-x
--with-system-libtiff
"

mchs_step_post_get_source() {
	rm -rdf $MCHS_PKG_SRCDIR/{jpeg,libpng,expat,jasper,freetype,lcms2,tiff,openjpeg}
}

mchs_step_pre_configure() {
	# Use `make -j1` otherwise build may fail with error
	# about missing 'arch.h'.
	MCHS_MAKE_PROCESSES=1
	CPPFLAGS+=" -I${MCHS_STANDALONE_TOOLCHAIN}/sysroot/usr/include/c++/v1"
}

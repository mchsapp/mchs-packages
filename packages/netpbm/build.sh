MCHS_PKG_HOMEPAGE=http://netpbm.sourceforge.net/
MCHS_PKG_DESCRIPTION="Toolkit for manipulation of graphic images of different formats"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:10.73.37
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/netpbm/super_stable/${MCHS_PKG_VERSION:2}/netpbm-${MCHS_PKG_VERSION:2}.tgz
MCHS_PKG_SHA256=e8826b5bc9a283220a60e8a24c6f5a854f5825c15e4f5171e77b6884f191fafd
MCHS_PKG_DEPENDS="libpng, libxml2, libjpeg-turbo, libtiff, zlib"
MCHS_PKG_BREAKS="netpbm-dev"
MCHS_PKG_REPLACES="netpbm-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	# Put the android libpng-config script in the path (before the host one):
	MCHS_PKG_LIBPNG_CONFIG_DIR=$MCHS_PKG_TMPDIR/libpng-config
	mkdir -p $MCHS_PKG_LIBPNG_CONFIG_DIR
	cp $MCHS_PREFIX/bin/libpng-config $MCHS_PKG_LIBPNG_CONFIG_DIR/
	export PATH=$MCHS_PKG_LIBPNG_CONFIG_DIR:$PATH

	# See $SRC/doc/INSTALL about netpbm build system. For automatic builds it recommends just copying config.mk.in
	cd $MCHS_PKG_SRCDIR
	cp config.mk.in config.mk
	echo "AR = $AR" >> config.mk
	echo "RANLIB = $RANLIB" >> config.mk
	echo "CC = $CC" >> config.mk
	echo "CFLAGS = $CFLAGS" >> config.mk
	echo "CFLAGS_SHLIB = -fPIC" >> config.mk
	echo "LDFLAGS = $LDFLAGS" >> config.mk
	echo "STATICLIB_TOO = n" >> config.mk
	echo "INTTYPES_H = <inttypes.h>" >> config.mk
	export STRIPPROG=$STRIP

	echo "CC_FOR_BUILD = cc" >> config.mk
	echo "LD_FOR_BUILD = cc" >> config.mk
	echo "CFLAGS_FOR_BUILD = " >> config.mk
	echo "LDFLAGS_FOR_BUILD = " >> config.mk
	echo "JPEGLIB = ${MCHS_PREFIX}/lib/libjpeg.so" >> config.mk
	echo "TIFFLIB = ${MCHS_PREFIX}/lib/libtiff.so" >> config.mk
	echo "TIFFLIB_NEEDS_Z = N" >> config.mk

	cp $MCHS_PKG_BUILDER_DIR/standardppmdfont.c lib/
}

mchs_step_make_install() {
	rm -Rf /tmp/netpbm
	make -j 1 package pkgdir=/tmp/netpbm
	./installnetpbm
}

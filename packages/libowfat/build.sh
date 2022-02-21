MCHS_PKG_HOMEPAGE=http://www.fefe.de/libowfat/
MCHS_PKG_DESCRIPTION="GPL reimplementation of libdjb"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.32
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=http://www.fefe.de/libowfat/libowfat-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=f4b9b3d9922dc25bc93adedf9e9ff8ddbebaf623f14c8e7a5f2301bfef7998c1
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_NO_STATICSPLIT=true

mchs_step_make() {
	make -j $MCHS_MAKE_PROCESSES CROSS="${CC/clang}"
}

mchs_step_make_install() {
	make install prefix=$MCHS_PREFIX LIBDIR=$MCHS_PREFIX/lib \
		MAN3DIR=$MCHS_PREFIX/share/man/man3
}

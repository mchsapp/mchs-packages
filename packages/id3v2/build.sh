MCHS_PKG_HOMEPAGE=http://id3v2.sourceforge.net/
MCHS_PKG_DESCRIPTION="A command line id3v2 tag editor"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.1.12
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/id3v2/id3v2-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8105fad3189dbb0e4cb381862b4fa18744233c3bbe6def6f81ff64f5101722bf
MCHS_PKG_DEPENDS="id3lib, libc++, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="PREFIX=$MCHS_PREFIX"

mchs_step_post_configure() {
	make clean
}

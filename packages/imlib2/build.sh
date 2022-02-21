MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/enlightenment/
MCHS_PKG_DESCRIPTION="Library that does image file loading and saving as well as rendering, manipulation, arbitrary polygon support"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/enlightenment/imlib2-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c15eb370225e3e3c64a6421c3f153a4117958e0a3b395e06926568b4090aa425
MCHS_PKG_DEPENDS="freetype, giflib, libandroid-shmem, libbz2, libid3tag, libjpeg-turbo, libpng, libtiff, libxext, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="LIBS=-landroid-shmem"

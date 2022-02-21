MCHS_PKG_HOMEPAGE=https://www.mars.org/home/rob/proj/hfs/
MCHS_PKG_DESCRIPTION="Tool for manipulating HFS images."
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.2.6
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=ftp://ftp.mars.org/pub/hfs/hfsutils-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bc9d22d6d252b920ec9cdf18e00b7655a6189b3f34f42e58d5bb152957289840
MCHS_PKG_DEPENDS="libandroid-support"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MCHS_PREFIX/share/man"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_configure() {
	mkdir -p ${MCHS_PREFIX}/share/man/man1
}


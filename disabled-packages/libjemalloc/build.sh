MCHS_PKG_HOMEPAGE=http://www.canonware.com/jemalloc/
MCHS_PKG_DESCRIPTION="General-purpose scalable concurrent malloc(3) implementation"
MCHS_PKG_VERSION=4.0.0
MCHS_PKG_SRCURL=https://github.com/jemalloc/jemalloc/releases/download/${MCHS_PKG_VERSION}/jemalloc-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_BUILD_IN_SRC=true

CPPFLAGS+=" -D__GCC_HAVE_SYNC_COMPARE_AND_SWAP_4=1"

MCHS_PKG_HOMEPAGE=https://github.com/librsync/librsync
MCHS_PKG_DESCRIPTION="Remote delta-compression library"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/librsync/librsync/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ef8ce23df38d5076d25510baa2cabedffbe0af460d887d86c2413a1c2b0c676f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libbz2"
MCHS_PKG_BUILD_DEPENDS="libpopt"
MCHS_PKG_BREAKS="librsync-dev"
MCHS_PKG_REPLACES="librsync-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DPERL_EXECUTABLE=$(command -v perl)"

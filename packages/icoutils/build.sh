MCHS_PKG_HOMEPAGE=https://www.nongnu.org/icoutils/
MCHS_PKG_DESCRIPTION="Extracts and converts images in MS Windows(R) icon and cursor files."
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.32.3
MCHS_PKG_SRCURL=https://savannah.nongnu.org/download/icoutils/icoutils-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=17abe02d043a253b68b47e3af69c9fc755b895db68fdc8811786125df564c6e0
MCHS_PKG_DEPENDS="libpng, perl"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$MCHS_PREFIX/share/man
"

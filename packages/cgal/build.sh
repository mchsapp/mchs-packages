MCHS_PKG_HOMEPAGE=https://www.cgal.org/
MCHS_PKG_DESCRIPTION="Computational Geometry Algorithms Library"
MCHS_PKG_LICENSE="GPL-2.0, LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.3.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/CGAL/cgal/releases/download/v${MCHS_PKG_VERSION}/CGAL-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=ab76633b023d72ea3ca9ad22e2fa39ed3b5c8fb4e2c091a78035fabb5eb3fccf
MCHS_PKG_DEPENDS="boost, libc++, libgmp, libmpfr, zlib"
MCHS_PKG_GROUPS="science"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_CGAL_Qt5=OFF
-DWITH_demos=OFF
-DWITH_examples=OFF
-DWITH_tests=OFF
"

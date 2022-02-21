MCHS_PKG_HOMEPAGE=https://github.com/kokkos
MCHS_PKG_DESCRIPTION="Implements a programming model in C++ for writing performance portable applications"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="Copyright.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.5.00
MCHS_PKG_SRCURL=https://github.com/kokkos/kokkos/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=748f06aed63b1e77e3653cd2f896ef0d2c64cb2e2d896d9e5a57fec3ff0244ff
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DKokkos_ENABLE_LIBDL=OFF
"
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

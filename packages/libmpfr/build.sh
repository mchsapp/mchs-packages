MCHS_PKG_HOMEPAGE=https://www.mpfr.org/
MCHS_PKG_DESCRIPTION="C library for multiple-precision floating-point computations with correct rounding"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.1.0
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/mpfr/mpfr-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f
MCHS_PKG_DEPENDS="libgmp"
MCHS_PKG_BREAKS="libmpfr-dev"
MCHS_PKG_REPLACES="libmpfr-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_header_locale_h=no"

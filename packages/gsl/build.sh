MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gsl/
MCHS_PKG_DESCRIPTION="GNU Scientific Library (GSL) providing a wide range of mathematical routines"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.7
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gsl/gsl-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=efbbf3785da0e53038be7907500628b466152dbc3c173a87de1b5eba2e23602b
MCHS_PKG_BREAKS="gsl-dev"
MCHS_PKG_REPLACES="gsl-dev"
# Do not remove `bin/gsl-config`
#MCHS_PKG_RM_AFTER_INSTALL="bin/ share/man/man1"

# Workaround for linker on Android 5 (fixed in Android 6) not supporting RTLD_GLOBAL.
# See https://github.com/mchs/mchs-packages/issues/507
export GSL_LDFLAGS="-Lcblas/.libs/ -lgslcblas"

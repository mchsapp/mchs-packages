MCHS_PKG_HOMEPAGE=https://gmplib.org/
MCHS_PKG_DESCRIPTION="Library for arbitrary precision arithmetic"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.2.1
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gmp/gmp-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=fd4829912cddd12f84181c3451cc752be224643e87fac497b69edddadc49b4f2
MCHS_PKG_BREAKS="libgmp-dev"
MCHS_PKG_REPLACES="libgmp-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-cxx"

mchs_step_pre_configure() {
# the cxx tests fail because it won't link properly without this
    CXXFLAGS+=" -L$MCHS_PREFIX/lib"
}

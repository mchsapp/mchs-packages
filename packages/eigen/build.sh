MCHS_PKG_HOMEPAGE=http://eigen.tuxfamily.org
MCHS_PKG_DESCRIPTION="Eigen is a C++ template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.4.0
MCHS_PKG_SHA256=8586084f71f9bde545ee7fa6d00288b264a2b7ac3607b974e54d13e7162c1c72
MCHS_PKG_SRCURL=https://gitlab.com/libeigen/eigen/-/archive/${MCHS_PKG_VERSION}/eigen-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_BREAKS="eigen-dev"
MCHS_PKG_REPLACES="eigen-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_BUILD_TYPE=Release"
MCHS_PKG_GROUPS="science"

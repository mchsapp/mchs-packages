MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/dict/
MCHS_PKG_DESCRIPTION="Provides many low-level data structures which are helpful for writing compilers"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/dict/libmaa/libmaa-${MCHS_PKG_VERSION}/libmaa-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=59a5a01e3a9036bd32160ec535d25b72e579824e391fea7079e9c40b0623b1c5

mchs_step_pre_configure() {
    autoreconf -ivf
}

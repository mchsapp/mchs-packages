MCHS_PKG_HOMEPAGE=https://github.com/eja/eja
MCHS_PKG_DESCRIPTION="eja micro web server"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=13.11.25
MCHS_PKG_SRCURL=https://github.com/eja/eja/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=eef4baa08e5fd71af871be3c00e70a1f12b95a22ea868cc219fd0eab71ff9e1b
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_EXTRA_MAKE_ARGS="DESTDIR=${MCHS_PREFIX} EJA_PATH=${MCHS_PREFIX} EJA_PATH_BIN=${MCHS_PREFIX}/bin EJA_PATH_LIB=${MCHS_PREFIX}/lib prefix=/"
MCHS_PKG_BUILD_IN_SRC=true

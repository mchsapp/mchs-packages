MCHS_PKG_HOMEPAGE=https://saitoha.github.io/libsixel/
MCHS_PKG_DESCRIPTION="Encoder/decoder implementation for DEC SIXEL graphics"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.8.6
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://github.com/saitoha/libsixel/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=37611d60c7dbcee701346967336dbf135fdd5041024d5f650d52fae14c731ab9
MCHS_PKG_DEPENDS="libcurl, libjpeg-turbo, libpng"
MCHS_PKG_BREAKS="libsixel-dev"
MCHS_PKG_REPLACES="libsixel-dev"

mchs_step_pre_configure() {
	export PYTHON_VERSION=$(. $MCHS_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)
	export PYTHON=python$PYTHON_VERSION
	MCHS_PKG_RM_AFTER_INSTALL="lib/${PYTHON}/site-packages/libsixel/__pycache__"
}

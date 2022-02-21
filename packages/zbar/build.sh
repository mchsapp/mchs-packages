MCHS_PKG_HOMEPAGE=https://github.com/mchehab/zbar
MCHS_PKG_DESCRIPTION="Software suite for reading bar codes from various sources"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.23.90
MCHS_PKG_SRCURL=https://github.com/mchehab/zbar/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=25fdd6726d5c4c6f95c95d37591bfbb2dde63d13d0b10cb1350923ea8b11963b
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libiconv, imagemagick, libjpeg-turbo, zlib"
MCHS_PKG_BREAKS="zbar-dev"
MCHS_PKG_REPLACES="zbar-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-pthread
--disable-video --without-xshm --without-xv
--without-x --without-gtk --without-qt
--without-python --mandir=$MCHS_PREFIX/share/man"

mchs_step_pre_configure() {
	autoreconf -vfi
}

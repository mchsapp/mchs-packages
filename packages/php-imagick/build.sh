MCHS_PKG_HOMEPAGE=https://github.com/Imagick/imagick
MCHS_PKG_DESCRIPTION="The Imagick PHP extension"
MCHS_PKG_LICENSE="PHP-3.01"
MCHS_PKG_LICENSE_FILE=LICENSE
MCHS_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
MCHS_PKG_VERSION=3.5.1
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/Imagick/imagick/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a70ccb298bb1f76d01e028d60cdfc787ffc14ab8355f61317e537f8c2a75c509
MCHS_PKG_DEPENDS="php, imagemagick"

mchs_step_pre_configure() {
	$MCHS_PREFIX/bin/phpize
}

MCHS_PKG_HOMEPAGE=https://github.com/jbboehr/php-psr
MCHS_PKG_DESCRIPTION="PHP extension providing the accepted PSR interfaces"
MCHS_PKG_LICENSE="BSD Simplified"
MCHS_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
MCHS_PKG_VERSION=1.1.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/jbboehr/php-psr/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ceeaceb6424885cefd85713779fb5242ccf2274fe002f110b088297b83783ab2
MCHS_PKG_DEPENDS=php

mchs_step_pre_configure() {
	$MCHS_PREFIX/bin/phpize
}

MCHS_PKG_HOMEPAGE=https://github.com/phpredis/phpredis
MCHS_PKG_DESCRIPTION="PHP extension for interfacing with Redis"
MCHS_PKG_LICENSE="PHP-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.3.4
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/phpredis/phpredis/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c0df53dc4e8cd2921503fefa224cfd51de7f74561324a6d3c66f30d4016178b3
MCHS_PKG_DEPENDS=php

mchs_step_pre_configure() {
	$MCHS_PREFIX/bin/phpize
}

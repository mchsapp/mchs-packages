MCHS_PKG_HOMEPAGE=https://getcomposer.org/
MCHS_PKG_DESCRIPTION="Dependency Manager for PHP"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@PuneetGopinath"
MCHS_PKG_VERSION=2.1.6
MCHS_PKG_REVISION=1
MCHS_PKG_GIT_BRANCH=$MCHS_PKG_VERSION
MCHS_PKG_SRCURL=https://github.com/composer/composer.git
MCHS_PKG_DEPENDS="php"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	composer install
	php -d phar.readonly=Off bin/compile
	install -Dm700 composer.phar $MCHS_PREFIX/bin/composer
}

MCHS_PKG_HOMEPAGE=https://github.com/phalcon/php-zephir-parser
MCHS_PKG_DESCRIPTION="The Zephir Parser delivered as a C extension for the PHP language."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="ian4hu <hu2008yinxiang@163.com>"
MCHS_PKG_VERSION=1.5.0
MCHS_PKG_SRCURL=https://github.com/zephir-lang/php-zephir-parser/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=faf44c19ed1adaae413b1ac734cd3f55689d7993d289af412fef9218bcc0c786
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS=php
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true

mchs_step_pre_configure() {
	# copy host build `lemon`
	cp "$MCHS_PKG_HOSTBUILD_DIR/lemon" $MCHS_PKG_SRCDIR/parser/
	$MCHS_PREFIX/bin/phpize
}

mchs_step_host_build() {
	# lemon excuted by build host, so we need build it by hostbuild, then it will be reused by later build
	gcc -o "$MCHS_PKG_HOSTBUILD_DIR/lemon" $MCHS_PKG_SRCDIR/parser/lemon.c

}

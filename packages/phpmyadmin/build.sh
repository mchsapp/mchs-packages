MCHS_PKG_HOMEPAGE=https://www.phpmyadmin.net
MCHS_PKG_DESCRIPTION="A PHP tool for administering MySQL databases"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.1.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://files.phpmyadmin.net/phpMyAdmin/$MCHS_PKG_VERSION/phpMyAdmin-$MCHS_PKG_VERSION-all-languages.tar.xz
MCHS_PKG_SHA256=1964d7190223c11e89fa1b7970c618e3a3bae2e859f5f60383f64c3848ef6921
MCHS_PKG_DEPENDS="apache2, php"
MCHS_PKG_CONFFILES="etc/phpmyadmin/config.inc.php"

mchs_step_make_install() {
	rm -rf $MCHS_PREFIX/share/phpmyadmin
	mkdir -p $MCHS_PREFIX/share/phpmyadmin
	cp -a $MCHS_PKG_SRCDIR/* $MCHS_PREFIX/share/phpmyadmin/
	mkdir -p $MCHS_PREFIX/etc/phpmyadmin
	cp $MCHS_PKG_SRCDIR/config.sample.inc.php $MCHS_PREFIX/etc/phpmyadmin/config.inc.php
	ln -s $MCHS_PREFIX/etc/phpmyadmin/config.inc.php $MCHS_PREFIX/share/phpmyadmin
	mkdir -p $MCHS_PREFIX/etc/apache2/conf.d
	sed -e "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" $MCHS_PKG_BUILDER_DIR/phpmyadmin.conf \
		> $MCHS_PREFIX/etc/apache2/conf.d/phpmyadmin.conf
}

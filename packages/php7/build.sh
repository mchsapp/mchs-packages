MCHS_PKG_HOMEPAGE=https://php.net
MCHS_PKG_DESCRIPTION="Server-side, HTML-embedded scripting language"
MCHS_PKG_LICENSE="PHP-3.0"
MCHS_PKG_VERSION=7.4.27
MCHS_PKG_MAINTAINER="@xtkoba"
MCHS_PKG_SRCURL=https://github.com/php/php-src/archive/php-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=198c0aae5a4aa56eca5d576e582be9547df3ac8c42e0aa829f3e299843f2bcc3
# Build native php for phar to build (see pear-Makefile.frag.patch):
MCHS_PKG_HOSTBUILD=true
# Build the native php without xml support as we only need phar:
MCHS_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS="--disable-libxml --disable-dom --disable-simplexml --disable-xml --disable-xmlreader --disable-xmlwriter --without-pear --disable-sqlite3 --without-libxml --without-sqlite3 --without-pdo-sqlite"
MCHS_PKG_DEPENDS="freetype, libandroid-glob, libandroid-support, libbz2, libcrypt, libcurl, libgd, libgmp, libiconv, liblzma, libsqlite, libxml2, libxslt, libzip, oniguruma, openssl, pcre2, readline, zlib, libicu, libffi, tidy"
MCHS_PKG_CONFLICTS="php, php-mysql, php-dev"
MCHS_PKG_RM_AFTER_INSTALL="php/php/fpm"
MCHS_PKG_SERVICE_SCRIPT=("php-fpm" 'mkdir -p ~/.php\nif [ -f "$HOME/.php/php-fpm.conf" ]; then CONFIG="$HOME/.php/php-fpm.conf"; else CONFIG="$PREFIX/etc/php-fpm.conf"; fi\nexec php-fpm -F -y $CONFIG -c ~/.php/php.ini 2>&1')

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_res_nsearch=no
--enable-bcmath
--enable-calendar
--enable-exif
--enable-mbstring
--enable-opcache
--enable-pcntl
--enable-sockets
--mandir=$MCHS_PREFIX/share/man
--with-bz2=$MCHS_PREFIX
--with-curl=$MCHS_PREFIX
--with-openssl=$MCHS_PREFIX
--with-readline=$MCHS_PREFIX
--with-iconv-dir=$MCHS_PREFIX
--with-zlib
--with-pgsql=shared,$MCHS_PREFIX
--with-pdo-pgsql=shared,$MCHS_PREFIX
--with-mysqli=mysqlnd
--with-pdo-mysql=mysqlnd
--with-mysql-sock=$MCHS_PREFIX/tmp/mysqld.sock
--with-apxs2=$MCHS_PKG_TMPDIR/apxs-wrapper.sh
--with-iconv=$MCHS_PREFIX
--enable-fpm
--enable-gd
--with-external-gd
--with-external-pcre
--with-zip
--with-xsl
--with-gmp
--with-ffi
--with-tidy=$MCHS_PREFIX
--enable-intl
--sbindir=$MCHS_PREFIX/bin
"

mchs_step_host_build() {
	(cd "$MCHS_PKG_SRCDIR" && ./buildconf --force)
	"$MCHS_PKG_SRCDIR/configure" ${MCHS_PKG_EXTRA_HOSTBUILD_CONFIGURE_ARGS}
	make -j "$MCHS_MAKE_PROCESSES"
}

mchs_step_pre_configure() {
	CPPFLAGS+=" -DGD_FLIP_VERTICAL=1"
	CPPFLAGS+=" -DGD_FLIP_HORINZONTAL=2"
	CPPFLAGS+=" -DGD_FLIP_BOTH=3"
	CPPFLAGS+=" -DU_DEFINE_FALSE_AND_TRUE=1"

	LDFLAGS+=" -landroid-glob -llog"

	export PATH=$PATH:$MCHS_PKG_HOSTBUILD_DIR/sapi/cli/
	export NATIVE_PHP_EXECUTABLE=$MCHS_PKG_HOSTBUILD_DIR/sapi/cli/php
	if [ "$MCHS_ARCH" = "aarch64" ]; then
		CFLAGS+=" -march=armv8-a+crc"
		CXXFLAGS+=" -march=armv8-a+crc"
	fi
	# Regenerate configure again since we have patched config.m4 files.
	./buildconf --force

	export EXTENSION_DIR=$MCHS_PREFIX/lib/php

	# Use a wrapper since bin/apxs has the McHs shebang:
	echo "perl $MCHS_PREFIX/bin/apxs \$@" > $MCHS_PKG_TMPDIR/apxs-wrapper.sh
	chmod +x $MCHS_PKG_TMPDIR/apxs-wrapper.sh
	cat $MCHS_PKG_TMPDIR/apxs-wrapper.sh
}

mchs_step_post_configure() {
	# Avoid src/ext/gd/gd.c trying to include <X11/xpm.h>:
	sed -i 's/#define HAVE_GD_XPM 1//' $MCHS_PKG_BUILDDIR/main/php_config.h
	# Avoid src/ext/standard/dns.c trying to use struct __res_state:
	sed -i 's/#define HAVE_RES_NSEARCH 1//' $MCHS_PKG_BUILDDIR/main/php_config.h
}

mchs_step_post_make_install() {
	mkdir -p $MCHS_PREFIX/etc/php-fpm.d
	cp sapi/fpm/php-fpm.conf $MCHS_PREFIX/etc/
	cp sapi/fpm/www.conf $MCHS_PREFIX/etc/php-fpm.d/

	sed -i 's/SED=.*/SED=sed/' $MCHS_PREFIX/bin/phpize
}

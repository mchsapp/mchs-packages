MCHS_PKG_HOMEPAGE=https://www.lighttpd.net
MCHS_PKG_DESCRIPTION="Fast webserver with minimal memory footprint"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.64
MCHS_PKG_SRCURL=https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=e1489d9fa7496fbf2e071c338b593b2300d38c23f1e5967e52c9ef482e1b0e26
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-bzip2 --with-openssl --with-pcre --with-zlib"
MCHS_PKG_DEPENDS="libbz2, openssl, pcre, libcrypt, libandroid-glob, zlib"
MCHS_PKG_RM_AFTER_INSTALL="bin/lighttpd-angel"
MCHS_PKG_SERVICE_SCRIPT=("lighttpd" "if [ -f \"$MCHS_ANDROID_HOME/.lighttpd/lighttpd.conf\" ]; then CONFIG=\"$MCHS_ANDROID_HOME/.lighttpd/lighttpd.conf\"; else CONFIG=\"$MCHS_PREFIX/etc/lighttpd/lighttpd.conf\"; fi\nexec lighttpd -D -f \$CONFIG 2>&1")

mchs_step_pre_configure() {
	LDFLAGS="$LDFLAGS -landroid-glob"
}

mchs_step_post_make_install() {
	# Install example config file
	mkdir -p $MCHS_PREFIX/etc/lighttpd
	install -Dm600 $MCHS_PKG_SRCDIR/doc/config/lighttpd.conf $MCHS_PREFIX/etc/lighttpd/
}

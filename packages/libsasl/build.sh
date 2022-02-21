MCHS_PKG_HOMEPAGE=https://www.cyrusimap.org/sasl/
MCHS_PKG_DESCRIPTION="Cyrus SASL - authentication abstraction library"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.27
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/cyrus-sasl-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=6eaf75ce1e73be63894fb04d1fd0bfa9f54f33e88269743dd8f2ff54e27ea043
MCHS_PKG_BREAKS="libsasl-dev"
MCHS_PKG_REPLACES="libsasl-dev"
# Seems to be race issues in build (symlink creation)::
MCHS_MAKE_PROCESSES=1
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
lt_cv_deplibs_check_method=pass_all
ac_cv_func_syslog=no
ac_cv_header_syslog_h=no
--disable-gssapi
--disable-otp
--sysconfdir=$MCHS_PREFIX/etc
--with-dblib=none
--with-dbpath=$MCHS_PREFIX/var/lib/sasldb
--without-des
--without-saslauthd
--with-plugindir=$MCHS_PREFIX/lib/sasl2
--enable-login
"
MCHS_PKG_RM_AFTER_INSTALL="bin/pluginviewer"

mchs_step_post_configure() {
	# Build wants to run makemd5 at build time:
	gcc $MCHS_PKG_SRCDIR/include/makemd5.c -o $MCHS_PKG_BUILDDIR/include/makemd5
	touch -d "next hour" $MCHS_PKG_BUILDDIR/include/makemd5
}

mchs_step_post_massage() {
	for sub in anonymous crammd5 digestmd5 plain login; do
		local base=lib/sasl2/lib${sub}
		if [ ! -f ${base}.so ]; then
			mchs_error_exit "libsasl not packaged with $base"
		fi
	done
}

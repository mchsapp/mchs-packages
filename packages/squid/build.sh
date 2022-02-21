MCHS_PKG_HOMEPAGE=http://www.squid-cache.org
MCHS_PKG_DESCRIPTION="Full-featured Web proxy cache server"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.16
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://squid.mirror.globo.tech/archive/4/squid-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=7e00e891757c1c02dae546c9898f440c6031b684d8c243d6edab529076e3ba63
MCHS_PKG_DEPENDS="libc++, libcrypt, libxml2, libltdl, libgnutls, resolv-conf"

#disk-io uses XSI message queue which are not available on Android.
# Option 'cache_dir' will be unusable.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_memrchr=yes
ac_cv_func_strtoll=yes
ac_cv_search_shm_open=
ac_cv_lib_sasl2_sasl_errstring=no
ac_cv_dbopen_libdb=no
squid_cv_gnu_atomics=yes
--datarootdir=$MCHS_PREFIX/share/squid
--libexecdir=$MCHS_PREFIX/libexec/squid
--mandir=$MCHS_PREFIX/share/man
--sysconfdir=$MCHS_PREFIX/etc/squid
--with-logdir=$MCHS_PREFIX/var/log/squid
--with-pidfile=$MCHS_PREFIX/var/run/squid.pid
--disable-external-acl-helpers
--disable-strict-error-checking
--enable-auth
--enable-auth-basic
--enable-auth-digest
--enable-auth-negotiate
--enable-auth-ntlm
--enable-delay-pools
--enable-linux-netfilter
--enable-removal-policies="lru,heap"
--enable-snmp
--disable-disk-io
--disable-storeio
--enable-translation
--with-dl
--without-openssl
--disable-ssl-crtd
--with-size-optimizations
--with-gnutls
--with-libnettle
--without-mit-krb5
--with-maxfd=256
"

mchs_step_pre_configure() {
	# needed for building cf_gen
	export BUILDCXX=g++
	# else it picks up our cross CXXFLAGS
	export BUILDCXXFLAGS=' '
}

mchs_step_post_make_install() {
	local _SQUID_LOGDIR=$MCHS_PREFIX/var/logs
	mkdir -p $_SQUID_LOGDIR
	echo "Squid logs here by default" > $_SQUID_LOGDIR/README.squid
}

mchs_step_post_massage() {
	# Ensure that necessary directories exist, otherwise squid fill fail.
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/cache/squid"
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/log/squid"
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/run"
}

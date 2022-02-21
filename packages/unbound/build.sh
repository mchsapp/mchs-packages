MCHS_PKG_HOMEPAGE=https://unbound.net/
MCHS_PKG_DESCRIPTION="A validating, recursive, caching DNS resolver"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.13.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://nlnetlabs.nl/downloads/unbound/unbound-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0a13b547f3b92a026b5ebd0423f54c991e5718037fd9f72445817f6a040e1a83
MCHS_PKG_DEPENDS="libevent, libexpat, libnghttp2, openssl"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_chown=no
ac_cv_func_chroot=no
ac_cv_func_getpwnam=no
--enable-event-api
--enable-ipsecmod
--enable-linux-ip-local-port-range
--enable-tfo-server
--with-libevent=$MCHS_PREFIX
--with-libexpat=$MCHS_PREFIX
--without-libhiredis
--without-libmnl
--with-libnghttp2=$MCHS_PREFIX
--with-ssl=$MCHS_PREFIX
--with-pidfile=$MCHS_PREFIX/var/run/unbound.pid
--with-username=
"

mchs_step_post_massage() {
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/var/run"
}

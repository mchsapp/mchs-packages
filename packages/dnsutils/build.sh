MCHS_PKG_HOMEPAGE=https://www.isc.org/downloads/bind/
MCHS_PKG_DESCRIPTION="Clients provided with BIND"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=9.16.11
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL="ftp://ftp.isc.org/isc/bind9/${MCHS_PKG_VERSION}/bind-${MCHS_PKG_VERSION}.tar.xz"
MCHS_PKG_SHA256=0111f64dd7d8f515cfa129e181cce96ff82070d1b27f11a21f6856110d0699c1
MCHS_PKG_DEPENDS="openssl, readline, resolv-conf, zlib, libuv"
MCHS_PKG_BREAKS="dnsutils-dev"
MCHS_PKG_REPLACES="dnsutils-dev"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-linux-caps
--without-python
--with-ecdsa=no
--with-gost=no
--with-gssapi=no
--with-libjson=no
--with-libtool
--with-libxml2=no
--with-openssl=$MCHS_PREFIX
--with-randomdev=/dev/random
--with-readline=-lreadline
--with-eddsa=no
"

mchs_step_pre_configure() {
	export BUILD_AR=ar
	export BUILD_CC=gcc
	export BUILD_CFLAGS=
	export BUILD_CPPFLAGS=
	export BUILD_LDFLAGS=
	export BUILD_RANLIB=

	_RESOLV_CONF=$MCHS_PREFIX/etc/resolv.conf
	CFLAGS+=" $CPPFLAGS -DRESOLV_CONF=\\\"$_RESOLV_CONF\\\""
}

mchs_step_make() {
	make -C lib/isc
	make -C lib/dns
	make -C lib/ns
	make -C lib/isccc
	make -C lib/isccfg
	make -C lib/bind9
	make -C lib/irs
	make -C bin/dig
	make -C bin/delv
	make -C bin/nsupdate
}

mchs_step_make_install() {
	make -C lib/isc install
	make -C lib/dns install
	make -C lib/ns install
	make -C lib/isccc install
	make -C lib/isccfg install
	make -C lib/bind9 install
	make -C lib/irs install
	make -C bin/dig install
	make -C bin/delv install
	make -C bin/nsupdate install
}

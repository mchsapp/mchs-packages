MCHS_PKG_HOMEPAGE=https://memcached.org/
MCHS_PKG_DESCRIPTION="Free & open source, high-performance, distributed memory object caching system"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.12
MCHS_PKG_SRCURL=https://www.memcached.org/files/memcached-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f291a35f82ef9756ed1d952879ef5f4be870f932bdfcb2ab61356609abf82346
MCHS_PKG_DEPENDS="libevent, libsasl"
MCHS_PKG_BREAKS="memcached-dev"
MCHS_PKG_REPLACES="memcached-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-static --enable-sasl --disable-coverage"

mchs_step_pre_configure() {
	CPPFLAGS+=" -D__USE_GNU"

	export ac_cv_c_endian=little

	# Fix SASL configuration path
	perl -p -i -e "s#/etc/sasl#$MCHS_PREFIX/etc/sasl#" $MCHS_PKG_BUILDDIR/sasl_defs.c

	# getsubopt() taken from https://github.com/lxc/lxc/blob/master/src/include/getsubopt.c
	cp $MCHS_PKG_BUILDER_DIR/getsubopt.c $MCHS_PKG_SRCDIR
	cp $MCHS_PKG_BUILDER_DIR/getsubopt.h $MCHS_PKG_SRCDIR

	autoreconf -vfi
}

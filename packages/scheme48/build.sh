MCHS_PKG_HOMEPAGE=https://www.s48.org/
MCHS_PKG_DESCRIPTION="An implementation of the Scheme programming language"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.9.2
MCHS_PKG_SRCURL=https://www.s48.org/${MCHS_PKG_VERSION}/scheme48-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=9c4921a90e95daee067cd2e9cc0ffe09e118f4da01c0c0198e577c4f47759df4
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_bits_per_byte=8
ac_cv_header_pthread_h=no
"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	$MCHS_PKG_SRCDIR/configure \
		CFLAGS=-m${MCHS_ARCH_BITS} LDFLAGS=-m${MCHS_ARCH_BITS}
	make -j $MCHS_MAKE_PROCESSES scheme48vm
}

mchs_step_pre_configure() {
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_sizeof_void_p=$(( $MCHS_ARCH_BITS / 8 ))"
}

mchs_step_post_configure() {
	export PATH=$MCHS_PKG_HOSTBUILD_DIR:$PATH
}

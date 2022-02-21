MCHS_PKG_HOMEPAGE=https://common-lisp.net/project/ecl/
MCHS_PKG_DESCRIPTION="ECL (Embeddable Common Lisp) is an interpreter of the Common Lisp language."
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION="21.2.1"
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://common-lisp.net/project/ecl/static/files/release/ecl-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=b15a75dcf84b8f62e68720ccab1393f9611c078fcd3afdd639a1086cad010900
MCHS_PKG_DEPENDS="libandroid-support, libgmp, libgc, libffi"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_NO_STATICSPLIT=true
MCHS_PKG_BLACKLISTED_ARCHES="i686, x86_64"
MCHS_PKG_HAS_DEBUG=false

# See https://gitlab.com/embeddable-common-lisp/ecl/-/blob/develop/INSTALL
# for upstream cross build guide.

# ECL needs itself during build, so we need to build it for the host first.
mchs_step_host_build() {
	srcdir=$MCHS_PKG_SRCDIR/src
	hostprefix=$MCHS_PKG_HOSTBUILD_DIR/prefix
	mkdir $hostprefix
	autoreconf -fi $srcdir/gmp
	$srcdir/configure ABI=${MCHS_ARCH_BITS} \
		CFLAGS=-m${MCHS_ARCH_BITS} LDFLAGS=-m${MCHS_ARCH_BITS} \
		--prefix=$hostprefix --srcdir=$srcdir --disable-c99complex
	make
	make install
}

mchs_step_pre_configure() {
	srcdir=$MCHS_PKG_SRCDIR/src
	autoreconf -fi $srcdir
}

mchs_step_configure() {
	# Copy cross_config for target architecture.
	case $MCHS_ARCH in
		aarch64) crossconfig=android-arm64 ;;
		arm)     crossconfig=android-arm ;;
		*)       mchs_error_exit "Unsupported arch: $MCHS_ARCH" ;;
	esac
	crossconfig="$MCHS_PKG_SRCDIR/src/util/$crossconfig.cross_config"
	export ECL_TO_RUN=$MCHS_PKG_HOSTBUILD_DIR/prefix/bin/ecl

	srcdir=$MCHS_PKG_SRCDIR/src
	$srcdir/configure \
		--srcdir=$srcdir \
		--prefix=$MCHS_PREFIX \
		--host=$MCHS_HOST_PLATFORM \
		--build=$MCHS_BUILD_TUPLE \
		--with-cross-config=$crossconfig \
		--disable-c99complex \
		--enable-gmp=system \
		--enable-boehm=system
}

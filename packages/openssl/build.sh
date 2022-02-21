MCHS_PKG_HOMEPAGE=https://www.openssl.org/
MCHS_PKG_DESCRIPTION="Library implementing the SSL and TLS protocols as well as general purpose cryptography functions"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.1m
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://www.openssl.org/source/openssl-${MCHS_PKG_VERSION/\~/-}.tar.gz
MCHS_PKG_SHA256=f89199be8b23ca45fc7cb9f1d8d3ee67312318286ad030f5316aca6462db6c96
MCHS_PKG_DEPENDS="ca-certificates, zlib"
MCHS_PKG_CONFFILES="etc/tls/openssl.cnf"
MCHS_PKG_RM_AFTER_INSTALL="bin/c_rehash etc/ssl/misc"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_CONFLICTS="libcurl (<< 7.61.0-1)"
MCHS_PKG_BREAKS="openssl-tool (<< 1.1.1b-1), openssl-dev"
MCHS_PKG_REPLACES="openssl-tool (<< 1.1.1b-1), openssl-dev"

mchs_step_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	CFLAGS+=" -DNO_SYSLOG"
	if [ $MCHS_ARCH = arm ]; then
		CFLAGS+=" -fno-integrated-as"
	fi

	perl -p -i -e "s@MCHS_CFLAGS@$CFLAGS@g" Configure
	rm -Rf $MCHS_PREFIX/lib/libcrypto.* $MCHS_PREFIX/lib/libssl.*
	test $MCHS_ARCH = "arm" && MCHS_OPENSSL_PLATFORM="android-arm"
	test $MCHS_ARCH = "aarch64" && MCHS_OPENSSL_PLATFORM="android-arm64"
	test $MCHS_ARCH = "i686" && MCHS_OPENSSL_PLATFORM="android-x86"
	test $MCHS_ARCH = "x86_64" && MCHS_OPENSSL_PLATFORM="android-x86_64"
	./Configure $MCHS_OPENSSL_PLATFORM \
		--prefix=$MCHS_PREFIX \
		--openssldir=$MCHS_PREFIX/etc/tls \
		shared \
		zlib-dynamic \
		no-ssl \
		no-hw \
		no-srp \
		no-tests
}

mchs_step_make() {
	make depend
	make -j $MCHS_MAKE_PROCESSES all
}

mchs_step_make_install() {
	# "install_sw" instead of "install" to not install man pages:
	make -j 1 install_sw MANDIR=$MCHS_PREFIX/share/man MANSUFFIX=.ssl

	mkdir -p $MCHS_PREFIX/etc/tls/

	cp apps/openssl.cnf $MCHS_PREFIX/etc/tls/openssl.cnf

	sed "s|@MCHS_PREFIX@|$MCHS_PREFIX|g" \
		$MCHS_PKG_BUILDER_DIR/add-trusted-certificate \
		> $MCHS_PREFIX/bin/add-trusted-certificate
	chmod 700 $MCHS_PREFIX/bin/add-trusted-certificate
}

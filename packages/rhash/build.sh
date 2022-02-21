MCHS_PKG_HOMEPAGE=https://github.com/rhash/RHash
MCHS_PKG_DESCRIPTION="Console utility for calculation and verification of magnet links and a wide range of hash sums"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.2
MCHS_PKG_SRCURL=https://github.com/rhash/RHash/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=600d00f5f91ef04194d50903d3c79412099328c42f28ff43a0bdb777b00bec62
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_CONFLICTS="librhash, rhash-dev"
MCHS_PKG_REPLACES="librhash, rhash-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	./configure \
		--prefix=$MCHS_PREFIX \
		--disable-static \
		--enable-lib-static \
		--enable-lib-shared \
		--cc=$CC
}

mchs_step_make() {
	CFLAGS="-DOPENSSL_RUNTIME $CPPFLAGS $CFLAGS"
	make -j $MCHS_MAKE_PROCESSES \
		ADDCFLAGS="$CFLAGS" \
		ADDLDFLAGS="$LDFLAGS"
}

mchs_step_make_install() {
	make install install-pkg-config
	make -C librhash install-lib-headers

	ln -sf $MCHS_PREFIX/lib/librhash.so.0 $MCHS_PREFIX/lib/librhash.so
}

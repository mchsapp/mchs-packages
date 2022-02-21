MCHS_PKG_HOMEPAGE=https://core.telegram.org/tdlib/
MCHS_PKG_DESCRIPTION="Library for building Telegram clients"
MCHS_PKG_LICENSE="BSL-1.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.7.0
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/tdlib/td/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3daaf419f1738b7e0ac0e8a08f07e01a1faaf51175a59c0b113c15e30c69e173
MCHS_PKG_DEPENDS="readline, openssl (>= 1.1.1), zlib"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
        mchs_setup_cmake
        cmake "-DCMAKE_BUILD_TYPE=Release" "$MCHS_PKG_SRCDIR"
        cmake --build . --target prepare_cross_compiling
}

mchs_step_post_make_install() {
	# Fix rebuilds without ./clean.sh.
	rm -rf $MCHS_PKG_HOSTBUILD_DIR
}

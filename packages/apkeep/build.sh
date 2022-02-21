MCHS_PKG_HOMEPAGE=https://github.com/EFForg/apkeep
MCHS_PKG_DESCRIPTION="A command-line tool for downloading APK files from various sources"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.8.0
MCHS_PKG_SRCURL=https://github.com/EFForg/apkeep/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2b3ca13fc23f5e08ef52de76d02b3f6e0a9d39a02496b5a895c618c99264ddbe
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export OPENSSL_INCLUDE_DIR=$MCHS_PREFIX/include/openssl
	export OPENSSL_LIB_DIR=$MCHS_PREFIX/lib
}

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/apkeep
}

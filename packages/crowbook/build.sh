MCHS_PKG_HOMEPAGE=https://github.com/lise-henry
MCHS_PKG_DESCRIPTION="Allows you to write a book in Markdown without worrying about formatting or typography"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15.2e
MCHS_PKG_SRCURL=https://github.com/lise-henry/crowbook/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ac950c051faece985821c28c17206188a6211247a040a8e7afaa34a5f45cf81f
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
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/crowbook
}

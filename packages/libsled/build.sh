MCHS_PKG_HOMEPAGE=https://github.com/spacejam/sled
MCHS_PKG_DESCRIPTION="A lightweight pure-rust high-performance transactional embedded database"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.34.7
MCHS_PKG_SRCURL=https://github.com/spacejam/sled/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=dd1c757464b970a4eb73c954b345be63655c84bb1de249af3c3a609c57763046

mchs_step_post_get_source() {
	sed -e "s%\@MCHS_PKG_VERSION\@%${MCHS_PKG_VERSION}%g" \
		$MCHS_PKG_BUILDER_DIR/bindings-sled-native-Cargo.toml.diff | \
		patch --silent -p1
}

mchs_step_pre_configure() {
	MCHS_PKG_BUILDDIR="$MCHS_PKG_SRCDIR/bindings/sled-native"
}

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm600 -t $MCHS_PREFIX/lib target/${CARGO_TARGET_NAME}/release/libsled.so
}

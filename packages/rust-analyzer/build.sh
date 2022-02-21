MCHS_PKG_HOMEPAGE=https://github.com/rust-analyzer/rust-analyzer
MCHS_PKG_DESCRIPTION="A Rust compiler front-end for IDEs"
MCHS_PKG_LICENSE="MIT, Apache-2.0"
MCHS_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20220124
MCHS_PKG_SRCURL=https://github.com/rust-analyzer/rust-analyzer/archive/refs/tags/${MCHS_PKG_VERSION:0:4}-${MCHS_PKG_VERSION:4:2}-${MCHS_PKG_VERSION:6:2}.tar.gz
MCHS_PKG_SHA256=634dc4fda60674b10d1f945dfb9f64a6a8c0e41c6fbb42bffbeeb3bae16fb1db
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rust-analyzer
}

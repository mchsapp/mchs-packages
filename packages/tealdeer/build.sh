MCHS_PKG_HOMEPAGE=https://dbrgn.github.io/tealdeer/
MCHS_PKG_DESCRIPTION="A very fast implementation of tldr in Rust"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/dbrgn/tealdeer.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/tldr
}

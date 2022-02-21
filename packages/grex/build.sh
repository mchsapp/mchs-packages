MCHS_PKG_HOMEPAGE=https://github.com/pemistahl/grex
MCHS_PKG_DESCRIPTION="Simplifies the task of creating regular expressions"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.0
MCHS_PKG_SRCURL=https://github.com/pemistahl/grex.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/grex
}

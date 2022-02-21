MCHS_PKG_HOMEPAGE=https://github.com/chmln/sd
MCHS_PKG_DESCRIPTION="An intuitive find & replace CLI"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.6
MCHS_PKG_SRCURL=https://github.com/chmln/sd.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/sd
}

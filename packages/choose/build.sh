MCHS_PKG_HOMEPAGE=https://github.com/theryangeary/choose
MCHS_PKG_DESCRIPTION="A human-friendly and fast alternative to cut and (sometimes) awk"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.3
MCHS_PKG_SRCURL=https://github.com/theryangeary/choose.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/choose
}

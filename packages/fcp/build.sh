MCHS_PKG_HOMEPAGE=https://github.com/Svetlitski/fcp
MCHS_PKG_DESCRIPTION="A significantly faster alternative to the classic Unix cp(1) command"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2.1
MCHS_PKG_SRCURL=https://github.com/Svetlitski/fcp.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/fcp
}

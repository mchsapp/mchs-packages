MCHS_PKG_HOMEPAGE=https://github.com/dalance/procs
MCHS_PKG_DESCRIPTION="A modern replacement for ps"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.12.0
MCHS_PKG_SRCURL=https://github.com/dalance/procs/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=04dbb3ddc734a9d1305b26b546a913e3e04d556b5863212a2675d29268aebed3
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/procs
}

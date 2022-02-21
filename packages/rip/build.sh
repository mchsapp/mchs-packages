MCHS_PKG_HOMEPAGE=https://github.com/nivekuil/rip
MCHS_PKG_DESCRIPTION="A command-line deletion tool focused on safety, ergonomics, and performance"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.13.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/nivekuil/rip.git
MCHS_PKG_GIT_BRANCH="${MCHS_PKG_VERSION}"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/rip
}

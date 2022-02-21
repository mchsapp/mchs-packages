MCHS_PKG_HOMEPAGE=https://github.com/ducaale/xh
MCHS_PKG_DESCRIPTION="A friendly and fast tool for sending HTTP requests"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/ducaale/xh.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/xh
	ln -sf $MCHS_PREFIX/bin/xh{,s}
}

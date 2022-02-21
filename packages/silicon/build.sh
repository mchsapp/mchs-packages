MCHS_PKG_HOMEPAGE=https://github.com/Aloxaf/silicon
MCHS_PKG_DESCRIPTION="Silicon is an alternative to Carbon implemented in Rust"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Yaksh Bariya <yakshbari4@gmail.com>"
MCHS_PKG_VERSION=0.4.3
MCHS_PKG_SRCURL=https://github.com/Aloxaf/silicon/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=68d64ade34ac571cf2d092f9a6f124e2c7d0441a91e3ba00ca1c8edcdd008630
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BLACKLISTED_ARCHES="arm"

mchs_step_pre_configure() {
	mchs_setup_rust
	mchs_setup_cmake
}

mchs_step_make() {
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/silicon
}

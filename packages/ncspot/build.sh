MCHS_PKG_HOMEPAGE=https://github.com/hrkfdn/ncspot
MCHS_PKG_DESCRIPTION="An ncurses Spotify client written in Rust"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.3
MCHS_PKG_SRCURL=https://github.com/hrkfdn/ncspot/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ed873d007ce356e8c6eed56226533b686682a98d2a37487668416539d4e10e78
MCHS_PKG_DEPENDS="dbus, pulseaudio"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/ncspot
}

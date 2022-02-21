MCHS_PKG_HOMEPAGE=https://github.com/JohnnyMorganz/StyLua
MCHS_PKG_DESCRIPTION="An opinionated Lua code formatter"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@shadmansaleh"
MCHS_PKG_VERSION=0.12.3
MCHS_PKG_SRCURL=https://github.com/JohnnyMorganz/StyLua/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c7c960d501535329e007ff9757067d40b0cf395c2fceac09e169f4c9ea8e67ca
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/stylua
}

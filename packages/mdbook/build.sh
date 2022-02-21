MCHS_PKG_HOMEPAGE=https://rust-lang.github.io/mdBook/
MCHS_PKG_DESCRIPTION="Creates book from markdown files"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.15
MCHS_PKG_SRCURL=https://github.com/rust-lang/mdBook/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=fa7f217fb6be229c25be21ccb712af8d0012241b529d1bbacb8f5cac65fe0013
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_rust
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/mdbook
}

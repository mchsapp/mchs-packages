MCHS_PKG_HOMEPAGE=https://github.com/extrawurst/gitui
MCHS_PKG_DESCRIPTION="Blazing fast terminal-ui for git written in rust"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="LICENSE.md"
MCHS_PKG_MAINTAINER="@PeroSar"
MCHS_PKG_VERSION=0.20.1
MCHS_PKG_SRCURL=https://github.com/extrawurst/gitui/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=eccec120dfd4c5c33a74d331a53f3d0c6cb7200e26b0c4c7873278eb951bc379
MCHS_PKG_DEPENDS="git, zlib, openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export OPENSSL_NO_VENDOR=1
}

mchs_step_make() {
	mchs_setup_rust

	cargo build --release \
		--jobs "$MCHS_MAKE_PROCESSES" \
		--target "$CARGO_TARGET_NAME" \
		--locked
}

mchs_step_make_install() {
	install -Dm700 target/"${CARGO_TARGET_NAME}"/release/gitui "$MCHS_PREFIX"/bin/
}

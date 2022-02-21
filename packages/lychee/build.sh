MCHS_PKG_HOMEPAGE=https://github.com/lycheeverse/lychee
MCHS_PKG_DESCRIPTION="A fast, async, resource-friendly link checker written in Rust"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="LICENSE-MIT, LICENSE-APACHE"
MCHS_PKG_MAINTAINER="Yaksh Bariya <yakshbari4@gmail.com>"
MCHS_PKG_VERSION=0.8.2
MCHS_PKG_SRCURL=https://github.com/lycheeverse/lychee/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=55b83a5d7145afc4358b29db49d8e107494b64bf4f8938da865ffed978d29cda
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_setup_rust
}

mchs_step_make() {
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/lychee
}

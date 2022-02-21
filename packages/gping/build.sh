MCHS_PKG_HOMEPAGE=https://github.com/orf/gping
MCHS_PKG_DESCRIPTION="Ping, but with a graph"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=1.2.6
MCHS_PKG_SRCURL=https://github.com/orf/gping/archive/refs/tags/gping-v$MCHS_PKG_VERSION.zip
MCHS_PKG_SHA256=406c4df10c99cf48b0806568e17a4b184486098fc974b0a7350190e6feb40536
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_setup_rust
}

mchs_step_make() {
	cd gping
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
	cd ..
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/gping
}

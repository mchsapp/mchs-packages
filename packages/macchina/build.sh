MCHS_PKG_HOMEPAGE=https://github.com/Macchina-CLI/macchina
MCHS_PKG_DESCRIPTION="A system information fetcher, with an emphasis on performance and minimalism."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Max Ferrer @PandaFoss"
MCHS_PKG_VERSION=6.0.1
MCHS_PKG_SRCURL=https://github.com/Macchina-CLI/macchina/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9752386497b83ff9aed90ab7d762495a78fcef276d8ddca28d9781ce391d4cf2
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_make_install() {
	mchs_setup_rust
	
	cargo build --jobs ${MCHS_MAKE_PROCESSES} --target ${CARGO_TARGET_NAME} --release
	install -Dm755 -t ${MCHS_PREFIX}/bin target/${CARGO_TARGET_NAME}/release/macchina
}

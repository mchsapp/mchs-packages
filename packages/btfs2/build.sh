MCHS_PKG_HOMEPAGE=https://www.bittorrent.com/btfs/
MCHS_PKG_DESCRIPTION="Decentralized file system integrating with TRON network and Bittorrent network"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
MCHS_PKG_MAINTAINER="Simbad Marino <cctechmx@gmail.com>"
MCHS_PKG_VERSION=2.1.0
MCHS_PKG_SRCURL=https://github.com/bittorrent/go-btfs/archive/refs/tags/btfs-v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=5960a0dbf57c7867cc76189b66a4867f7da899f222bd32c53d226f3090c600e5
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mchs_setup_golang
	export CGO_ENABLED=0
}

mchs_step_make() {
	make build
}

mchs_step_make_install() {
	install -m700 cmd/btfs/btfs $MCHS_PREFIX/bin/btfs2
}

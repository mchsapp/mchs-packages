MCHS_PKG_HOMEPAGE=https://www.bittorrent.com/btfs/
MCHS_PKG_DESCRIPTION="Decentralized file system integrating with TRON network"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.0
MCHS_PKG_SRCURL=https://github.com/TRON-US/go-btfs/archive/refs/tags/btfs-v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=27de546a83f2c7655a0dbe2bc12e6a8ca7c05ab52f1246263667396fd374f83e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_CACHEDIR/go

	make build
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin $MCHS_PKG_SRCDIR/cmd/btfs/btfs
}

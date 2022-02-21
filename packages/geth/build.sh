MCHS_PKG_HOMEPAGE=https://geth.ethereum.org/
MCHS_PKG_DESCRIPTION="Go implementation of the Ethereum protocol"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10.15
MCHS_PKG_SRCURL=https://github.com/ethereum/go-ethereum/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=0c03bdf88fc01053fee8d73e3acc9579354b8c3c2333b544b800040dcd414963
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "${GOPATH}"/src/github.com/ethereum
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/ethereum/go-ethereum

	cd "$GOPATH"/src/github.com/ethereum/go-ethereum
	for applet in geth abigen bootnode ethkey evm rlpdump puppeth; do
		(cd ./cmd/"$applet" && go build -v)
	done
	unset applet
}

mchs_step_make_install() {
	for applet in geth abigen bootnode ethkey evm rlpdump puppeth; do
		install -Dm700 \
			"$MCHS_PKG_SRCDIR/cmd/$applet/$applet" \
			"$MCHS_PREFIX"/bin/
	done
	unset applet
}

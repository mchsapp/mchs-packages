MCHS_PKG_HOMEPAGE=https://ipfs.io/
MCHS_PKG_DESCRIPTION="A peer-to-peer hypermedia distribution protocol"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.12.0
MCHS_PKG_SRCURL=https://github.com/ipfs/go-ipfs/releases/download/v${MCHS_PKG_VERSION}/go-ipfs-source.tar.gz
MCHS_PKG_SHA256=8d6a0c9bfc48a77667fc5887590e7fab7f62e8b87815da22f4e767455739d579
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_SUGGESTS="mchs-services"
MCHS_PKG_SERVICE_SCRIPT=("ipfs" "[ ! -d \"${MCHS_ANDROID_HOME}/.ipfs\" ] && ipfs init --empty-repo 2>&1 && ipfs config --json Swarm.EnableRelayHop false 2>&1 && ipfs config --json Swarm.EnableAutoRelay true 2>&1; exec ipfs daemon --enable-namesys-pubsub 2>&1")

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=${MCHS_PKG_BUILDDIR}
	export GOARCH=${MCHS_ARCH}

	if [ "${MCHS_ARCH}" = "aarch64" ]; then
		GOARCH="arm64"
	elif [ "${MCHS_ARCH}" = "i686" ]; then
		GOARCH="386"
	elif [ "${MCHS_ARCH}" = "x86_64" ]; then
		GOARCH="amd64"
	fi

	mkdir -p "${GOPATH}/src/github.com/ipfs"
	cp -a "${MCHS_PKG_SRCDIR}" "${GOPATH}/src/github.com/ipfs/go-ipfs"
	cd "${GOPATH}/src/github.com/ipfs/go-ipfs"

	make build

	# Fix folders without write permissions preventing which fails repeating builds:
	cd $MCHS_PKG_BUILDDIR
	find . -type d -exec chmod u+w {} \;
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "${MCHS_PKG_BUILDDIR}/src/github.com/ipfs/go-ipfs/cmd/ipfs/ipfs"
}

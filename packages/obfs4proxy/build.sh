MCHS_PKG_HOMEPAGE=https://github.com/Yawning/obfs4
MCHS_PKG_DESCRIPTION="A pluggable transport plugin for Tor"
MCHS_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause, GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.0.11
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/Yawning/obfs4/archive/obfs4proxy-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=46f621f1d94d244e7b1d0b93dafea7abadb2428f8b1d0463559426362ea98eae
MCHS_PKG_BUILD_IN_SRC=true

## obfs4proxy is a pluggable transport plugin for Tor, so
## marking "tor" package as dependency.
MCHS_PKG_DEPENDS="tor"

mchs_step_make() {
	mchs_setup_golang
	cd "$MCHS_PKG_SRCDIR"/obfs4proxy
	go get -d ./...
	go build .
}

mchs_step_post_make_install() {
	cd "$MCHS_PKG_SRCDIR"/obfs4proxy
	install -Dm700 obfs4proxy "${MCHS_PREFIX}"/bin/
}

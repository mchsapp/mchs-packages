MCHS_PKG_HOMEPAGE=https://github.com/FiloSottile/age
MCHS_PKG_DESCRIPTION="A simple, modern and secure encryption tool with small explicit keys, no config options, and UNIX-style composability"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:1.0.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/FiloSottile/age/archive/v${MCHS_PKG_VERSION:2}.tar.gz
MCHS_PKG_SHA256=8d27684f62f9dc74014035e31619e2e07f8b56257b1075560456cbf05ddbcfce

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	cd $MCHS_PKG_SRCDIR
	go build ./cmd/age
	go build ./cmd/age-keygen
}

mchs_step_make_install() {
	install -Dm755 -t "${MCHS_PREFIX}"/bin \
		"${MCHS_PKG_SRCDIR}"/age \
		"${MCHS_PKG_SRCDIR}"/age-keygen
}

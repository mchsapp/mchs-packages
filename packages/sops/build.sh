MCHS_PKG_HOMEPAGE=https://github.com/mozilla/sops
MCHS_PKG_DESCRIPTION="Simple and flexible tool for managing secrets"
MCHS_PKG_LICENSE="MPL-2.0"
MCHS_PKG_MAINTAINER="Philipp Schmitt @pschmitt"
MCHS_PKG_VERSION=3.7.1
MCHS_PKG_SRCURL="https://github.com/mozilla/sops/archive/v${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256=536ee140d888b53b71c1e8edd669f4c11bc573428983fbea644fbbfcd7d7079a

mchs_step_make_install() {
	mchs_setup_golang

	export GOPATH="${MCHS_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/go.mozilla.org"
	cp -a "${MCHS_PKG_SRCDIR}" "${GOPATH}/src/go.mozilla.org/sops"
	cd "${GOPATH}/src/go.mozilla.org/sops" || return 9
	go get -d -v
	make install

	install -Dm700 "${GOPATH}/bin/"*/sops "${MCHS_PREFIX}/bin/sops"
}

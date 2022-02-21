MCHS_PKG_HOMEPAGE=https://restic.net/
MCHS_PKG_DESCRIPTION="Restic's REST backend API server"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.10.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/restic/rest-server/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d109cf9e9c3f36c9c8eb6d4a2bd530c5dfcd62b11687d93034e2edc0fdecf479
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang
	_GOARCH="${GOARCH}"
	unset GOOS GOARCH
	go run build.go \
		--enable-cgo \
		--goos android \
		--goarch "${_GOARCH}"
}

mchs_step_make_install() {
	install -Dm755 rest-server "${MCHS_PREFIX}/bin/rest-server"
}

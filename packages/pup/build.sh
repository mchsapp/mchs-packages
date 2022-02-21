MCHS_PKG_HOMEPAGE=https://github.com/ericchiang/pup
MCHS_PKG_DESCRIPTION="command line tool for processing HTML"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=0.4.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/ericchiang/pup/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=0d546ab78588e07e1601007772d83795495aa329b19bd1c3cde589ddb1c538b0
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"

	export GOPATH="${MCHS_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/ericchiang/"
	cp -a "${MCHS_PKG_SRCDIR}" "${GOPATH}/src/github.com/ericchiang/pup"
	cd "${GOPATH}/src/github.com/ericchiang/pup"
	export GO111MODULE=off

	go get -d -v
	go build
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$GOPATH"/src/github.com/ericchiang/pup/pup
}

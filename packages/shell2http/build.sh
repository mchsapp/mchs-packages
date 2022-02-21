MCHS_PKG_HOMEPAGE=https://github.com/msoap/shell2http
MCHS_PKG_DESCRIPTION="Executing shell commands via HTTP server"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=1.14.1
MCHS_PKG_SRCURL=https://github.com/msoap/shell2http/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bc09d026a3d947f4706f9c25fb07b70b01b355d0bca4f5af469ae2f79e0c5121
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"

	export GOPATH="${MCHS_PKG_BUILDDIR}"
	mkdir -p "${GOPATH}/src/github.com/msoap/"
	cp -a "${MCHS_PKG_SRCDIR}" "${GOPATH}/src/github.com/msoap/shell2http"
	cd "${GOPATH}/src/github.com/msoap/shell2http"
	go get -d -v
	go build -ldflags "-X 'main.version=$MCHS_PKG_VERSION'"
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$GOPATH"/src/github.com/msoap/shell2http/shell2http
}

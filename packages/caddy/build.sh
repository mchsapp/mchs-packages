MCHS_PKG_HOMEPAGE=https://caddyserver.com/
MCHS_PKG_DESCRIPTION="Fast, cross-platform HTTP/2 web server"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4.6
MCHS_PKG_SRCURL=https://github.com/caddyserver/caddy/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=5a450a4ff0d2dbd165d62f957ecdaebdc4bd0445c66a06a27d0025a82843402d
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	mkdir -p $GOPATH/src/github.com/caddyserver/
	cp -a $MCHS_PKG_SRCDIR $GOPATH/src/github.com/caddyserver/caddy

	cd $GOPATH/src/github.com/caddyserver/caddy/cmd/caddy
	export GO111MODULE=on
	go build -v .
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin $GOPATH/src/github.com/caddyserver/caddy/cmd/caddy/caddy
}

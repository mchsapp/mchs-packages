MCHS_PKG_HOMEPAGE=https://algernon.roboticoverlords.org/
MCHS_PKG_DESCRIPTION="Small self-contained web server with Lua, Markdown, QUIC, Redis and PostgreSQL support"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.12.14
MCHS_PKG_SRCURL=https://github.com/xyproto/algernon/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=cab5b01923142e0326ea2a01797814bb2e8ea9f7c6c41a3ea0ae7df3b667e86e
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/xyproto
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/xyproto/algernon

	cd "$GOPATH"/src/github.com/xyproto/algernon

	go build
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/xyproto/algernon/algernon \
		"$MCHS_PREFIX"/bin/

	# Offline samples may be useful to get started with Algernon.
	rm -rf "$MCHS_PREFIX"/share/doc/algernon
	mkdir -p "$MCHS_PREFIX"/share/doc/algernon
	cp -a "$GOPATH"/src/github.com/xyproto/algernon/samples \
		"$MCHS_PREFIX"/share/doc/algernon/
}

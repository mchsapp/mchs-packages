MCHS_PKG_HOMEPAGE=https://github.com/mvdan/sh
MCHS_PKG_DESCRIPTION="A shell parser and formatter"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.4.3
MCHS_PKG_SRCURL=https://github.com/mvdan/sh/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8bfb7cc980164bfeeedd2f8866e6af23c31a4720965601a5b777a14783dfe031
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make_install() {
	cd "$MCHS_PKG_SRCDIR"

	mchs_setup_golang

	export GOPATH="$MCHS_PKG_BUILDDIR"
	mkdir -p "$GOPATH/src/github.com/mvdan"
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH/src/github.com/mvdan/sh"

	go build -modcacherw \
		-ldflags "-X main.version=$MCHS_PKG_VERSION" \
		-o "$MCHS_PREFIX/bin/shfmt" \
		./cmd/shfmt
}

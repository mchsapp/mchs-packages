MCHS_PKG_HOMEPAGE=https://github.com/asciimoo/wuzz
MCHS_PKG_DESCRIPTION="Interactive command line tool for HTTP inspection"
MCHS_PKG_LICENSE="AGPL-V3"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/asciimoo/wuzz/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=721ea7343698e9f3c69e09eab86b9b1fef828057655f7cebc1de728c2f75151e
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/asciimoo
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/asciimoo/wuzz

	cd "$GOPATH"/src/github.com/asciimoo/wuzz
	go mod download github.com/BurntSushi/toml
	go get github.com/asciimoo/wuzz
	go build
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/asciimoo/wuzz/wuzz \
		"$MCHS_PREFIX"/bin/wuzz
}

MCHS_PKG_HOMEPAGE=https://cli.github.com/
MCHS_PKG_DESCRIPTION="GitHub’s official command line tool"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=2.5.1
MCHS_PKG_SRCURL=https://github.com/cli/cli/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=89aac9c35ad875f1b17144bf9fcbfa7231554d4abce187d9277fcc83da846e4a
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"
	(
		unset GOOS GOARCH CGO_LDFLAGS
		unset CC CXX CFLAGS CXXFLAGS LDFLAGS
		go run ./cmd/gen-docs --man-page --doc-path $MCHS_PREFIX/share/man/man1/
	)
	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/cli/
	mkdir -p "$MCHS_PREFIX"/share/doc/gh
	cp -a "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/cli/cli
	cd "$GOPATH"/src/github.com/cli/cli/cmd/gh
	go get -d -v
	go build -ldflags="-X github.com/cli/cli/v${MCHS_PKG_VERSION%%.*}/internal/build.Version=$MCHS_PKG_VERSION"
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$GOPATH"/src/github.com/cli/cli/cmd/gh/gh
	install -Dm600 -t "$MCHS_PREFIX"/share/doc/gh/ "$MCHS_PKG_SRCDIR"/docs/*
}

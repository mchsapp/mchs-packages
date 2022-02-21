MCHS_PKG_HOMEPAGE=https://github.com/go-shiori/shiori
MCHS_PKG_DESCRIPTION="Simple bookmark manager built with Go"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
MCHS_PKG_VERSION=1.5.1
MCHS_PKG_SRCURL=https://github.com/go-shiori/shiori/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=d7d9c00b8b2866b51f58dcea9b045ae560deb9b48093a2cb56dc17881ea055b2
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	cd "$MCHS_PKG_SRCDIR"
	
	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/go-shiori/
	mkdir -p "$MCHS_PREFIX"/share/doc/shiori
	cp -a "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/go-shiori/shiori
	cd "$GOPATH"/src/github.com/go-shiori/shiori/
	go get -d -v
	go build
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$GOPATH"/src/github.com/go-shiori/shiori/shiori
	cp -a "$MCHS_PKG_SRCDIR"/docs/ "$MCHS_PREFIX"/share/doc/shiori
}

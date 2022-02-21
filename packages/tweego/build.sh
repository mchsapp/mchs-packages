MCHS_PKG_HOMEPAGE=https://bitbucket.org/tmedwards/tweego
MCHS_PKG_DESCRIPTION="A free command line compiler for Twine/Twee story formats"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/tmedwards/tweego/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f58991ff0b5b344ebebb5677b7c21209823fa6d179397af4a831e5ef05f28b02
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/tmedwards
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/tmedwards/tweego

	cd "$GOPATH"/src/github.com/tmedwards/tweego
	go get -d -v github.com/tmedwards/tweego
	go build
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/tmedwards/tweego/tweego \
		"$MCHS_PREFIX"/bin/
}

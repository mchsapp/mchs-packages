MCHS_PKG_HOMEPAGE=https://github.com/matsuyoshi30/germanium
MCHS_PKG_DESCRIPTION="Generate image from source code"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Raven Ravener <ravener.anime@gmail.com>"
MCHS_PKG_VERSION=1.2.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/matsuyoshi30/germanium/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=859fed54957f46e25b4577b561a810186cc21c1f0dfd99d5226e99764df195d9
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_get_source() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_SRCDIR/go
	go get -d ./cmd/germanium
	chmod +w $GOPATH -R
}

mchs_step_make() {
	export GOPATH=$MCHS_PKG_SRCDIR/go
	go build -o germanium -v ./cmd/germanium
}
 
mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin germanium
}

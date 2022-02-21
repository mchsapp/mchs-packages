MCHS_PKG_HOMEPAGE=https://github.com/tsenart/vegeta
MCHS_PKG_DESCRIPTION="HTTP load testing tool"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=12.8.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/tsenart/vegeta/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=418249d07f04da0a587df45abe34705166de9e54a836e27e387c719ebab3e357
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/tsenart
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/tsenart/vegeta

	cd "$GOPATH"/src/github.com/tsenart/vegeta
	go build
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/tsenart/vegeta/vegeta \
		"$MCHS_PREFIX"/bin/vegeta
}

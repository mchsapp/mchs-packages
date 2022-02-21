MCHS_PKG_HOMEPAGE=https://github.com/sorenisanerd/gotty
MCHS_PKG_DESCRIPTION="Share your terminal as a web application"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/sorenisanerd/gotty/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=09cc4fe278fa866df895527047ce83f009de97c01bab729651adac9db306f273
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/yudai
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/yudai/gotty

	cd "$GOPATH"/src/github.com/yudai/gotty
	go mod init || go mod download
	#go mod tidy
	go build
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/yudai/gotty/gotty \
		"$MCHS_PREFIX"/bin/
}

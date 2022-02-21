MCHS_PKG_HOMEPAGE=https://fly.io
MCHS_PKG_DESCRIPTION="Command line tools for fly.io services"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="Yaksh Bariya <yakshbari4@gmail.com>"
MCHS_PKG_VERSION=0.0.297
MCHS_PKG_SRCURL=https://github.com/superfly/flyctl/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=691c1c5581d0def27c926cefac80962b4a03a8b25b49ee3a67cd692baf790ff0
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BLACKLISTED_ARCHES="i686, arm"


mchs_step_post_get_source() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_SRCDIR/go
	go get
	chmod +w $GOPATH -R
}

mchs_step_make() {
	export GOPATH=$MCHS_PKG_SRCDIR/go
	go build -o bin/flyctl
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$MCHS_PKG_SRCDIR/bin/flyctl"
}

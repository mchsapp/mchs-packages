MCHS_PKG_HOMEPAGE=https://github.com/elves/elvish
MCHS_PKG_DESCRIPTION="A friendly and expressive Unix shell"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15.0
MCHS_PKG_SRCURL=https://github.com/elves/elvish/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=761739307c68fcbc51fd46c052c0a20ae848a30dba1ce3fbb6d27f99672f58e0

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/elves
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/elves/elvish

	cd "$GOPATH"/src/github.com/elves/elvish
	go build
}

mchs_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/elves/elvish/elvish \
		"$MCHS_PREFIX"/bin/elvish
}

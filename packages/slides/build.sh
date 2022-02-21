MCHS_PKG_HOMEPAGE=https://github.com/maaslalani/slides
MCHS_PKG_DESCRIPTION="Slides in your terminal"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Yaksh Bariya <yakshbari4@gmail.com>"
MCHS_PKG_VERSION=0.7.3
MCHS_PKG_SRCURL=https://github.com/maaslalani/slides/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=1d0c08ece824825a8150c4c92ed4d3cc007eb4aa0fa659a8f3fda4207e0a0b24
MCHS_PKG_AUTO_UPDATE=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	cd "$MCHS_PKG_SRCDIR"
	make build
}

mchs_step_make_install() {
	install -Dm700 \
		"$MCHS_PKG_SRCDIR"/slides \
		"$MCHS_PREFIX"/bin/
}

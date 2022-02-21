MCHS_PKG_HOMEPAGE=https://github.com/go-delve/delve
MCHS_PKG_DESCRIPTION="A debugger for the Go programming language"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Krishna kanhaiya @kcubeterm"
MCHS_PKG_VERSION=1.8.1
MCHS_PKG_DEPENDS="golang, git"
MCHS_PKG_SRCURL=https://github.com/go-delve/delve/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=e5b2ec78add2a167e1fdc11e3e189dec1bbed2cd9b6e99b3d79c0630b4b83e37
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_make() {
	mchs_setup_golang
	cd $MCHS_PKG_SRCDIR

	mkdir -p "$MCHS_PKG_BUILDDIR"/src/github.com/go-delve/    
	mkdir -p "$MCHS_PREFIX"/share/doc/delve
	cp -a "$MCHS_PKG_SRCDIR" "$MCHS_PKG_BUILDDIR"/src/github.com/go-delve/delve/
	cd "$MCHS_PKG_BUILDDIR"/src/github.com/go-delve/delve/cmd/dlv/
	go get -d -v
	go build
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$MCHS_PKG_BUILDDIR"/src/github.com/go-delve/delve/cmd/dlv/dlv
	cp -a "$MCHS_PKG_SRCDIR"/Documentation/* "$MCHS_PREFIX"/share/doc/delve
}

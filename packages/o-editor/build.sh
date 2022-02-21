MCHS_PKG_HOMEPAGE=https://github.com/xyproto/o
MCHS_PKG_DESCRIPTION="Small, fast and limited text editor"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Alexander F. Rødseth <xyproto@archlinux.org>"
MCHS_PKG_VERSION=2.47.0
MCHS_PKG_SRCURL=https://github.com/xyproto/o/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=d9e7626650c3b8be7ddc276e92a191ae38e05df5e1476d18d1862a8342b2f2ad
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="o"
MCHS_PKG_REPLACES="o"

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/xyproto
	ln -sf "$MCHS_PKG_SRCDIR" "$GOPATH"/src/github.com/xyproto/o

	cd "$GOPATH"/src/github.com/xyproto/o
	go build
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin "$GOPATH"/src/github.com/xyproto/o/o
	install -Dm600 -t "$MCHS_PREFIX"/share/man/man1 "$MCHS_PKG_SRCDIR"/o.1
}

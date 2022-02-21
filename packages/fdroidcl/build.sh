MCHS_PKG_HOMEPAGE=https://github.com/mvdan/fdroidcl
MCHS_PKG_DESCRIPTION="F-Droid client"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.0
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=https://github.com/mvdan/fdroidcl/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=532a8c4c93216cbf13378ff409c06a08d48e8baee6119a50ed43dc0ce9ec7879
MCHS_PKG_DEPENDS="android-tools"

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR

	mkdir -p "$GOPATH"/src/mvdan.cc
	cp -a "$MCHS_PKG_SRCDIR" "$GOPATH"/src/mvdan.cc/fdroidcl
	cd "$GOPATH"/src/mvdan.cc/fdroidcl

	go build .
}

mchs_step_make_install() {
	install -Dm700 "$MCHS_PKG_BUILDDIR"/src/mvdan.cc/fdroidcl/fdroidcl \
		"$MCHS_PREFIX"/bin/fdroidcl
}

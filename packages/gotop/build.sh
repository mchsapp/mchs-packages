MCHS_PKG_HOMEPAGE=https://github.com/xxxserxxx/gotop
MCHS_PKG_DESCRIPTION="A terminal based graphical activity monitor inspired by gtop and vtop"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@medzikuser"
MCHS_PKG_VERSION=4.1.2
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/xxxserxxx/gotop/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=81518fecfdab4f4c25a4713e24d9c033ba8311bbd3e2c0435ba76349028356da

mchs_step_make_install() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_BUILDDIR

	cd $MCHS_PKG_SRCDIR

	go build -o gotop \
	    -ldflags "-X main.Version=v${MCHS_PKG_VERSION} -X main.BuildDate=$(date +%Y%m%dT%H%M%S)" \
	    ./cmd/gotop

	install -Dm700 -t $MCHS_PREFIX/bin ./gotop
}

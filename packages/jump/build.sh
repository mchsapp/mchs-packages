MCHS_PKG_HOMEPAGE=https://github.com/gsamokovarov/jump
MCHS_PKG_DESCRIPTION="Jump helps you navigate in shell faster by learning your habits"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.40.0
MCHS_PKG_SRCURL=https://github.com/gsamokovarov/jump/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f005f843fc65b7be1d4159da7d4c220eef0229ecec9935c6ac23e4963eef645e

mchs_step_make() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR
	cd $MCHS_PKG_SRCDIR
	go build .
}

mchs_step_make_install() {
	install -Dm755 -t "${MCHS_PREFIX}"/bin \
		"${MCHS_PKG_SRCDIR}"/jump
}

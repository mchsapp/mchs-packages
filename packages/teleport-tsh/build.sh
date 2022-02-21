MCHS_PKG_HOMEPAGE=https://github.com/gravitational/teleport
MCHS_PKG_DESCRIPTION="Secure Access for Developers that doesn't get in the way"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.3.1
MCHS_PKG_SKIP_SRC_EXTRACT=true

mchs_step_make_install() {
	mchs_setup_golang
	export GOPATH=$MCHS_PKG_BUILDDIR
	export BUILDDIR=$MCHS_PREFIX/bin

	mkdir -p $GOPATH/src/github.com/gravitational
	cd $GOPATH/src/github.com/gravitational
	git clone https://github.com/gravitational/teleport.git
	cd teleport

	git checkout "v$MCHS_PKG_VERSION"

	make $BUILDDIR/tsh
}

MCHS_PKG_HOMEPAGE=https://github.com/github/git-sizer
MCHS_PKG_DESCRIPTION="Compute various size metrics for a Git repository"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Yaksh Bariya <yakshbari4@gmail.com>"
MCHS_PKG_VERSION=1.5.0
MCHS_PKG_SRCURL=https://github.com/github/git-sizer/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=07a5ac5f30401a17d164a6be8d52d3d474ee9c3fb7f60fd83a617af9f7e902bb
MCHS_PKG_DEPENDS="git"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang

	export GOPATH=$MCHS_PKG_CACHEDIR/go
	make
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin bin/git-sizer
}

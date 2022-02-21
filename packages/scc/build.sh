MCHS_PKG_HOMEPAGE=https://github.com/boyter/scc
MCHS_PKG_DESCRIPTION="Counts physical the lines of code, blank lines, comment lines, and physical lines of source code"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.0.0
MCHS_PKG_SRCURL=https://github.com/boyter/scc.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang

	go mod init || :
	go mod tidy
	go build
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin scc
}

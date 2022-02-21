MCHS_PKG_HOMEPAGE=https://github.com/akavel/up
MCHS_PKG_DESCRIPTION="Helps interactively and incrementally explore textual data in Linux"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4
MCHS_PKG_SRCURL=https://github.com/akavel/up.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang

	go mod init || :
	go mod tidy
	go build
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin up
}

MCHS_PKG_HOMEPAGE=https://github.com/sachaos/viddy
MCHS_PKG_DESCRIPTION="A modern watch command"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.3.4
MCHS_PKG_SRCURL=https://github.com/sachaos/viddy.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang

	go mod init || :
	go mod tidy
	go build
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin viddy
}

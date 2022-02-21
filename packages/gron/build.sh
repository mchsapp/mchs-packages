MCHS_PKG_HOMEPAGE=https://github.com/tomnomnom/gron
MCHS_PKG_DESCRIPTION="Transforms JSON into discrete assignments"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6.1
MCHS_PKG_SRCURL=https://github.com/tomnomnom/gron.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang

	go mod init || :
	go mod tidy
	go build
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin gron
}

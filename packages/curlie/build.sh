MCHS_PKG_HOMEPAGE=https://curlie.io/
MCHS_PKG_DESCRIPTION="The power of curl, the ease of use of httpie"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.7
MCHS_PKG_SRCURL=https://github.com/rs/curlie.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang

	go mod init || :
	go mod tidy
	go build
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin curlie
}

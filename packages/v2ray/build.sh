MCHS_PKG_HOMEPAGE=https://www.v2fly.org/
MCHS_PKG_DESCRIPTION="A platform for building proxies to bypass network restrictions"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.0.3
MCHS_PKG_SRCURL=https://github.com/v2fly/v2ray-core.git
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	mchs_setup_golang
	go mod init || :
	go mod tidy
	go build -o v2ray ./main
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin v2ray
	install -Dm600 -t $MCHS_PREFIX/share/v2ray release/config/*.json
}

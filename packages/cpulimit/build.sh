MCHS_PKG_HOMEPAGE=https://github.com/opsengine/cpulimit
MCHS_PKG_DESCRIPTION="CPU usage limiter"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2
MCHS_PKG_SRCURL=https://github.com/opsengine/cpulimit/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=64312f9ac569ddcadb615593cd002c94b76e93a0d4625d3ce1abb49e08e2c2da
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin src/cpulimit
}

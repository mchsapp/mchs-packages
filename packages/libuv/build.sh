MCHS_PKG_HOMEPAGE=https://libuv.org
MCHS_PKG_DESCRIPTION="Support library with a focus on asynchronous I/O"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.43.0
MCHS_PKG_SRCURL=https://dist.libuv.org/dist/v${MCHS_PKG_VERSION}/libuv-v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=90d72bb7ae18de2519d0cac70eb89c319351146b90cd3f91303a492707e693a4
MCHS_PKG_BREAKS="libuv-dev"
MCHS_PKG_REPLACES="libuv-dev"

mchs_step_pre_configure() {
	export PLATFORM=android
	sh autogen.sh
}

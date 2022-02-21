MCHS_PKG_HOMEPAGE=https://github.com/wg/wrk
MCHS_PKG_DESCRIPTION="Modern HTTP benchmarking tool"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.1.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/wg/wrk/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6fa1020494de8c337913fd139d7aa1acb9a020de6f7eb9190753aa4b1e74271e
MCHS_PKG_DEPENDS="openssl, luajit"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	local _ARCH

	if [ "$MCHS_ARCH" = "i686" ]; then
		_ARCH="x86"
	elif [ "$MCHS_ARCH" = "x86_64" ]; then
		_ARCH="x64"
	elif [ "$MCHS_ARCH" = "aarch64" ]; then
		_ARCH="arm64"
	else
		_ARCH=$MCHS_ARCH
	fi

	make WITH_OPENSSL=$MCHS_PREFIX WITH_LUAJIT=$MCHS_PREFIX _ARCH=$_ARCH
}

mchs_step_make_install() {
	install -Dm700 -t "$MCHS_PREFIX"/bin wrk
	install -Dm600 -t "$MCHS_PREFIX"/share/doc/wrk/examples/ scripts/*.lua
	install -Dm600 -t "$MCHS_PREFIX"/share/lua/5.1/ src/wrk.lua
}

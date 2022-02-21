MCHS_PKG_HOMEPAGE=https://www.unicorn-engine.org/
MCHS_PKG_DESCRIPTION="Unicorn is a lightweight multi-platform, multi-architecture CPU emulator framework."
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.3
MCHS_PKG_SRCURL=https://github.com/unicorn-engine/unicorn/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=64fba177dec64baf3f11c046fbb70e91483e029793ec6a3e43b028ef14dc0d65
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="unicorn-dev"
MCHS_PKG_REPLACES="unicorn-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	mv CMakeLists.txt CMakeLists.txt.unused
}

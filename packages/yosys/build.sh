MCHS_PKG_HOMEPAGE=https://yosyshq.net/yosys/
MCHS_PKG_DESCRIPTION="A framework for RTL synthesis tools"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.13
MCHS_PKG_SRCURL=https://github.com/YosysHQ/yosys/archive/refs/tags/yosys-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=004c203cb516887a8c76678a1fd76381198a8c46a17f4d893c34b7521df894b5
MCHS_PKG_DEPENDS="graphviz, libandroid-glob, libandroid-spawn, libc++, libffi, readline, tcl, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS="PREFIX=$MCHS_PREFIX"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob -landroid-spawn"
}

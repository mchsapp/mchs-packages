MCHS_PKG_HOMEPAGE=https://lz4.github.io/lz4/
MCHS_PKG_DESCRIPTION="Fast LZ compression algorithm library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.9.3
MCHS_PKG_SRCURL=https://github.com/lz4/lz4/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=030644df4611007ff7dc962d981f390361e6c97a34e5cbc393ddfbe019ffe2c1
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="liblz4-dev"
MCHS_PKG_REPLACES="liblz4-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR+=lib
}

# Do not execute this step since on `make install` it will
# recompile libraries & tools again.
mchs_step_make() {
	:
}

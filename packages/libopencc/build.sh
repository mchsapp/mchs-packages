MCHS_PKG_HOMEPAGE=https://github.com/BYVoid/OpenCC
MCHS_PKG_DESCRIPTION="An opensource project for conversions between Traditional Chinese, Simplified Chinese and Japanese Kanji (Shinjitai)"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/BYVoid/OpenCC/archive/ver.${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=99a9af883b304f11f3b0f6df30d9fb4161f15b848803f9ff9c65a96d59ce877f
MCHS_PKG_DEPENDS="libc++, marisa"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_SYSTEM_MARISA=ON"
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	mchs_setup_cmake
	cmake $MCHS_PKG_SRCDIR
	make -j $MCHS_MAKE_PROCESSES
}

mchs_step_post_configure() {
	export PATH=$MCHS_PKG_HOSTBUILD_DIR/src/tools:$PATH
}

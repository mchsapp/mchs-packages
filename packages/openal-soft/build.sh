MCHS_PKG_HOMEPAGE=https://openal-soft.org/
MCHS_PKG_DESCRIPTION="Software implementation of the OpenAL API"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.21.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/kcat/openal-soft/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8ac17e4e3b32c1af3d5508acfffb838640669b4274606b7892aa796ca9d7467f
MCHS_PKG_BREAKS="openal-soft-dev"
MCHS_PKG_REPLACES="openal-soft-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DALSOFT_UTILS=ON
-DALSOFT_NO_CONFIG_UTIL=ON
-DALSOFT_EXAMPLES=ON
-DALSOFT_TESTS=OFF
-DALSOFT_REQUIRE_OPENSL=ON
"
mchs_step_pre_configure() {
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DOPENSL_LIBRARY=$MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/libOpenSLES.so"
}

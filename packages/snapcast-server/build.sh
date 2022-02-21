MCHS_PKG_HOMEPAGE=https://github.com/badaix/snapcast
MCHS_PKG_DESCRIPTION="A multiroom client-server audio player (server)"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.25.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/badaix/snapcast/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c4e449cb693e091261727421f4965492be049632537e034fa9c59c92d091a846
MCHS_PKG_DEPENDS="libc++, libexpat, libflac, libopus, libsoxr, libvorbis"
MCHS_PKG_BUILD_DEPENDS="boost"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTS=OFF
-DBoost_INCLUDE_DIR=$MCHS_PREFIX/include
"

mchs_step_pre_configure() {
	LDFLAGS+=" -llog"
}

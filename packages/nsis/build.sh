MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/nsis/
MCHS_PKG_DESCRIPTION="A professional open source system to create Windows installers"
# Licenses: zlib/libpng, bzip2, CPL-1.0
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.08
MCHS_PKG_SRCURL=https://prdownloads.sourceforge.net/nsis/nsis-${MCHS_PKG_VERSION}-src.tar.bz2
MCHS_PKG_SHA256=a85270ad5386182abecb2470e3d7e9bec9fe4efd95210b13551cb386830d1e87
MCHS_PKG_DEPENDS="libandroid-support, libc++, libiconv, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install() {
	scons \
		CC="$(which $CC)" \
		CXX="$(which $CXX)" \
		APPEND_CCFLAGS="$CFLAGS $CPPFLAGS" \
		APPEND_LINKFLAGS="$LDFLAGS" \
		SKIPSTUBS=all \
		SKIPPLUGINS=all \
		SKIPUTILS=all \
		SKIPMISC=all \
		NSIS_CONFIG_CONST_DATA_PATH=no \
		PREFIX="$MCHS_PREFIX/opt/nsis" \
		install-compiler
}

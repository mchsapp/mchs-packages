## * Requires pulseaudio build and source directory.
## * Uses scons build system which is not good at cross-compiling.

MCHS_PKG_HOMEPAGE=https://roc-project.github.io
MCHS_PKG_DESCRIPTION="Roc real-time streaming over the network"
MCHS_PKG_LICENSE="LGPL-2.0, MPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.1.1
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/roc-project/roc/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=2aa63061b586a5f16cfcb0bfe304015a6effdcb373513cb62e76283bde7dd104
MCHS_PKG_DEPENDS="libltdl, libopenfec, libuv, pulseaudio"
MCHS_PKG_BREAKS="roc-dev"
MCHS_PKG_REPLACES="roc-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	SCONS_CONFIGURE_ARGS=""
	SCONS_CONFIGURE_ARGS+=" --prefix=$MCHS_PREFIX"
	SCONS_CONFIGURE_ARGS+=" --host=$MCHS_HOST_PLATFORM"
	SCONS_CONFIGURE_ARGS+=" --compiler=clang"
	SCONS_CONFIGURE_ARGS+=" --disable-tools"
	SCONS_CONFIGURE_ARGS+=" --disable-tests"
	SCONS_CONFIGURE_ARGS+=" --disable-examples"
	SCONS_CONFIGURE_ARGS+=" --disable-doc"
	SCONS_CONFIGURE_ARGS+=" --disable-sox"
	#SCONS_CONFIGURE_ARGS+=" --disable-openfec"
	SCONS_CONFIGURE_ARGS+=" --enable-pulseaudio-modules"
	SCONS_CONFIGURE_ARGS+=" --with-openfec-includes=$MCHS_PREFIX/include/openfec"
	SCONS_CONFIGURE_ARGS+=" --with-pulseaudio=$MCHS_TOPDIR/pulseaudio/src"
	SCONS_CONFIGURE_ARGS+=" --with-pulseaudio-build-dir=$MCHS_TOPDIR/pulseaudio/build"

	scons $SCONS_CONFIGURE_ARGS
}

mchs_step_make_install() {
	scons $SCONS_CONFIGURE_ARGS install
}

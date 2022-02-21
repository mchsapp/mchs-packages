MCHS_PKG_HOMEPAGE=https://portal.hdfgroup.org/display/support
MCHS_PKG_DESCRIPTION="Hierarchical Data Format 5 (HDF5)"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.12.0
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${MCHS_PKG_VERSION:0:4}/hdf5-$MCHS_PKG_VERSION/src/hdf5-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=97906268640a6e9ce0cde703d5a71c9ac3092eded729591279bf2e3ca9765f61
MCHS_PKG_DEPENDS="libc++, libzopfli, zlib"
MCHS_PKG_BREAKS="libhdf5-dev"
MCHS_PKG_REPLACES="libhdf5-dev"
MCHS_PKG_GROUPS="science"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DHDF5_ENABLE_Z_LIB_SUPPORT=on
-C$MCHS_PKG_BUILDER_DIR/$MCHS_ARCH/TryRunResults_out.cmake
"

mchs_step_pre_configure () {
	cp $MCHS_PKG_BUILDER_DIR/$MCHS_ARCH/{H5Tinit.c,H5lib_settings.c} $MCHS_PKG_BUILDDIR/
	mkdir -p $MCHS_PKG_BUILDDIR/shared/
	cp $MCHS_PKG_BUILDER_DIR/$MCHS_ARCH/{H5Tinit.c,H5lib_settings.c} $MCHS_PKG_BUILDDIR/shared/
	touch $MCHS_PKG_BUILDDIR/gen_SRCS.stamp1 $MCHS_PKG_BUILDDIR/gen_SRCS.stamp2
	touch $MCHS_PKG_BUILDDIR/shared/shared_gen_SRCS.stamp1 $MCHS_PKG_BUILDDIR/shared/shared_gen_SRCS.stamp2
}

mchs_step_post_configure () {
	cp $MCHS_PKG_BUILDER_DIR/$MCHS_ARCH/{H5Tinit.c,H5lib_settings.c} $MCHS_PKG_BUILDDIR/shared/
}

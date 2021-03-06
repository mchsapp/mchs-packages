MCHS_PKG_HOMEPAGE=https://postgis.net
MCHS_PKG_DESCRIPTION="Spatial database extender for PostgreSQL object-relational database"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://download.osgeo.org/postgis/source/postgis-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=dc8e3fe8bc532e422f5d724c5a7c437f6555511716f6410d4d2db9762e1a3796
MCHS_PKG_DEPENDS="gdal, json-c, postgresql, proj, libprotobuf-c, libxml2, libiconv"

# both configure script and Makefile(s) look for files in current
# directory rather than srcdir, so need to build in source
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	# Configure script wants to run a cross-compiled program to
	# get proj and protobuf version, which won't work for us.
	local proj_version=$(. $MCHS_SCRIPTDIR/packages/proj/build.sh; echo $MCHS_PKG_VERSION)
	# 8.1.1 -> 81
	proj_version=${proj_version:0:1}${proj_version:2:1}
	local protobuf_version=$(. $MCHS_SCRIPTDIR/packages/libprotobuf-c/build.sh; echo $MCHS_PKG_VERSION)
	# 1.3.3 -> 1003003
	protobuf_version=${protobuf_version:0:1}00${protobuf_version:2:1}00${protobuf_version:4:1}
	echo "Patching configure script"
	sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" \
		-e "s|@PROJ_VERSION@|${proj_version}|g" \
		-e "s|@PROTOBUF_VERSION@|${protobuf_version}|g" \
		$MCHS_PKG_BUILDER_DIR/configure.diff | patch -Np1
}

MCHS_PKG_HOMEPAGE=https://osmcode.org/libosmium/
MCHS_PKG_DESCRIPTION="Library for reading from and writing to OSM files in XML and PBF formats"
MCHS_PKG_LICENSE="BSL-1.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.17.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/osmcode/libosmium/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=4a7672d7caf4da3bc68619912b298462370c423c697871a0be6273c6686e10d6
MCHS_PKG_DEPENDS="libprotobuf, libosmpbf, libprotozero, libexpat, zlib, libbz2, boost, gdal, proj, liblz4"
MCHS_PKG_GROUPS="science"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DINSTALL_UTFCPP=ON -DBUILD_EXAMPLES=OFF -DBUILD_DATA_TESTS=OFF"

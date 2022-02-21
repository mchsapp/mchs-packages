MCHS_PKG_HOMEPAGE=https://gdal.org
MCHS_PKG_DESCRIPTION="A translator library for raster and vector geospatial data formats"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="LICENSE.TXT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.4.1
MCHS_PKG_SRCURL=https://download.osgeo.org/gdal/${MCHS_PKG_VERSION}/gdal-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=332f053516ca45101ef0f7fa96309b64242688a8024780a5d93be0230e42173d
MCHS_PKG_DEPENDS="libc++, openjpeg, libcurl, libtiff, libpng, proj, libiconv, libsqlite, libgeos, libspatialite, libexpat, postgresql, netcdf-c"
MCHS_PKG_BREAKS="gdal-dev"
MCHS_PKG_REPLACES="gdal-dev"
MCHS_PKG_GROUPS="science"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-sqlite3=$MCHS_PREFIX
--with-spatialite=$MCHS_PREFIX
--with-expat=$MCHS_PREFIX
"

mchs_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

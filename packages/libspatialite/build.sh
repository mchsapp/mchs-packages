MCHS_PKG_HOMEPAGE=https://www.gaia-gis.it/fossil/libspatialite
MCHS_PKG_DESCRIPTION="SQLite extension to support spatial data types and operations"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.0.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://www.gaia-gis.it/gaia-sins/libspatialite-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=eecbc94311c78012d059ebc0fae86ea5ef6eecb13303e6e82b3753c1b3409e98
MCHS_PKG_DEPENDS="libgeos, proj, libfreexl, libsqlite, libxml2, librttopo"
MCHS_PKG_GROUPS="science"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-minizip"
# Can't find generated config file spatialite/gaiaconfig.h
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export LDFLAGS+=" -llog"
}

MCHS_PKG_HOMEPAGE=https://dev.maxmind.com/geoip/geoip2/
MCHS_PKG_DESCRIPTION="MaxMind GeoIP2 database - library and utilities"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.0
MCHS_PKG_SRCURL=https://github.com/maxmind/libmaxminddb/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=636b57461e641a84b99e170a2e0cc07b35fd030783d0c2c62521f33b7e921e33
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="libmaxminddb-dev"
MCHS_PKG_REPLACES="libmaxminddb-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-tests"

mchs_step_pre_configure() {
	./bootstrap
}

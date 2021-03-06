MCHS_PKG_HOMEPAGE=https://www.unidata.ucar.edu/software/netcdf/
MCHS_PKG_DESCRIPTION="NetCDF is a set of software libraries and self-describing, machine-independent data formats that support the creation, access, and sharing of array-oriented scientific data"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=4.8.0
MCHS_PKG_REVISION=1
MCHS_PKG_SHA256=aff58f02b1c3e91dc68f989746f652fe51ff39e6270764e484920cb8db5ad092
MCHS_PKG_SRCURL=https://github.com/Unidata/netcdf-c/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_DEPENDS="libcurl, openssl, libnghttp2"
MCHS_PKG_BREAKS="netcdf-c-dev"
MCHS_PKG_REPLACES="netcdf-c-dev"
MCHS_PKG_GROUPS="science"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-hdf5"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_HOMEPAGE=https://libxlsxwriter.github.io/
MCHS_PKG_DESCRIPTION="A C library for creating Excel XLSX files"
MCHS_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause, ZLIB, MPL-2.0, MIT, Public Domain"
MCHS_PKG_LICENSE_FILE="License.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/jmcnamara/libxlsxwriter/archive/refs/tags/RELEASE_${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b379eb35fdd9c653ebe72485b9c992f612c7ea66f732784457997d6e782f619b
MCHS_PKG_DEPENDS="zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"

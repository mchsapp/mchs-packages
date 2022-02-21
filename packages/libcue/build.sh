MCHS_PKG_HOMEPAGE=https://github.com/lipnitsk/libcue/
MCHS_PKG_DESCRIPTION="CUE Sheet Parser Library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/lipnitsk/libcue/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f27bc3ebb2e892cd9d32a7bee6d84576a60f955f29f748b9b487b173712f1200
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="libcue-dev"
MCHS_PKG_REPLACES="libcue-dev"
# To avoid picking up cross-compiled flex and bison:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=$(command -v bison)
-DFLEX_EXECUTABLE=$(command -v flex)
-DBUILD_SHARED_LIBS=ON
"

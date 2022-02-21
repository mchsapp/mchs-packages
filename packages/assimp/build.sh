MCHS_PKG_HOMEPAGE=http://assimp.sourceforge.net/index.html
MCHS_PKG_DESCRIPTION="Library to import various well-known 3D model formats in an uniform manner"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.2.2
MCHS_PKG_SRCURL=https://github.com/assimp/assimp/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=ad76c5d86c380af65a9d9f64e8fc57af692ffd80a90f613dfc6bd945d0b80bb4
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="boost, zlib"
MCHS_PKG_BREAKS="assimp-dev"
MCHS_PKG_REPLACES="assimp-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DASSIMP_BUILD_SAMPLES=OFF"

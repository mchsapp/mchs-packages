MCHS_PKG_HOMEPAGE=https://acoustid.org/chromaprint
MCHS_PKG_DESCRIPTION="C library for generating audio fingerprints used by AcoustID"
MCHS_PKG_LICENSE="LGPL-2.1, MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.5.0
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/acoustid/chromaprint/releases/download/v${MCHS_PKG_VERSION}/chromaprint-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=573a5400e635b3823fc2394cfa7a217fbb46e8e50ecebd4a61991451a8af766a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS=ffmpeg
# `-DBUILD_TOOLS=ON` is not speficied as `fpcalc` does not build with ffmpeg 5.0.
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON"
mchs_step_post_make_install() {
  ln -sf "${MCHS_PREFIX}/lib/libchromaprint.so" "${MCHS_PREFIX}/lib/libchromaprint.so.${MCHS_PKG_VERSION:0:1}"
  ln -sf "${MCHS_PREFIX}/lib/libchromaprint.so" "${MCHS_PREFIX}/lib/libchromaprint.so.${MCHS_PKG_VERSION}"
}

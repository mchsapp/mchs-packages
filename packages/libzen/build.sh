MCHS_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
MCHS_PKG_DESCRIPTION="ZenLib C++ utility library"
MCHS_PKG_LICENSE="ZLIB"
MCHS_PKG_LICENSE_FILE="../../../License.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4.39
MCHS_PKG_SRCURL=https://mediaarea.net/download/source/libzen/${MCHS_PKG_VERSION}/libzen_${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bbf877062227828ccca63d36af04a16789f3f1013e0c99f6dfd908bf5f2dbe43
MCHS_PKG_DEPENDS="libandroid-glob, libandroid-support"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-shared --enable-static"

mchs_step_pre_configure() {
  MCHS_PKG_SRCDIR="${MCHS_PKG_SRCDIR}/Project/GNU/Library"
  MCHS_PKG_BUILDDIR="${MCHS_PKG_SRCDIR}"
  cd "${MCHS_PKG_SRCDIR}" || return
  ./autogen.sh
}

mchs_step_post_make_install() {
  ln -sf "${MCHS_PREFIX}/lib/libzen.so" "${MCHS_PREFIX}/lib/libzen.so.${MCHS_PKG_VERSION:0:1}"
  ln -sf "${MCHS_PREFIX}/lib/libzen.so" "${MCHS_PREFIX}/lib/libzen.so.${MCHS_PKG_VERSION}"
}

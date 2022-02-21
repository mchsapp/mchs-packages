MCHS_PKG_HOMEPAGE=https://mediaarea.net/en/MediaInfo
MCHS_PKG_DESCRIPTION="Command-line utility for reading information from media files"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_LICENSE_FILE="../../../LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=21.09
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://mediaarea.net/download/source/mediainfo/${MCHS_PKG_VERSION}/mediainfo_${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=7b8fd9a502ec64afe1315072881b6385ba57ca69f2f82c625b1672e151c50c57
MCHS_PKG_DEPENDS="libandroid-support, libmediainfo"

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR="${MCHS_PKG_SRCDIR}/Project/GNU/CLI"
	MCHS_PKG_BUILDDIR="${MCHS_PKG_SRCDIR}"
	cd "${MCHS_PKG_SRCDIR}"
	./autogen.sh

	LDFLAGS+=" -Wl,--no-as-needed,-landroid-support,--as-needed"
}

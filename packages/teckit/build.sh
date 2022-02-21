MCHS_PKG_HOMEPAGE=https://scripts.sil.org/teckitdownloads
MCHS_PKG_DESCRIPTION="TECkit is a library for encoding conversion"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=2.5.11
MCHS_PKG_SRCURL=https://github.com/silnrsi/teckit/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=54084e84fc4eb406f1d849f11ba5ba0913b1453c4d16b9946590931723a6297c
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, zlib"
MCHS_PKG_BREAKS="teckit-dev"
MCHS_PKG_REPLACES="teckit-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_expat_XML_ExpatVersion=no"

mchs_step_pre_configure() {
	./autogen.sh
}

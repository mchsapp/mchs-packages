MCHS_PKG_HOMEPAGE=http://www.leptonica.com/
MCHS_PKG_DESCRIPTION="Library for image processing and image analysis"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_LICENSE_FILE="leptonica-license.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.82.0
MCHS_PKG_SRCURL=https://github.com/DanBloomberg/leptonica/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=40fa9ac1e815b91e0fa73f0737e60c9eec433a95fa123f95f2573dd3127dd669
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="giflib, libjpeg-turbo, libpng, libtiff, libwebp, openjpeg, zlib"
MCHS_PKG_BREAKS="leptonica-dev"
MCHS_PKG_REPLACES="leptonica-dev"

mchs_step_pre_configure() {
	./autogen.sh
}

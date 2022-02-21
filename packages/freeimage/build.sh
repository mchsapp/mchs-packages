MCHS_PKG_HOMEPAGE="https://freeimage.sourceforge.io"
MCHS_PKG_DESCRIPTION="The library project for developers who would like to support popular graphics image formats."
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="license-fi.txt, license-gplv2.txt, license-gplv3.txt, license-bsd-2-clause.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.18.0
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL="https://downloads.sourceforge.net/project/freeimage/Source%20Distribution/${MCHS_PKG_VERSION}/FreeImage${MCHS_PKG_VERSION//./}.zip"
MCHS_PKG_SHA256=f41379682f9ada94ea7b34fe86bf9ee00935a3147be41b6569c9605a53e438fd
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	cp -f "${MCHS_PKG_BUILDER_DIR}/license-bsd-2-clause.txt" "${MCHS_PKG_SRCDIR}"

	if [ "${MCHS_ARCH}" = "aarch64" ] || [ "${MCHS_ARCH}" = "arm" ]; then
		CFLAGS+=" -DPNG_ARM_NEON_OPT=0"
	fi

}

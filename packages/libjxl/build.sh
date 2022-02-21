MCHS_PKG_HOMEPAGE=https://jpegxl.info/
MCHS_PKG_DESCRIPTION="JPEG XL image format reference implementation"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6.1
MCHS_PKG_SRCURL=https://github.com/libjxl/libjxl/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ccbd5a729d730152303be399f033b905e608309d5802d77a61a95faa092592c5
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS=brotli

mchs_step_post_get_source() {
	./deps.sh
}

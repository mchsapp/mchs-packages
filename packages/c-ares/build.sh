MCHS_PKG_HOMEPAGE=https://c-ares.haxx.se
MCHS_PKG_DESCRIPTION="Library for asynchronous DNS requests (including name resolves)"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.18.1
MCHS_PKG_SRCURL=https://github.com/c-ares/c-ares/archive/cares-${MCHS_PKG_VERSION//./_}.tar.gz
MCHS_PKG_SHA256=414872549eec4e221b576693fdc9c9bce44ff794d0f1f06f2515b56a7f6ec9c9
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+.\d+.\d+"
MCHS_PKG_BREAKS="c-ares-dev"
MCHS_PKG_REPLACES="c-ares-dev"
# Build with cmake to install cmake/c-ares/*.cmake files:
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_RM_AFTER_INSTALL="bin/"

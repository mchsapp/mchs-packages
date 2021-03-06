MCHS_PKG_HOMEPAGE=https://github.com/apple/swift-corelibs-libdispatch
MCHS_PKG_DESCRIPTION="The libdispatch project, for concurrency on multicore hardware"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@buttaface"
_VERSION=5.5
MCHS_PKG_VERSION=1:${_VERSION}
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/apple/swift-corelibs-libdispatch/archive/swift-${_VERSION}-RELEASE.tar.gz
MCHS_PKG_SHA256=5efdfa1d2897c598acea42fc00776477bb3713645686774f5ff0818b26649e62
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+"
MCHS_PKG_DEPENDS="libc++, libblocksruntime"

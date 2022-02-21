MCHS_PKG_HOMEPAGE=https://pocoproject.org/
MCHS_PKG_DESCRIPTION="A comprehensive set of C++ libraries that cover all modern-day programming needs"
MCHS_PKG_LICENSE="BSL-1.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.11.1
MCHS_PKG_SRCURL=https://github.com/pocoproject/poco/archive/refs/tags/poco-${MCHS_PKG_VERSION}-release.tar.gz
MCHS_PKG_SHA256=2412a5819a239ff2ee58f81033bcc39c40460d7a8b330013a687c8c0bd2b4ac0
MCHS_PKG_DEPENDS="libc++, libexpat, openssl, pcre, sqlite, zlib"
MCHS_PKG_FORCE_CMAKE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DPOCO_UNBUNDLED=ON"

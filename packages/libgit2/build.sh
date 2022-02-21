MCHS_PKG_HOMEPAGE=https://libgit2.github.com/
MCHS_PKG_DESCRIPTION="C library implementing Git core methods"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.0
MCHS_PKG_SRCURL=https://github.com/libgit2/libgit2/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=192eeff84596ff09efb6b01835a066f2df7cd7985e0991c79595688e6b36444e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libcurl, openssl, libssh2, zlib, libiconv"
MCHS_PKG_BREAKS="libgit2-dev"
MCHS_PKG_REPLACES="libgit2-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_CLAR=OFF"

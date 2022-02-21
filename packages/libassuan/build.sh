MCHS_PKG_HOMEPAGE=https://www.gnupg.org/related_software/libassuan/
MCHS_PKG_DESCRIPTION="Library implementing the Assuan IPC protocol used between most newer GnuPG components"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.5.5
MCHS_PKG_SRCURL=https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=8e8c2fcc982f9ca67dcbb1d95e2dc746b1739a4668bc20b3a3c5be632edb34e4
MCHS_PKG_DEPENDS="libgpg-error"
MCHS_PKG_BREAKS="libassuan-dev"
MCHS_PKG_REPLACES="libassuan-dev"

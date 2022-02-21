MCHS_PKG_HOMEPAGE=http://savannah.nongnu.org/projects/attr/
MCHS_PKG_DESCRIPTION="Utilities for manipulating filesystem extended attributes"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.5.1
MCHS_PKG_SRCURL=http://download.savannah.gnu.org/releases/attr/attr-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bae1c6949b258a0d68001367ce0c741cebdacdd3b62965d17e5eb23cd78adaf8
MCHS_PKG_BREAKS="attr-dev"
MCHS_PKG_REPLACES="attr-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-gettext=no"
# MCHS_PKG_MAKE_INSTALL_TARGET="install install-lib"
# attr.5 man page is in manpages:
MCHS_PKG_RM_AFTER_INSTALL="share/man/man5/attr.5"

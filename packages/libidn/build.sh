MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/libidn/
MCHS_PKG_DESCRIPTION="GNU Libidn library, implementation of IETF IDN specifications"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.38
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/libidn/libidn-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=de00b840f757cd3bb14dd9a20d5936473235ddcba06d4bc2da804654b8bbf0f6
MCHS_PKG_DEPENDS="libiconv"
MCHS_PKG_BREAKS="libidn-dev"
MCHS_PKG_REPLACES="libidn-dev"

# Remove the idn tool for now, add it as subpackage if desired::
MCHS_PKG_RM_AFTER_INSTALL="bin/idn share/man/man1/idn.1 share/emacs"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-ld-version-script"

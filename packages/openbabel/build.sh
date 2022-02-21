MCHS_PKG_HOMEPAGE=http://openbabel.org/wiki/Main_Page
MCHS_PKG_DESCRIPTION="Open Babel is a chemical toolbox designed to speak the many languages of chemical data"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1.1
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://github.com/openbabel/openbabel/archive/openbabel-${MCHS_PKG_VERSION//./-}.tar.gz
MCHS_PKG_SHA256=c97023ac6300d26176c97d4ef39957f06e68848d64f1a04b0b284ccff2744f02
MCHS_PKG_DEPENDS="libc++, libcairo, libxml2, eigen, boost"
MCHS_PKG_BREAKS="openbabel-dev"
MCHS_PKG_REPLACES="openbabel-dev"
MCHS_PKG_GROUPS="science"
# MAEPARSER gives an error related to boost's unit_test_framework during configure
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_MAEPARSER=off -DWITH_COORDGEN=off"

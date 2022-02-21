MCHS_PKG_HOMEPAGE=https://sleuthkit.org/
MCHS_PKG_DESCRIPTION="The Sleuth Kit® (TSK) is a library for digital forensics tools. "
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="licenses/README.md, licenses/GNUv2-COPYING, licenses/GNUv3-COPYING, licenses/IBM-LICENSE, licenses/Apache-LICENSE-2.0.txt, licenses/cpl1.0.txt, licenses/bsd.txt, licenses/mit.txt"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.11.1
MCHS_PKG_SRCURL=https://github.com/sleuthkit/sleuthkit/archive/sleuthkit-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=81432c57458e9369dbdfbade096f8e779b0f169683a833675e787c34014d4d3f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_DEPENDS="libsqlite, ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-java"

mchs_step_pre_configure() {
	./bootstrap
}

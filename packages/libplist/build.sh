MCHS_PKG_HOMEPAGE=https://libimobiledevice.org
MCHS_PKG_DESCRIPTION="A small portable C library to handle Apple Property List files in binary or XML format."
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_LICENSE_FILE="COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2.0
MCHS_PKG_SRCURL=https://github.com/libimobiledevice/libplist/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=7e654bdd5d8b96f03240227ed09057377f06ebad08e1c37d0cfa2abe6ba0cee2
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
        PKG_CONFIG_PATH=$MCHS_PREFIX/lib/pkgconfig
        ./autogen.sh --prefix=$MCHS_PREFIX \
		     --without-cython \
                     --host=$MCHS_HOST_PLATFORM
}


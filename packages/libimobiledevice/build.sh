MCHS_PKG_HOMEPAGE=https://libimobiledevice.org/
MCHS_PKG_DESCRIPTION="A library to communicate with services on iOS devices using native protocols."
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_LICENSE_FILE="COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.0
MCHS_PKG_SRCURL=https://github.com/libimobiledevice/libimobiledevice/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=acbfb73eabee162e64c0d9de207d71c0a5f47c40cd5ad32a5097f734328ce10a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="usbmuxd, libusbmuxd, openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
        ./autogen.sh --prefix=$MCHS_PREFIX \
		     --host=$MCHS_HOST_PLATFORM
}

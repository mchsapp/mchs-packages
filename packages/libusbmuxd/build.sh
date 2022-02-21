MCHS_PKG_HOMEPAGE=https://libimobiledevice.org
MCHS_PKG_DESCRIPTION="A client library for applications to handle usbmux protocol connections with iOS devices."
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_LICENSE_FILE="COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.2
MCHS_PKG_SRCURL=https://github.com/libimobiledevice/libusbmuxd/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=8ae3e1d9340177f8f3a785be276435869363de79f491d05d8a84a59efc8a8fdc
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libusb, libplist, usbmuxd"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
        ./autogen.sh --prefix=$MCHS_PREFIX \
		     --without-preflight \
		     --without-systemd \
		     --host=$MCHS_HOST_PLATFORM
}

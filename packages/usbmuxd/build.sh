MCHS_PKG_HOMEPAGE=https://libimobiledevice.org
MCHS_PKG_DESCRIPTION="A socket daemon to multiplex connections from and to iOS devices."
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="COPYING.GPLv2, COPYING.GPLv3"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.1.1
MCHS_PKG_SRCURL=https://github.com/libimobiledevice/usbmuxd/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=e7ce30143e69d77fc5aa6fb0cb5f0cfcdbeff47eb1ac7fd90ac259a90de9fadd
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libusb, libplist"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
        ./autogen.sh --prefix=$MCHS_PREFIX \
		     --without-preflight \
		     --without-systemd \
		     --host=$MCHS_HOST_PLATFORM
}

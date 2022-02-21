MCHS_PKG_HOMEPAGE=https://libusb.info/
MCHS_PKG_DESCRIPTION="A C library that provides generic access to USB devices"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.25
MCHS_PKG_SRCURL=https://github.com/libusb/libusb/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f9c4b7dad27a6196ca9ec3c6ec7fa446194342de326c71e030eb2c480895e169
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="libusb-dev"
MCHS_PKG_REPLACES="libusb-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-udev"

mchs_step_pre_configure() {
	NOCONFIGURE=true ./autogen.sh
}

MCHS_PKG_HOMEPAGE=https://developer.android.com/
MCHS_PKG_DESCRIPTION="Android platform tools"
MCHS_PKG_LICENSE="Apache-2.0, MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=31.0.3
MCHS_PKG_SRCURL=https://github.com/nmeum/android-tools/releases/download/$MCHS_PKG_VERSION/android-tools-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=d7d2d945b6e1a7ba0c7d0b68a6d21ada6914155bf3ca02ff06c9db628ae6b029
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++, libusb, pcre2, googletest, libprotobuf, brotli, zstd, liblz4"

mchs_step_pre_configure() {
	mchs_setup_protobuf
	mchs_setup_golang
}

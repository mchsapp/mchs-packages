MCHS_PKG_HOMEPAGE=https://github.com/espeak-ng/pcaudiolib
MCHS_PKG_DESCRIPTION="Portable C Audio Library"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2
MCHS_PKG_SRCURL=https://github.com/espeak-ng/pcaudiolib/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=44b9d509b9eac40a0c61585f756d76a7b555f732e8b8ae4a501c8819c59c6619
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="pulseaudio"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	./autogen.sh
}

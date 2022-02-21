MCHS_PKG_HOMEPAGE="https://www.videolan.org/developers/libdvbcsa.html"
MCHS_PKG_DESCRIPTION="An implementation of the DVB Common Scrambling Algorithm - DVB/CSA - with encryption and decryption capabilities"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="MrAdityaAlok <dev.aditya.alok@gmail.com>"
MCHS_PKG_VERSION=1.1.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL="https://download.videolan.org/pub/videolan/libdvbcsa/${MCHS_PKG_VERSION}/libdvbcsa-${MCHS_PKG_VERSION}.tar.gz"
MCHS_PKG_SHA256=4db78af5cdb2641dfb1136fe3531960a477c9e3e3b6ba19a2754d046af3f456d
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure(){
	autoreconf -fvi
}

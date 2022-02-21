MCHS_PKG_HOMEPAGE=https://github.com/strukturag/libde265
MCHS_PKG_DESCRIPTION="H.265/HEVC video stream decoder library"
MCHS_PKG_LICENSE="LGPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.8
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/strukturag/libde265/releases/download/v$MCHS_PKG_VERSION/libde265-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=24c791dd334fa521762320ff54f0febfd3c09fc978880a8c5fbc40a88f21d905
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-sherlock265 --disable-arm --disable-encoder"

mchs_step_pre_configure() {
    autoreconf -fi
}

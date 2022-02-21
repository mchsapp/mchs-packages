MCHS_PKG_HOMEPAGE=https://github.com/signalapp/libsignal-protocol-c
MCHS_PKG_DESCRIPTION="Signal Protocol C Library"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_VERSION=2.3.3
MCHS_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MCHS_PKG_SRCURL=https://github.com/signalapp/libsignal-protocol-c/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c22e7690546e24d46210ca92dd808f17c3102e1344cd2f9a370136a96d22319d
MCHS_PKG_DEPENDS="openssl"

mchs_step_pre_configure() {
    MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DBUILD_SHARED_LIBS=ON"
    MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DM_LIB=$MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/libm.so"
}

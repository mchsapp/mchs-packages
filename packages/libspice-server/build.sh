MCHS_PKG_HOMEPAGE=https://www.spice-space.org/
MCHS_PKG_DESCRIPTION="Implements the server side of the SPICE protocol"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.15.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://www.spice-space.org/download/releases/spice-server/spice-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=b320cf8f4bd2852750acb703c15b72856027e5a8554f8217dfbb3cc09deba0f5
MCHS_PKG_DEPENDS="glib, libjpeg-turbo, gstreamer, gst-plugins-base, libsasl, libspice-protocol, liborc, openssl, libopus, libpixman, liblz4, zlib, libiconv"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-manual=no
--disable-tests
"
mchs_step_post_make_install() {
        ln -sfr "${MCHS_PREFIX}"/lib/libspice-server.so \
                "${MCHS_PREFIX}"/lib/libspice-server.so.1
}

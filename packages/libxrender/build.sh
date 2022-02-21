# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X Rendering Extension client library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.10
MCHS_PKG_REVISION=14
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXrender-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=c06d5979f86e64cabbde57c223938db0b939dff49fdb5a793a1d3d0396650949
MCHS_PKG_DEPENDS="libx11"
MCHS_PKG_BUILD_DEPENDS="xorgproto"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"

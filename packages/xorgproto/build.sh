# X11 package
MCHS_PKG_HOMEPAGE=https://xorg.freedesktop.org/
MCHS_PKG_DESCRIPTION="X.Org X11 Protocol headers"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="COPYING-bigreqsproto, COPYING-compositeproto, COPYING-damageproto, COPYING-dmxproto, COPYING-dri2proto, COPYING-dri3proto, COPYING-evieproto, COPYING-fixesproto, COPYING-fontcacheproto, COPYING-fontsproto, COPYING-glproto, COPYING-inputproto, COPYING-kbproto, COPYING-lg3dproto, COPYING-pmproto, COPYING-presentproto, COPYING-printproto, COPYING-randrproto, COPYING-recordproto, COPYING-renderproto, COPYING-resourceproto, COPYING-scrnsaverproto, COPYING-trapproto, COPYING-videoproto, COPYING-x11proto, COPYING-xcmiscproto, COPYING-xextproto, COPYING-xf86bigfontproto, COPYING-xf86dgaproto, COPYING-xf86driproto, COPYING-xf86miscproto, COPYING-xf86rushproto, COPYING-xf86vidmodeproto, COPYING-xineramaproto"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2020.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/proto/xorgproto-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=54a153f139035a376c075845dd058049177212da94d7a9707cf9468367b699d2
MCHS_PKG_DEPENDS="xorg-util-macros"
MCHS_PKG_CONFLICTS="x11-proto"
MCHS_PKG_REPLACES="x11-proto"
MCHS_PKG_NO_DEVELSPLIT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Dlegacy=true"

MCHS_PKG_RM_AFTER_INSTALL="
include/X11/extensions/apple*
include/X11/extensions/windows*
include/X11/extensions/XKBgeom.h
lib/pkgconfig/applewmproto.pc
lib/pkgconfig/windowswmproto.pc
"

mchs_step_pre_configure() {
	# Use meson instead of autotools.
	rm -f "$MCHS_PKG_SRCDIR"/configure
}

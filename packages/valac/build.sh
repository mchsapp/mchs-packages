MCHS_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Vala
MCHS_PKG_DESCRIPTION="C# like language for the GObject system"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.52.3
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://download.gnome.org/sources/vala/${MCHS_PKG_VERSION:0:4}/vala-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=037ea1a92bf0f1ab04a71b52a01d50aca1945ad1017b6189d9614f84f5c9b2d9
MCHS_PKG_DEPENDS="clang, glib, pkg-config"
MCHS_PKG_BREAKS="valac-dev"
MCHS_PKG_REPLACES="valac-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-cgraph=no"

mchs_step_post_make_install() {
	cd ${MCHS_PREFIX}/lib
	ln -s -f vala-${MCHS_PKG_VERSION:0:4}/libvalaccodegen.so libvalaccodegen.so
}

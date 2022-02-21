MCHS_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libsecret
MCHS_PKG_DESCRIPTION="A GObject-based library for accessing the Secret Service API"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@suhan-paradkar"
MCHS_PKG_VERSION=0.20.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://gitlab.gnome.org/GNOME/libsecret/-/archive/$MCHS_PKG_VERSION/libsecret-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=ca34e69b210df221ae5da6692c2cb15ef169bb4daf42e204442f24fdb0520d4b
MCHS_PKG_DEPENDS="gobject-introspection, libgcrypt"
MCHS_PKG_EXTRA_CONFIGURE_ARGS+="-Dintrospection=false -Dgtk_doc=false"

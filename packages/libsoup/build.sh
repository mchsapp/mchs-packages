MCHS_PKG_HOMEPAGE=https://wiki.gnome.org/action/show/Projects/libsoup
MCHS_PKG_DESCRIPTION="HTTP client and server library"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.70.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/libsoup/${MCHS_PKG_VERSION:0:4}/libsoup-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=54b020f74aefa438918d8e53cff62e2b1e59efe2de53e06b19a4b07b1f4d5342
MCHS_PKG_DEPENDS="glib, libpsl, libsqlite, libxml2, brotli"
MCHS_PKG_BREAKS="libsoup-dev"
MCHS_PKG_REPLACES="libsoup-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=disabled
-Dvapi=disabled
-Dgssapi=disabled
-Dtls_check=false
"

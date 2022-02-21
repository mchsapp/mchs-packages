MCHS_PKG_HOMEPAGE=http://distcc.org/
MCHS_PKG_DESCRIPTION="Distributed C/C++ compiler."
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.4
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/distcc/distcc/releases/download/v$MCHS_PKG_VERSION/distcc-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=2b99edda9dad9dbf283933a02eace6de7423fe5650daa4a728c950e5cd37bd7d
MCHS_PKG_DEPENDS="libpopt"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pump-mode
--without-avahi
--without-gtk
--without-libiberty"

mchs_step_pre_configure() {
	./autogen.sh
	export LIBS="-llog"
}

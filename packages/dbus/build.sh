MCHS_PKG_HOMEPAGE=https://dbus.freedesktop.org
MCHS_PKG_DESCRIPTION="Freedesktop.org message bus system"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.13.18
MCHS_PKG_SRCURL="https://dbus.freedesktop.org/releases/dbus/dbus-$MCHS_PKG_VERSION.tar.xz"
MCHS_PKG_SHA256=8078f5c25e34ab907ce06905d969dc8ef0ccbec367e1e1707c7ecf8460f4254e
MCHS_PKG_DEPENDS="libexpat, libx11"
MCHS_PKG_BREAKS="dbus-dev"
MCHS_PKG_REPLACES="dbus-dev"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-libaudit
--disable-systemd
--disable-tests
--enable-x11-autolaunch
--with-test-socket-dir=$MCHS_PREFIX/tmp
--with-session-socket-dir=$MCHS_PREFIX/tmp
--with-x
"

mchs_step_pre_configure() {
	export LIBS="-llog"
}

mchs_step_create_debscripts() {
	{
		echo "#!${MCHS_PREFIX}/bin/sh"
		echo "if [ ! -e ${MCHS_PREFIX}/var/lib/dbus/machine-id ]; then"
		echo "mkdir -p ${MCHS_PREFIX}/var/lib/dbus"
		echo "dbus-uuidgen > ${MCHS_PREFIX}/var/lib/dbus/machine-id"
		echo "fi"
		echo "exit 0"
	} > postinst
}

MCHS_PKG_HOMEPAGE=http://packages.debian.org/fakeroot
MCHS_PKG_DESCRIPTION="Tool for simulating superuser privileges (with tcp ipc)"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.25.3
MCHS_PKG_SRCURL=https://deb.debian.org/debian/pool/main/f/fakeroot/fakeroot_${MCHS_PKG_VERSION}.orig.tar.gz
MCHS_PKG_SHA256=8e903683357f7f5bcc31b879fd743391ad47691d4be33d24a76be3b6c21e956c
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-ipc=tcp"
MCHS_PKG_BUILD_DEPENDS="libcap"

mchs_step_pre_configure() {
	autoreconf -vfi
}

mchs_step_post_make_install() {
	ln -sfr "${MCHS_PREFIX}/lib/libfakeroot-0.so" "${MCHS_PREFIX}/lib/libfakeroot.so"
}

mchs_step_create_debscripts() {
	{
		echo "#!$MCHS_PREFIX/bin/sh"
		echo "echo"
		echo "echo Fakeroot does not give you any real root permissions. This utility is primarily intended to be used for development purposes."
		echo "echo More info about usage at https://wiki.debian.org/FakeRoot."
		echo "echo"
		echo "echo Programs requiring real root permissions will not run under fakeroot. Do not post bug reports about this."
		echo "echo"
	} > ./postinst
}

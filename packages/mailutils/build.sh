MCHS_PKG_HOMEPAGE=https://mailutils.org/
MCHS_PKG_DESCRIPTION="Mailutils is a swiss army knife of electronic mail handling. "
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@suhan-paradkar"
MCHS_PKG_VERSION=3.13
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/mailutils/mailutils-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=d920971dcb49878a009911774fd6404f13d27bd101e2d59b664a28659a4094c7
MCHS_PKG_BUILD_DEPENDS="libandroid-glob, libcrypt"

mchs_step_pre_configure() {
	export LIBS="-landroid-glob"
}

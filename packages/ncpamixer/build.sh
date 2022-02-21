MCHS_PKG_HOMEPAGE=https://github.com/fulhax/ncpamixer
MCHS_PKG_DESCRIPTION="An ncurses mixer for PulseAudio"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_LICENSE_FILE="../LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.3.3.1
MCHS_PKG_SRCURL=https://github.com/fulhax/ncpamixer/archive/refs/tags/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b2c797a90c92aa931052c5ac89a79fbc30f76d5e2a5b773ef68edf057c34b060
MCHS_PKG_DEPENDS="libc++, ncurses-ui-libs, pulseaudio"
MCHS_PKG_BUILD_DEPENDS="libandroid-wordexp"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DUSE_WIDE=ON"

mchs_step_pre_configure() {
	MCHS_PKG_SRCDIR+="/src"
}

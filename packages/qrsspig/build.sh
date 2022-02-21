MCHS_PKG_HOMEPAGE=https://gitlab.com/hb9fxx/qrsspig
MCHS_PKG_DESCRIPTION="Headless QRSS grabber for Raspberry Pi's"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://gitlab.com/hb9fxx/qrsspig/-/archive/v${MCHS_PKG_VERSION}/qrsspig-v${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=4bf0ad0fb9351587ac9bec87d8977d210dad670e32a8fdb62b1dac7b133d79c2
MCHS_PKG_DEPENDS="boost, fftw, libc++, libcurl, libgd, libliquid-dsp, libssh, libyaml-cpp, pulseaudio"
MCHS_PKG_RM_AFTER_INSTALL="lib/systemd"

mchs_step_pre_configure() {
	_NEED_DUMMY_LIBPTHREAD_A=
	_LIBPTHREAD_A=$MCHS_PREFIX/lib/libpthread.a
	if [ ! -e $_LIBPTHREAD_A ]; then
		_NEED_DUMMY_LIBPTHREAD_A=true
		echo '!<arch>' > $_LIBPTHREAD_A
	fi
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBPTHREAD_A ]; then
		rm -f $_LIBPTHREAD_A
	fi
}

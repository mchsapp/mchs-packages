MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/screen/
MCHS_PKG_DESCRIPTION="Terminal multiplexer with VT100/ANSI terminal emulation"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.8.0
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/screen/screen-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6e11b13d8489925fde25dfb0935bf6ed71f9eb47eff233a181e078fde5655aa1
MCHS_PKG_DEPENDS="ncurses, libcrypt"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-socket-dir
--enable-colors256
--with-ssl=openssl
"

mchs_step_pre_configure() {
	# Run autoreconf since we have patched configure.ac
	autoconf
	CFLAGS+=" -DGETUTENT"
	export LIBS="-lcrypt"
}

mchs_step_post_configure() {
	echo '#define HAVE_SVR4_PTYS 1' >> $MCHS_PKG_BUILDDIR/config.h
	echo 'mousetrack on' > "$MCHS_PREFIX/etc/screenrc"
}

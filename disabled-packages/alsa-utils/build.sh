MCHS_PKG_HOMEPAGE=http://www.alsa-project.org
MCHS_PKG_VERSION=1.1.3
MCHS_PKG_SRCURL=ftp://ftp.alsa-project.org/pub/utils/alsa-utils-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=127217a54eea0f9a49700a2f239a2d4f5384aa094d68df04a8eb80132eb6167c
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-udev-rules-dir=$MCHS_PREFIX/lib/udev/rules.d --with-asound-state-dir=$MCHS_PREFIX/var/lib/alsa --disable-bat --disable-rst2man"

mchs_step_pre_configure() {
    LDFLAGS+=" -llog"
}

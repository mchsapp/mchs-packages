MCHS_PKG_HOMEPAGE=http://www.alsa-project.org
MCHS_PKG_VERSION=1.1.1
MCHS_PKG_SRCURL=ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=8ea4d1e082c36528a896a2581e5eb62d4dc2683238e353050d0d624e65f901f1
MCHS_PKG_DEPENDS="pulseaudio"
MCHS_PKG_EXTRA_MAKE_ARGS='SUBDIRS=pulse'

mchs_step_post_make_install() {
    cp $MCHS_PKG_BUILDER_DIR/asound.conf $MCHS_PREFIX/etc
}

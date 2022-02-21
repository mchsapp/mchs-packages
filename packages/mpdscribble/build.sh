MCHS_PKG_HOMEPAGE=https://www.musicpd.org/clients/mpdscribble/
MCHS_PKG_DESCRIPTION="A Music Player Daemon (MPD) client which submits information about tracks being played to a scrobbler"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=0.23
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://github.com/MusicPlayerDaemon/mpdscribble/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8b3b79538fa9871ce61d7fb793d442c72b6aadf80af4c5eb664286f613d1feee
MCHS_PKG_DEPENDS="libcurl, libgcrypt, mpd, libmpdclient, glib"
MCHS_PKG_BUILD_DEPENDS="boost"
MCHS_PKG_CONFFILES="etc/mpdscribble.conf"
# mpdscribble already puts timestamps in the info printed to stdout so no need for svlogd -tt,
# therefore we override the mpdscribble/log run script
MCHS_PKG_SERVICE_SCRIPT=(
	"mpdscribble" "if [ -f \"$MCHS_ANDROID_HOME/.mpdscribble/mpdscribble.conf\" ]; then CONFIG=\"$MCHS_ANDROID_HOME/.mpdscribble/mpdscribble.conf\"; else CONFIG=\"$MCHS_PREFIX/etc/mpdscribble.conf\"; fi\nexec mpdscribble -D --log /proc/self/fd/1 --conf \$CONFIG"
	"mpdscribble/log" 'mkdir -p "$LOGDIR/sv/mpdscribble"\nexec svlogd "$LOGDIR/sv/mpdscribble"'
)

mchs_step_pre_configure() {
	export BOOST_ROOT=$MCHS_PREFIX
}

mchs_step_post_make_install () {
	install $MCHS_PKG_SRCDIR/doc/mpdscribble.conf $MCHS_PREFIX/etc/
}

mchs_step_create_debscripts () {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "mkdir -p ~/.mpdscribble" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

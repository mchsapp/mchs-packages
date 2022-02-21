MCHS_PKG_HOMEPAGE=https://www.musicpd.org
MCHS_PKG_DESCRIPTION="Music player daemon"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.23.5
MCHS_PKG_SRCURL=https://github.com/MusicPlayerDaemon/MPD/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=d57aec9100539dc6bdb8b06d40114e44d765481bee6bc900d6403e7b67dc8e92
MCHS_PKG_DEPENDS="libc++, libcurl, libexpat, libid3tag, libopus, pulseaudio, libmpdclient, openal-soft, libvorbis, libsqlite, ffmpeg, libmp3lame, libbz2, libogg, libnfs, zlib"
MCHS_PKG_BUILD_DEPENDS="boost"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-Dalsa=disabled
-Dao=disabled
-Depoll=false
-Diconv=disabled
-Dicu=disabled
-Dmad=disabled
-Dpcre=disabled
-Dsndio=disabled
"
MCHS_PKG_CONFFILES="etc/mpd.conf"
MCHS_PKG_SERVICE_SCRIPT=("mpd" "if [ -f \"$MCHS_ANDROID_HOME/.mpd/mpd.conf\" ]; then CONFIG=\"$MCHS_ANDROID_HOME/.mpd/mpd.conf\"; else CONFIG=\"$MCHS_PREFIX/etc/mpd.conf\"; fi\nexec mpd --stdout --no-daemon \$CONFIG 2>&1")

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	CXXFLAGS+=" -DMCHS -UANDROID"
	LDFLAGS+=" -lOpenSLES"
	rm -f $MCHS_PREFIX/etc/mpd.conf

	export BOOST_ROOT=$MCHS_PREFIX
}

mchs_step_post_make_install() {
	install -Dm600 $MCHS_PKG_SRCDIR/doc/mpdconf.example $MCHS_PREFIX/etc/mpd.conf
}

mchs_step_create_debscripts() {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo 'mkdir -p $HOME/.mpd/playlists' >> postinst
}

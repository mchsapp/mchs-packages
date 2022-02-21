MCHS_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/PulseAudio
MCHS_PKG_DESCRIPTION="A featureful, general-purpose sound server"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_SRCURL=https://github.com/pulseaudio/pulseaudio.git
MCHS_PKG_VERSION=14.2
MCHS_PKG_REVISION=6
MCHS_PKG_DEPENDS="libltdl, libsndfile, libandroid-glob, libsoxr, speexdsp, libwebrtc-audio-processing"
MCHS_PKG_BREAKS="libpulseaudio-dev, libpulseaudio"
MCHS_PKG_REPLACES="libpulseaudio-dev, libpulseaudio"
# glib is only a runtime dependency of pulseaudio-glib subpackage
MCHS_PKG_BUILD_DEPENDS="libtool, glib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-neon-opt
--disable-alsa
--disable-esound
--disable-x11
--disable-gtk3
--disable-openssl
--enable-glib2
--without-caps
--with-database=simple
--disable-memfd
--disable-gsettings
ax_cv_PTHREAD_PRIO_INHERIT=no"
MCHS_PKG_CONFFILES="etc/pulse/client.conf etc/pulse/daemon.conf etc/pulse/default.pa etc/pulse/system.pa"

mchs_step_post_get_source() {
	NOCONFIGURE=1 ./bootstrap.sh
}

mchs_step_pre_configure() {
	# Our aaudio sink module needs libaaudio.so from a later android api version:
	local _ANDROID=""
	if [ "$MCHS_ARCH" = "arm" ]; then
		_ANDROID="eabi"
	fi
	mkdir $MCHS_PKG_TMPDIR/libaaudio
	cp $NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$MCHS_ARCH-linux-android$_ANDROID/26/libaaudio.so \
		$MCHS_PKG_TMPDIR/libaaudio/
	LDFLAGS+=" -L$MCHS_PKG_TMPDIR/libaaudio/"

	mkdir $MCHS_PKG_SRCDIR/src/modules/sles
	cp $MCHS_PKG_BUILDER_DIR/module-sles-sink.c $MCHS_PKG_SRCDIR/src/modules/sles
	cp $MCHS_PKG_BUILDER_DIR/module-sles-source.c $MCHS_PKG_SRCDIR/src/modules/sles
	mkdir $MCHS_PKG_SRCDIR/src/modules/aaudio
	cp $MCHS_PKG_BUILDER_DIR/module-aaudio-sink.c $MCHS_PKG_SRCDIR/src/modules/aaudio

	export LIBS="-landroid-glob"
}

mchs_step_post_make_install() {
	# Some binaries link against these:
	cd $MCHS_PREFIX/lib
	for lib in pulseaudio/lib*.so* pulse-${MCHS_PKG_VERSION}/modules/lib*.so*; do
		ln -s -f $lib $(basename $lib)
	done

	# Pulseaudio fails to start when it cannot detect any sound hardware
	# so disable hardware detection.
	sed -i $MCHS_PREFIX/etc/pulse/default.pa \
		-e '/^load-module module-detect$/s/^/#/'
	echo "load-module module-sles-sink" >> $MCHS_PREFIX/etc/pulse/default.pa
	echo "#load-module module-aaudio-sink" >> $MCHS_PREFIX/etc/pulse/default.pa
}

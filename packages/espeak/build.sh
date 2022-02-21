MCHS_PKG_HOMEPAGE=https://github.com/espeak-ng/espeak-ng
MCHS_PKG_DESCRIPTION="Compact software speech synthesizer"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
# Use eSpeak NG as the original eSpeak project is dead.
# See https://github.com/espeak-ng/espeak-ng/issues/180
# about cross compilation of espeak-ng.
MCHS_PKG_VERSION=1.50
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/espeak-ng/espeak-ng/releases/download/$MCHS_PKG_VERSION/espeak-ng-$MCHS_PKG_VERSION.tgz
MCHS_PKG_SHA256=80ee6cd06fcd61888951ab49362b400e80dd1fac352a8b1131d90cfe8a210edb
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="pcaudiolib"
MCHS_PKG_BREAKS="espeak-dev"
MCHS_PKG_REPLACES="espeak-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_RM_AFTER_INSTALL="lib/*ng-test*"
# --without-async due to that using pthread_cancel().
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-async --with-pcaudiolib"

mchs_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	./autogen.sh
}

mchs_step_host_build() {
	cp -Rf $MCHS_PKG_SRCDIR/* .
	unset MAKEFLAGS
	./configure --prefix=$MCHS_PREFIX
	make -j$MCHS_MAKE_PROCESSES src/{e,}speak-ng

	# Man pages require the ronn ruby program.
	#make src/espeak-ng.1
	#cp src/espeak-ng.1 $MCHS_PREFIX/share/man/man1
	#(cd $MCHS_PREFIX/share/man/man1 && ln -s -f espeak-ng.1 espeak.1)

	make install
}

mchs_step_pre_configure() {
	# Oz flag causes problems. See https://github.com/mchs/mchs-packages/issues/1680:
	CFLAGS=${CFLAGS/Oz/Os}
}

mchs_step_make() {
	# Prevent caching of host build:
	rm -Rf $MCHS_PKG_HOSTBUILD_DIR
	make -j$MCHS_MAKE_PROCESSES src/{e,}speak-ng
}

mchs_step_make_install() {
	rm $MCHS_PREFIX/bin/{e,}speak{,-ng}
	cp src/.libs/espeak-ng $MCHS_PREFIX/bin/espeak
	cp src/.libs/libespeak-ng.so $MCHS_PREFIX/lib/libespeak-ng.so.1.1.49
}

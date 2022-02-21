MCHS_PKG_HOMEPAGE=https://www.perl.org/
MCHS_PKG_DESCRIPTION="Capable, feature-rich programming language"
MCHS_PKG_LICENSE="Artistic-License-2.0"
MCHS_PKG_MAINTAINER="@mchs"
# Packages which should be rebuilt after version change:
# - exiftool
# - irssi
# - libapt-pkg-perl
# - libregexp-assemble-perl
# - psutils
# - subversion
MCHS_PKG_VERSION=(5.34.0
                    1.3.6)
MCHS_PKG_REVISION=3
MCHS_PKG_SHA256=(551efc818b968b05216024fb0b727ef2ad4c100f8cb6b43fab615fa78ae5be9a
                   4010f41870d64e3957b4b8ce70ebba10a7c4a3e86c5551acb4099c3fcbb37ce5)
MCHS_PKG_SRCURL=(http://www.cpan.org/src/5.0/perl-${MCHS_PKG_VERSION}.tar.gz
		   https://github.com/arsv/perl-cross/releases/download/${MCHS_PKG_VERSION[1]}/perl-cross-${MCHS_PKG_VERSION[1]}.tar.gz)
MCHS_PKG_BUILD_IN_SRC=true
MCHS_MAKE_PROCESSES=1
MCHS_PKG_RM_AFTER_INSTALL="bin/perl${MCHS_PKG_VERSION}"

mchs_step_post_get_source() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

	# This port uses perl-cross: http://arsv.github.io/perl-cross/
	cp -rf perl-cross-${MCHS_PKG_VERSION[1]}/* .

	# Remove old installation to force fresh:
	rm -rf $MCHS_PREFIX/lib/perl5
	rm -f $MCHS_PREFIX/lib/libperl.so
	rm -f $MCHS_PREFIX/include/perl
}

mchs_step_configure() {
	export PATH=$PATH:$MCHS_STANDALONE_TOOLCHAIN/bin

	# Since we specify $MCHS_PREFIX/bin/sh below for the shell
	# it will be run during the build, so temporarily (removed in
	# mchs_step_post_make_install below) setup symlink:
	rm -f $MCHS_PREFIX/bin/sh
	ln -s /bin/sh $MCHS_PREFIX/bin/sh

	(
		ORIG_AR=$AR; unset AR
		ORIG_AS=$AS; unset AS
		ORIG_CC=$CC; unset CC
		ORIG_CXX=$CXX; unset CXX
		ORIG_CPP=$CPP; unset CPP
		ORIG_CFLAGS=$CFLAGS; unset CFLAGS
		ORIG_CPPFLAGS=$CPPFLAGS; unset CPPFLAGS
		ORIG_CXXFLAGS=$CXXFLAGS; unset CXXFLAGS
		ORIG_LDFLAGS=$LDFLAGS; unset LDFLAGS
		ORIG_RANLIB=$RANLIB; unset RANLIB
		ORIG_LD=$LD; unset LD

		cd $MCHS_PKG_BUILDDIR
		$MCHS_PKG_SRCDIR/configure \
			--target=$MCHS_HOST_PLATFORM \
			-Dosname=android \
			-Dsysroot=$MCHS_STANDALONE_TOOLCHAIN/sysroot \
			-Dprefix=$MCHS_PREFIX \
			-Dsh=$MCHS_PREFIX/bin/sh \
			-Dcc="$ORIG_CC" \
			-Dld="$ORIG_CC -Wl,-rpath=$MCHS_PREFIX/lib -Wl,--enable-new-dtags" \
			-Dar="$ORIG_AR" \
			-Duseshrplib \
			-Dusethreads
	)
}

mchs_step_post_make_install() {
	# Replace hardlinks with symlinks:
	cd $MCHS_PREFIX/share/man/man1
	rm perlbug.1
	ln -s perlthanks.1 perlbug.1

	# Cleanup:
	rm $MCHS_PREFIX/bin/sh

	cd $MCHS_PREFIX/lib
	ln -f -s perl5/${MCHS_PKG_VERSION}/${MCHS_ARCH}-android/CORE/libperl.so libperl.so

	cd $MCHS_PREFIX/include
	ln -f -s ../lib/perl5/${MCHS_PKG_VERSION}/${MCHS_ARCH}-android/CORE perl
	cd ../lib/perl5/${MCHS_PKG_VERSION}/${MCHS_ARCH}-android/
	chmod +w Config_heavy.pl
	sed 's',"--sysroot=$MCHS_STANDALONE_TOOLCHAIN"/sysroot,"-I${MCHS_PREFIX}/include",'g' Config_heavy.pl > Config_heavy.pl.new
	sed 's',"$MCHS_STANDALONE_TOOLCHAIN"/sysroot,"-I${MCHS_PREFIX%%/usr}",'g' Config_heavy.pl.new > Config_heavy.pl
	rm Config_heavy.pl.new
}

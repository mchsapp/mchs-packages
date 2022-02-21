mchs_step_setup_toolchain() {
	[ "$MCHS_PKG_METAPACKAGE" = "true" ] && return

	export CFLAGS=""
	export CPPFLAGS=""
	export LDFLAGS="-L${MCHS_PREFIX}/lib"

	export AS=$MCHS_HOST_PLATFORM-clang
	export CC=$MCHS_HOST_PLATFORM-clang
	export CXX=$MCHS_HOST_PLATFORM-clang++
	export CPP=$MCHS_HOST_PLATFORM-cpp
	export LD=ld.lld
	export AR=llvm-ar
	export OBJCOPY=llvm-objcopy
	export OBJDUMP=llvm-objdump
	export RANLIB=llvm-ranlib
	export READELF=llvm-readelf
	export STRIP=llvm-strip
	export NM=llvm-nm

	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
		export PATH=$MCHS_STANDALONE_TOOLCHAIN/bin:$PATH
		export CC_FOR_BUILD=gcc
		export PKG_CONFIG=$MCHS_STANDALONE_TOOLCHAIN/bin/pkg-config
		export PKGCONFIG=$PKG_CONFIG
		export CCMCHS_HOST_PLATFORM=$MCHS_HOST_PLATFORM$MCHS_PKG_API_LEVEL
		if [ $MCHS_ARCH = arm ]; then
			CCMCHS_HOST_PLATFORM=armv7a-linux-androideabi$MCHS_PKG_API_LEVEL
		fi
		LDFLAGS+=" -Wl,-rpath=$MCHS_PREFIX/lib"
	else
		export CC_FOR_BUILD=$CC
		# Some build scripts use environment variable 'PKG_CONFIG', so
		# using this for on-device builds too.
		export PKG_CONFIG=pkg-config
	fi
	export PKG_CONFIG_LIBDIR="$MCHS_PKG_CONFIG_LIBDIR"

	if [ "$MCHS_ARCH" = "arm" ]; then
		# https://developer.android.com/ndk/guides/standalone_toolchain.html#abi_compatibility:
		# "We recommend using the -mthumb compiler flag to force the generation of 16-bit Thumb-2 instructions".
		# With r13 of the ndk ruby 2.4.0 segfaults when built on arm with clang without -mthumb.
		CFLAGS+=" -march=armv7-a -mfpu=neon -mfloat-abi=softfp -mthumb"
		LDFLAGS+=" -march=armv7-a"
		export GOARCH=arm
		export GOARM=7
	elif [ "$MCHS_ARCH" = "i686" ]; then
		# From $NDK/docs/CPU-ARCH-ABIS.html:
		CFLAGS+=" -march=i686 -msse3 -mstackrealign -mfpmath=sse"
		# i686 seem to explicitly require -fPIC, see
		# https://github.com/mchs/mchs-packages/issues/7215#issuecomment-906154438
		CFLAGS+=" -fPIC"
		export GOARCH=386
		export GO386=sse2
	elif [ "$MCHS_ARCH" = "aarch64" ]; then
		export GOARCH=arm64
	elif [ "$MCHS_ARCH" = "x86_64" ]; then
		export GOARCH=amd64
	else
		mchs_error_exit "Invalid arch '$MCHS_ARCH' - support arches are 'arm', 'i686', 'aarch64', 'x86_64'"
	fi

	# -static-openmp requires -fopenmp in LDFLAGS to work; hopefully this won't be problematic
	# even when we don't have -fopenmp in CFLAGS / when we don't want to enable OpenMP
	# We might also want to consider shipping libomp.so instead; since r21
	LDFLAGS+=" -fopenmp -static-openmp"

	# Android 7 started to support DT_RUNPATH (but not DT_RPATH).
	LDFLAGS+=" -Wl,--enable-new-dtags"

	# Avoid linking extra (unneeded) libraries.
	LDFLAGS+=" -Wl,--as-needed"

	# Basic hardening.
	CFLAGS+=" -fstack-protector-strong"
	LDFLAGS+=" -Wl,-z,relro,-z,now"

	if [ "$MCHS_DEBUG_BUILD" = "true" ]; then
		CFLAGS+=" -g3 -O1"
		CPPFLAGS+=" -D_FORTIFY_SOURCE=2 -D__USE_FORTIFY_LEVEL=2"
	else
		CFLAGS+=" -Oz"
	fi

	export CXXFLAGS="$CFLAGS"
	export CPPFLAGS+=" -I${MCHS_PREFIX}/include"

	# If libandroid-support is declared as a dependency, link to it explicitly:
	if [ "$MCHS_PKG_DEPENDS" != "${MCHS_PKG_DEPENDS/libandroid-support/}" ]; then
		LDFLAGS+=" -Wl,--no-as-needed,-landroid-support,--as-needed"
	fi

	export GOOS=android
	export CGO_ENABLED=1
	export GO_LDFLAGS="-extldflags=-pie"
	export CGO_LDFLAGS="${LDFLAGS/-Wl,-z,relro,-z,now/}"
	CGO_LDFLAGS="${LDFLAGS/-static-openmp/}"
	export CGO_CFLAGS="-I$MCHS_PREFIX/include"
	export RUSTFLAGS="-C link-arg=-Wl,-rpath=$MCHS_PREFIX/lib -C link-arg=-Wl,--enable-new-dtags"

	export ac_cv_func_getpwent=no
	export ac_cv_func_endpwent=yes
	export ac_cv_func_getpwnam=no
	export ac_cv_func_getpwuid=no
	export ac_cv_func_sigsetmask=no
	export ac_cv_c_bigendian=no

	mchs_setup_standalone_toolchain

	# On Android 7, libutil functionality is provided by libc.
	# But many programs still may search for libutil.
	if [ ! -f $MCHS_PREFIX/lib/libutil.so ]; then
		mkdir -p "$MCHS_PREFIX/lib"
		echo 'INPUT(-lc)' > $MCHS_PREFIX/lib/libutil.so
	fi
}

mchs_setup_standalone_toolchain() {
	if [ "$MCHS_ON_DEVICE_BUILD" = "true" ] || [ -d $MCHS_STANDALONE_TOOLCHAIN ]; then
		return
	fi

	# Do not put toolchain in place until we are done with setup, to avoid having a half setup
	# toolchain left in place if something goes wrong (or process is just aborted):
	local _MCHS_TOOLCHAIN_TMPDIR=${MCHS_STANDALONE_TOOLCHAIN}-tmp
	rm -Rf $_MCHS_TOOLCHAIN_TMPDIR

	local _NDK_ARCHNAME=$MCHS_ARCH
	if [ "$MCHS_ARCH" = "aarch64" ]; then
		_NDK_ARCHNAME=arm64
	elif [ "$MCHS_ARCH" = "i686" ]; then
		_NDK_ARCHNAME=x86
	fi
	cp $NDK/toolchains/llvm/prebuilt/linux-x86_64 $_MCHS_TOOLCHAIN_TMPDIR -r

	# Remove android-support header wrapping not needed on android-21:
	rm -Rf $_MCHS_TOOLCHAIN_TMPDIR/sysroot/usr/local

	for HOST_PLAT in aarch64-linux-android armv7a-linux-androideabi i686-linux-android x86_64-linux-android; do
		cp $_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT$MCHS_PKG_API_LEVEL-clang \
			$_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang
		cp $_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT$MCHS_PKG_API_LEVEL-clang++ \
			$_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang++

		cp $_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT$MCHS_PKG_API_LEVEL-clang \
			$_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-cpp
		sed -i 's/clang/clang -E/' \
			$_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-cpp

		cp $_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang \
			$_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-gcc
		cp $_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-clang++ \
			$_MCHS_TOOLCHAIN_TMPDIR/bin/$HOST_PLAT-g++
	done

	cp $_MCHS_TOOLCHAIN_TMPDIR/bin/armv7a-linux-androideabi$MCHS_PKG_API_LEVEL-clang \
		$_MCHS_TOOLCHAIN_TMPDIR/bin/arm-linux-androideabi-clang
	cp $_MCHS_TOOLCHAIN_TMPDIR/bin/armv7a-linux-androideabi$MCHS_PKG_API_LEVEL-clang++ \
		$_MCHS_TOOLCHAIN_TMPDIR/bin/arm-linux-androideabi-clang++
	cp $_MCHS_TOOLCHAIN_TMPDIR/bin/armv7a-linux-androideabi-cpp \
		$_MCHS_TOOLCHAIN_TMPDIR/bin/arm-linux-androideabi-cpp

	# Create a pkg-config wrapper. We use path to host pkg-config to
	# avoid picking up a cross-compiled pkg-config later on.
	local _HOST_PKGCONFIG
	_HOST_PKGCONFIG=$(command -v pkg-config)
	mkdir -p "$PKG_CONFIG_LIBDIR"
	cat > $_MCHS_TOOLCHAIN_TMPDIR/bin/pkg-config <<-HERE
		#!/bin/sh
		export PKG_CONFIG_DIR=
		export PKG_CONFIG_LIBDIR=$PKG_CONFIG_LIBDIR
		exec $_HOST_PKGCONFIG "\$@"
	HERE
	chmod +x $_MCHS_TOOLCHAIN_TMPDIR/bin/pkg-config

	# Fix broken as symlinks in r23b (which prevents building with
	# the -fno-integrated-as flag)
	for PLATFORM in aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android; do
		unlink $_MCHS_TOOLCHAIN_TMPDIR/$PLATFORM/bin/as
		ln -s ../../bin/$PLATFORM-as $_MCHS_TOOLCHAIN_TMPDIR/$PLATFORM/bin/as
		done

	cd $_MCHS_TOOLCHAIN_TMPDIR/sysroot
	for f in $MCHS_SCRIPTDIR/ndk-patches/*.patch; do
		echo "Applying ndk-patch: $(basename $f)"
		sed "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" "$f" | \
			sed "s%\@MCHS_HOME\@%${MCHS_ANDROID_HOME}%g" | \
			patch --silent -p1;
	done
	# libintl.h: Inline implementation gettext functions.
	# langinfo.h: Inline implementation of nl_langinfo().
	cp "$MCHS_SCRIPTDIR"/ndk-patches/{libintl.h,langinfo.h} usr/include

	# Remove <sys/capability.h> because it is provided by libcap.
	# Remove <sys/shm.h> from the NDK in favour of that from the libandroid-shmem.
	# Remove <sys/sem.h> as it doesn't work for non-root.
	# Remove <glob.h> as we currently provide it from libandroid-glob.
	# Remove <iconv.h> as it's provided by libiconv.
	# Remove <spawn.h> as it's only for future (later than android-27).
	# Remove <zlib.h> and <zconf.h> as we build our own zlib.
	# Remove unicode headers provided by libicu.
	rm usr/include/{sys/{capability,shm,sem},{glob,iconv,spawn,zlib,zconf}}.h
	rm usr/include/unicode/{char16ptr,platform,ptypes,putil,stringoptions,ubidi,ubrk,uchar,uconfig,ucpmap,udisplaycontext,uenum,uldnames,ulocdata,uloc,umachine,unorm2,urename,uscript,ustring,utext,utf16,utf8,utf,utf_old,utypes,uvernum,uversion}.h

	sed -i "s/define __ANDROID_API__ __ANDROID_API_FUTURE__/define __ANDROID_API__ $MCHS_PKG_API_LEVEL/" \
		usr/include/android/api-level.h

	$MCHS_ELF_CLEANER usr/lib/*/*/*.so
	for dir in usr/lib/*; do
		# This seem to be needed when building rust
		# packages
		echo 'INPUT(-lunwind)' > $dir/libgcc.a
	done

	grep -lrw $_MCHS_TOOLCHAIN_TMPDIR/sysroot/usr/include/c++/v1 -e '<version>' | xargs -n 1 sed -i 's/<version>/\"version\"/g'
	mv $_MCHS_TOOLCHAIN_TMPDIR $MCHS_STANDALONE_TOOLCHAIN
}

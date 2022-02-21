MCHS_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
MCHS_PKG_DESCRIPTION="System header and library files from the Android NDK needed for compiling C programs"
MCHS_PKG_LICENSE="NCSA"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=$MCHS_NDK_VERSION
MCHS_PKG_REVISION=4
MCHS_PKG_SKIP_SRC_EXTRACT=true
# This package has taken over <pty.h> from the previous libutil-dev
# and iconv.h from libandroid-support-dev:
MCHS_PKG_CONFLICTS="libutil-dev, libgcc, libandroid-support-dev"
MCHS_PKG_REPLACES="libutil-dev, libgcc, libandroid-support-dev, ndk-stl"
MCHS_PKG_NO_STATICSPLIT=true

mchs_step_extract_into_massagedir() {
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/include

	cp -Rf $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/include/* \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/include

	# replace vulkan headers with upstream version
	rm -rf $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/include/vulkan

	patch -d $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/include/c++/v1  -p1 < $MCHS_PKG_BUILDER_DIR/math-header.diff
	# disable for now
	# patch -d $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/ -p1 < $MCHS_PKG_BUILDER_DIR/gcc_fixes.diff

	cp $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/*.o \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib

	if [ $MCHS_ARCH == "i686" ]; then
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/i386
	elif [ $MCHS_ARCH == "arm64" ]; then
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/aarch64
	else
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/$MCHS_ARCH
	fi

	cp $LIBATOMIC/libatomic.a $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/

	cp $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/libcompiler_rt-extras.a $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/
	# librt and libpthread are built into libc on android, so setup them as symlinks
	# to libc for compatibility with programs that users try to build:
	local _SYSTEM_LIBDIR=/system/lib64
	if [ $MCHS_ARCH_BITS = 32 ]; then _SYSTEM_LIBDIR=/system/lib; fi
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib
	cd $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib
	NDK_ARCH=$MCHS_ARCH
	test $NDK_ARCH == 'i686' && NDK_ARCH='i386'
	# clang 13 requires libunwind on Android.
	cp $MCHS_STANDALONE_TOOLCHAIN/lib64/clang/12.0.8/lib/linux/$NDK_ARCH/libunwind.a .

	for lib in librt.so libpthread.so libutil.so; do
		echo 'INPUT(-lc)' > $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/$lib
	done
	unset lib
}

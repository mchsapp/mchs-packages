MCHS_PKG_HOMEPAGE=https://developer.android.com/tools/sdk/ndk/index.html
MCHS_PKG_DESCRIPTION="Multilib binaries for cross-compilation"
MCHS_PKG_LICENSE="NCSA"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=$MCHS_NDK_VERSION
MCHS_PKG_REVISION=1
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_NO_STATICSPLIT=true

prepare_libs() {
	local ARCH="$1"
	local SUFFIX="$2"
	local NDK_SUFFIX=$SUFFIX

	if [ $ARCH = x86 ] || [ $ARCH = x86_64 ]; then
	    NDK_SUFFIX=$ARCH
	fi

	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$SUFFIX/lib
	local BASEDIR=$NDK/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$SUFFIX/${MCHS_PKG_API_LEVEL}
	cp $BASEDIR/*.o $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$SUFFIX/lib
	cp $BASEDIR/lib{c,dl,log,m}.so $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$SUFFIX/lib
	cp $BASEDIR/lib{c,dl,m}.a $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$SUFFIX/lib
	cp $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/${SUFFIX}/libc++_shared.so \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$SUFFIX/lib
	cp $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/${SUFFIX}/lib{c++_static,c++abi}.a \
		$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$SUFFIX/lib
	echo 'INPUT(-lc++_static -lc++abi)' > $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$SUFFIX/lib/libc++_shared.a

	if [ $ARCH == "x86" ]; then
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/i386
	elif [ $ARCH == "arm64" ]; then
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/aarch64
	else
		LIBATOMIC=$NDK/toolchains/llvm/prebuilt/linux-x86_64/lib64/clang/*/lib/linux/$ARCH
	fi

	cp $LIBATOMIC/libatomic.a $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$SUFFIX/lib/
}

mchs_step_extract_into_massagedir() {
	prepare_libs "arm" "arm-linux-androideabi"
	prepare_libs "arm64" "aarch64-linux-android"
	prepare_libs "x86" "i686-linux-android"
	prepare_libs "x86_64" "x86_64-linux-android"
}

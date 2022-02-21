MCHS_PKG_HOMEPAGE=https://boost.org
MCHS_PKG_DESCRIPTION="Free peer-reviewed portable C++ source libraries"
MCHS_PKG_LICENSE="BSL-1.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.78.0
MCHS_PKG_SRCURL=https://boostorg.jfrog.io/artifactory/main/release/$MCHS_PKG_VERSION/source/boost_${MCHS_PKG_VERSION//./_}.tar.bz2
MCHS_PKG_SHA256=8681f175d4bdb26c52222665793eef08490d7758529330f98d3b29dd0735bccc
MCHS_PKG_DEPENDS="libc++, libbz2, libiconv, liblzma, zlib"
MCHS_PKG_BUILD_DEPENDS="python"
MCHS_PKG_BREAKS="libboost-python (<= 1.65.1-2), boost-dev"
MCHS_PKG_REPLACES="libboost-python (<= 1.65.1-2), boost-dev"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DBOOST_FILESYSTEM_DISABLE_STATX=ON"

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

mchs_step_make_install() {
	CXXFLAGS+=" -std=c++14"

	rm $MCHS_PREFIX/lib/libboost* -f
	rm $MCHS_PREFIX/include/boost -rf

	CC= CXX= LDFLAGS= CXXFLAGS= ./bootstrap.sh
	echo "using clang : $MCHS_ARCH : $CXX : <linkflags>-L$MCHS_PREFIX/lib ; " >> project-config.jam
	echo "using python : 3.10 : $MCHS_PREFIX/bin/python3 : $MCHS_PREFIX/include/python3.10 : $MCHS_PREFIX/lib ;" >> project-config.jam

	if [ "$MCHS_ARCH" = arm ] || [ "$MCHS_ARCH" = aarch64 ]; then
		BOOSTARCH=arm
		BOOSTABI=aapcs
	elif [ "$MCHS_ARCH" = i686 ] || [ "$MCHS_ARCH" = x86_64 ]; then
		BOOSTARCH=x86
		BOOSTABI=sysv
	fi

	if [ "$MCHS_ARCH" = x86_64 ] || [ "$MCHS_ARCH" = aarch64 ]; then
		BOOSTAM=64
	elif [ "$MCHS_ARCH" = i686 ] || [ "$MCHS_ARCH" = arm ]; then
		BOOSTAM=32
	fi

	./b2 target-os=android -j${MCHS_MAKE_PROCESSES} \
		include=$MCHS_PREFIX/include \
		toolset=clang-$MCHS_ARCH \
		--prefix="$MCHS_PREFIX"  \
		-q \
		--without-stacktrace \
		--disable-icu \
		-sNO_ZSTD=1 \
		cxxflags="$CXXFLAGS" \
		linkflags="$LDFLAGS" \
		architecture="$BOOSTARCH" \
		abi="$BOOSTABI" \
		address-model="$BOOSTAM" \
		boost.locale.icu=off \
		binary-format=elf \
		threading=multi \
		install
}

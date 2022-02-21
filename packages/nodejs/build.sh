MCHS_PKG_HOMEPAGE=https://nodejs.org/
MCHS_PKG_DESCRIPTION="Open Source, cross-platform JavaScript runtime environment"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Yaksh Bariya <yakshbari4@gmail.com>"
MCHS_PKG_VERSION=17.5.0
MCHS_PKG_SRCURL=https://nodejs.org/dist/v${MCHS_PKG_VERSION}/node-v${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=9b24e6830576c57ee36ba48333def8be575232987b4da939568b7b89f773cdc3
# Note that we do not use a shared libuv to avoid an issue with the Android
# linker, which does not use symbols of linked shared libraries when resolving
# symbols on dlopen(). See https://github.com/mchs/mchs-packages/issues/462.
MCHS_PKG_DEPENDS="libc++, openssl, c-ares, libicu, zlib"
MCHS_PKG_CONFLICTS="nodejs-lts, nodejs-current"
MCHS_PKG_BREAKS="nodejs-dev"
MCHS_PKG_REPLACES="nodejs-current, nodejs-dev"
MCHS_PKG_SUGGESTS="clang, make, pkg-config, python"
MCHS_PKG_RM_AFTER_INSTALL="lib/node_modules/npm/html lib/node_modules/npm/make.bat share/systemtap lib/dtrace"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true

mchs_step_post_get_source() {
	# Prevent caching of host build:
	rm -Rf $MCHS_PKG_HOSTBUILD_DIR
}

mchs_step_host_build() {
	local ICU_VERSION=70.1
	local ICU_TAR=icu4c-${ICU_VERSION//./_}-src.tgz
	local ICU_DOWNLOAD=https://github.com/unicode-org/icu/releases/download/release-${ICU_VERSION//./-}/$ICU_TAR
	mchs_download \
		$ICU_DOWNLOAD\
		$MCHS_PKG_CACHEDIR/$ICU_TAR \
		8d205428c17bf13bb535300669ed28b338a157b1c01ae66d31d0d3e2d47c3fd5
	tar xf $MCHS_PKG_CACHEDIR/$ICU_TAR
	cd icu/source
	if [ "$MCHS_ARCH_BITS" = 32 ]; then
		./configure --prefix $MCHS_PKG_HOSTBUILD_DIR/icu-installed \
			--disable-samples \
			--disable-tests \
			--build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
	else
		./configure --prefix $MCHS_PKG_HOSTBUILD_DIR/icu-installed \
			--disable-samples \
			--disable-tests
	fi
	make -j $MCHS_MAKE_PROCESSES install
}

mchs_step_configure() {
	local DEST_CPU
	if [ $MCHS_ARCH = "arm" ]; then
		DEST_CPU="arm"
	elif [ $MCHS_ARCH = "i686" ]; then
		DEST_CPU="ia32"
	elif [ $MCHS_ARCH = "aarch64" ]; then
		DEST_CPU="arm64"
	elif [ $MCHS_ARCH = "x86_64" ]; then
		DEST_CPU="x64"
	else
		mchs_error_exit "Unsupported arch '$MCHS_ARCH'"
	fi

	export GYP_DEFINES="host_os=linux"
	export CC_host=gcc
	export CXX_host=g++
	export LINK_host=g++

	LDFLAGS+=" -ldl"
	# See note above MCHS_PKG_DEPENDS why we do not use a shared libuv.
	./configure \
		--prefix=$MCHS_PREFIX \
		--dest-cpu=$DEST_CPU \
		--dest-os=android \
		--shared-cares \
		--shared-openssl \
		--shared-zlib \
		--with-intl=system-icu \
		--cross-compiling

	export LD_LIBRARY_PATH=$MCHS_PKG_HOSTBUILD_DIR/icu-installed/lib
	perl -p -i -e "s@LIBS := \\$\\(LIBS\\)@LIBS := -L$MCHS_PKG_HOSTBUILD_DIR/icu-installed/lib -lpthread -licui18n -licuuc -licudata -ldl -lz@" \
		$MCHS_PKG_SRCDIR/out/tools/v8_gypfiles/mksnapshot.host.mk \
		$MCHS_PKG_SRCDIR/out/tools/v8_gypfiles/torque.host.mk \
		$MCHS_PKG_SRCDIR/out/tools/v8_gypfiles/bytecode_builtins_list_generator.host.mk \
		$MCHS_PKG_SRCDIR/out/tools/v8_gypfiles/v8_libbase.host.mk \
		$MCHS_PKG_SRCDIR/out/tools/v8_gypfiles/gen-regexp-special-case.host.mk
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	npm config set foreground-scripts true
	EOF
}

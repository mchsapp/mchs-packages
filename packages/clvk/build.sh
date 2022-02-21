MCHS_PKG_HOMEPAGE=https://github.com/kpet/clvk
MCHS_PKG_DESCRIPTION="Experimental implementation of OpenCL on Vulkan"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.0.20220210
_COMMIT=bc9398b486243517c8a4a75dfd517c4146a831c1
MCHS_PKG_SRCURL=https://github.com/kpet/clvk.git
MCHS_PKG_GIT_BRANCH=master
MCHS_PKG_BUILD_DEPENDS="vulkan-loader-android, vulkan-headers"
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_SUGGESTS="ocl-icd"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DLLVM_TABLEGEN=$MCHS_PKG_HOSTBUILD_DIR/bin/llvm-tblgen
-DCLANG_TABLEGEN=$MCHS_PKG_HOSTBUILD_DIR/bin/clang-tblgen
"

# clvk currently does not have proper versioning nor releases
# Use dates and commits as versioning for now

# clvk prefers Khronos Vulkan Loader than the one come from NDK
# Sticking with NDK should expose more Vulkan limitations in Android (like below)
MCHS_PKG_EXTRA_CONFIGURE_ARGS+="
-DCLVK_VULKAN_IMPLEMENTATION=custom
-DVulkan_INCLUDE_DIRS=$MCHS_PREFIX/include
-DVulkan_LIBRARIES=vulkan
"

# clvk build test fail when linking with API 24 libvulkan.so
# clvk likely wont work on Android versions older than Android 9 (API 28)
#
# [1877/1888] Linking CXX executable api_tests
# FAILED: api_tests
# ...
# libOpenCL.so: error: undefined reference to 'vkGetPhysicalDeviceFeatures2'
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DCLVK_BUILD_TESTS=OFF"

# clvk libOpenCL.so has a hardcoded path clspv bin at build time
# clvk cant automatically find clspv from PATH env var
# and rely on CLVK_CLSPV_BIN env var
# Use CLVK_CLSPV_ONLINE_COMPILER=1 to combine clspv with clvk
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DCLVK_CLSPV_ONLINE_COMPILER=1"

mchs_step_post_get_source() {
	git fetch --unshallow
	git reset --hard ${_COMMIT}
	git submodule deinit --force --all
	git submodule update --init --recursive
	./external/clspv/utils/fetch_sources.py --deps llvm
}

mchs_step_host_build() {
	mchs_setup_cmake
	mchs_setup_ninja

	cmake \
		-G Ninja \
		-S "$MCHS_PKG_SRCDIR/external/clspv/third_party/llvm/llvm" \
		-DLLVM_ENABLE_PROJECTS=clang
	cmake \
		--build "$MCHS_PKG_HOSTBUILD_DIR" \
		-j "$MCHS_MAKE_PROCESSES" \
		--target llvm-tblgen clang-tblgen
}

mchs_step_pre_configure() {
	# from packages/libllvm/build.sh
	export LLVM_DEFAULT_TARGET_TRIPLE=${CCMCHS_HOST_PLATFORM/-/-unknown-}
	export LLVM_TARGET_ARCH
	if [ $MCHS_ARCH = "arm" ]; then
		LLVM_TARGET_ARCH=ARM
	elif [ $MCHS_ARCH = "aarch64" ]; then
		LLVM_TARGET_ARCH=AArch64
	elif [ $MCHS_ARCH = "i686" ] || [ $MCHS_ARCH = "x86_64" ]; then
		LLVM_TARGET_ARCH=X86
	else
		mchs_error_exit "Invalid arch: $MCHS_ARCH"
	fi

	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGET_ARCH=$LLVM_TARGET_ARCH"
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_TARGETS_TO_BUILD=$LLVM_TARGET_ARCH"
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"
}

mchs_step_make_install() {
	# clvk has a very basic install rule
	install -Dm644 "$MCHS_PKG_BUILDDIR/libOpenCL.so" "$MCHS_PREFIX/lib/clvk/libOpenCL.so"

	echo "$MCHS_PREFIX/lib/clvk/libOpenCL.so" > "$MCHS_PKG_TMPDIR/clvk.icd"
	install -Dm644 "$MCHS_PKG_TMPDIR/clvk.icd" "$MCHS_PREFIX/etc/OpenCL/vendors/clvk.icd"
}

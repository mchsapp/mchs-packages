MCHS_PKG_HOMEPAGE=https://openethereum.github.io
MCHS_PKG_DESCRIPTION="Lightweight Ethereum Client"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.3.3
MCHS_PKG_SRCURL=https://github.com/openethereum/openethereum/archive/v${MCHS_PKG_VERSION}.zip
MCHS_PKG_SHA256=e62f2f825ca895a12b18b07af6ff8472417516a3644c0ca6401d88e741332b7e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	mchs_setup_cmake

	CXXFLAGS+=" --target=$CCMCHS_HOST_PLATFORM"
	CFLAGS+=" --target=$CCMCHS_HOST_PLATFORM"
	if [ $MCHS_ARCH = "arm" ]; then
		CFLAGS="${CFLAGS/-mthumb/}"
		CMAKE_SYSTEM_PROCESSOR="armv7-a"
	else
		CMAKE_SYSTEM_PROCESSOR=$MCHS_ARCH
	fi

	cat <<- EOF > $MCHS_COMMON_CACHEDIR/defaultcache.cmake
		CMAKE_CROSSCOMPILING=ON
		CMAKE_LINKER="$MCHS_STANDALONE_TOOLCHAIN/bin/$LD $LDFLAGS"
		CMAKE_SYSTEM_NAME=Android
		CMAKE_SYSTEM_VERSION=$MCHS_PKG_API_LEVEL
		CMAKE_SYSTEM_PROCESSOR=$CMAKE_SYSTEM_PROCESSOR
		CMAKE_ANDROID_STANDALONE_TOOLCHAIN=$MCHS_STANDALONE_TOOLCHAIN

		CMAKE_AR="$(command -v $AR)"
		CMAKE_UNAME="$(command -v uname)"
		CMAKE_RANLIB="$(command -v $RANLIB)"
		CMAKE_C_FLAGS="$CFLAGS -Wno-error=shadow $CPPFLAGS"
		CMAKE_CXX_FLAGS="$CXXFLAGS $CPPFLAGS"
		CMAKE_FIND_ROOT_PATH=$MCHS_PREFIX
		CMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER
		CMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY
		CMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY
		CMAKE_SKIP_INSTALL_RPATH=ON
		CMAKE_USE_SYSTEM_LIBRARIES=ON
		BUILD_TESTING=OFF

		WITH_GFLAGS=OFF
	EOF

	export CMAKE=$MCHS_PKG_BUILDER_DIR/cmake_mod.sh
	export MCHS_COMMON_CACHEDIR

	mchs_setup_rust
	cargo clean
	export NDK_HOME=$NDK
	RUSTFLAGS+=" -C link-args=-lc++"
	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	if [ "$MCHS_ARCH" = "x86_64" ]; then
		local libdir=target/$CARGO_TARGET_NAME/release/deps
		mkdir -p $libdir
		pushd $libdir
		local libgcc="$($CC -print-libgcc-file-name)"
		echo "INPUT($libgcc -l:libunwind.a)" > libgcc.so
		popd
	fi
}

mchs_step_make() {
	cargo fetch --target $CARGO_TARGET_NAME
	patch --silent -p1 \
		-d $CARGO_HOME/registry/src/github.com-*/parity-rocksdb-sys-0.5.6/rocksdb \
		< $MCHS_PKG_BUILDER_DIR/parity-rocksdb-sys-0.5.6-mutex.diff
	cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release --features final
	for applet in evmbin ethstore-cli ethkey-cli; do
		cargo build --jobs $MCHS_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release -p $applet
	done
}

mchs_step_make_install() {
	for applet in openethereum openethereum-evm ethstore ethkey; do
		install -Dm755 -t $MCHS_PREFIX/bin target/${CARGO_TARGET_NAME}/release/$applet
	done
}

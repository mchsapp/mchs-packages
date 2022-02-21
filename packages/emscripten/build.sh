MCHS_PKG_HOMEPAGE=https://emscripten.org
MCHS_PKG_DESCRIPTION="Emscripten: An LLVM-to-WebAssembly Compiler"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@truboxl"
MCHS_PKG_VERSION=3.1.2
MCHS_PKG_SRCURL=https://github.com/emscripten-core/emscripten.git
MCHS_PKG_GIT_BRANCH=$MCHS_PKG_VERSION
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_RECOMMENDS="emscripten-llvm, emscripten-binaryen, python, nodejs-lts | nodejs"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_NO_STATICSPLIT=true

# remove files according to emsdk/upstream directory after running
# ./emsdk install latest
MCHS_PKG_RM_AFTER_INSTALL="
opt/emscripten-llvm/bin/clang-check
opt/emscripten-llvm/bin/clang-cl
opt/emscripten-llvm/bin/clang-cpp
opt/emscripten-llvm/bin/clang-extdef-mapping
opt/emscripten-llvm/bin/clang-format
opt/emscripten-llvm/bin/clang-func-mapping
opt/emscripten-llvm/bin/clang-import-test
opt/emscripten-llvm/bin/clang-nvlink-wrapper
opt/emscripten-llvm/bin/clang-offload-bundler
opt/emscripten-llvm/bin/clang-offload-wrapper
opt/emscripten-llvm/bin/clang-refactor
opt/emscripten-llvm/bin/clang-repl
opt/emscripten-llvm/bin/clang-rename
opt/emscripten-llvm/bin/clang-scan-deps
opt/emscripten-llvm/bin/diagtool
opt/emscripten-llvm/bin/git-clang-format
opt/emscripten-llvm/bin/hmaptool
opt/emscripten-llvm/bin/llvm-cov
opt/emscripten-llvm/bin/llvm-ml
opt/emscripten-llvm/bin/llvm-profdata
opt/emscripten-llvm/bin/llvm-rc
opt/emscripten-llvm/bin/llvm-strip
opt/emscripten-llvm/bin/ld.lld
opt/emscripten-llvm/bin/ld64.lld
opt/emscripten-llvm/bin/ld64.lld.darwin*
opt/emscripten-llvm/bin/lld-link
opt/emscripten-llvm/bin/llvm-lib
opt/emscripten-llvm/lib/libclang.so*
opt/emscripten-llvm/share
opt/emscripten/LICENSE
"

# https://github.com/emscripten-core/emscripten/blob/main/docs/packaging.md
# https://github.com/archlinux/svntogit-community/tree/packages/emscripten/trunk
# below generates commit hash for the deps according to emscripten releases
#RELEASES_TAGS=$(curl -s https://raw.githubusercontent.com/emscripten-core/emsdk/main/emscripten-releases-tags.json)
#RELEASE_TAG=$(echo $RELEASES_TAGS | python3 -c "import json,sys;print(json.load(sys.stdin)[\"releases\"][\"$MCHS_PKG_VERSION\"])")
#DEPS_REVISION=$(curl -s https://chromium.googlesource.com/emscripten-releases/+/$RELEASE_TAG/DEPS?format=text | base64 -d | grep "_revision':" | sed -e "s|'|\"|g")
#DEPS_JSON=$(echo -e "{\n${DEPS_REVISION}EOL" | sed -e "s|,EOL|\n}|")
#LLVM_COMMIT=$(echo $DEPS_JSON | python3 -c "import json,sys;print(json.load(sys.stdin)[\"llvm_project_revision\"])")
#BINARYEN_COMMIT=$(echo $DEPS_JSON | python3 -c "import json,sys;print(json.load(sys.stdin)[\"binaryen_revision\"])")
#curl -LOC - https://github.com/llvm/llvm-project/archive/$LLVM_COMMIT.tar.gz
#curl -LOC - https://github.com/WebAssembly/binaryen/archive/$BINARYEN_COMMIT.tar.gz
#sha256sum $LLVM_COMMIT.tar.gz $BINARYEN_COMMIT.tar.gz

# https://github.com/emscripten-core/emscripten/issues/11362
# can switch to stable LLVM to save space once above is fixed
LLVM_COMMIT=782c0dd1a1c235afb09a34e7da4a1267ead14765
LLVM_TGZ_SHA256=241f12c4275c77a4300095f8a65cf05b781b2dc88c171385dc87f61648b0a610

# https://github.com/emscripten-core/emscripten/issues/12252
# upstream says better bundle the right binaryen revision for now
BINARYEN_COMMIT=c918679ec50d4a404bd06244e79691651bdee95b
BINARYEN_TGZ_SHA256=434cfcfe7c40853b4f4134de34596eed2d986c263d8cea345fcb74d2dc428485

# https://github.com/emscripten-core/emsdk/blob/main/emsdk.py
# https://chromium.googlesource.com/emscripten-releases/+/refs/heads/main/src/build.py
# https://github.com/llvm/llvm-project
LLVM_BUILD_ARGS="
-DCMAKE_BUILD_TYPE=MinSizeRel
-DCMAKE_CROSSCOMPILING=ON
-DCMAKE_INSTALL_PREFIX=$MCHS_PREFIX/opt/emscripten-llvm

-DDEFAULT_SYSROOT=$(dirname $MCHS_PREFIX)
-DGENERATOR_IS_MULTI_CONFIG=ON
-DLLVM_ENABLE_ASSERTIONS=ON
-DLLVM_ENABLE_BINDINGS=OFF
-DLLVM_ENABLE_LIBEDIT=OFF
-DLLVM_ENABLE_LIBPFM=OFF
-DLLVM_ENABLE_LIBXML2=OFF
-DLLVM_ENABLE_PROJECTS=clang;compiler-rt;libunwind;lld
-DLLVM_ENABLE_TERMINFO=OFF
-DLLVM_INCLUDE_EXAMPLES=OFF
-DLLVM_INCLUDE_TESTS=OFF
-DLLVM_INSTALL_TOOLCHAIN_ONLY=ON
-DLLVM_LINK_LLVM_DYLIB=ON
-DLLVM_TABLEGEN=$MCHS_PKG_HOSTBUILD_DIR/bin/llvm-tblgen

-DCLANG_DEFAULT_LINKER=lld
-DCLANG_ENABLE_ARCMT=OFF
-DCLANG_ENABLE_STATIC_ANALYZER=OFF
-DCLANG_TABLEGEN=$MCHS_PKG_HOSTBUILD_DIR/bin/clang-tblgen

-DCOMPILER_RT_BUILD_CRT=OFF
-DCOMPILER_RT_BUILD_LIBFUZZER=OFF
-DCOMPILER_RT_BUILD_MEMPROF=OFF
-DCOMPILER_RT_BUILD_PROFILE=OFF
-DCOMPILER_RT_BUILD_SANITIZERS=OFF
-DCOMPILER_RT_BUILD_XRAY=OFF
-DCOMPILER_RT_INCLUDE_TESTS=OFF

-DLIBUNWIND_USE_COMPILER_RT=ON
"

# https://github.com/WebAssembly/binaryen/blob/main/CMakeLists.txt
BINARYEN_BUILD_ARGS="
-DCMAKE_BUILD_TYPE=MinSizeRel
-DCMAKE_INSTALL_PREFIX=$MCHS_PREFIX/opt/emscripten-binaryen
"

mchs_step_post_get_source() {
	mchs_download \
		"https://github.com/llvm/llvm-project/archive/$LLVM_COMMIT.tar.gz" \
		"$MCHS_PKG_CACHEDIR/llvm.tar.gz" \
		"$LLVM_TGZ_SHA256"
	mchs_download \
		"https://github.com/WebAssembly/binaryen/archive/$BINARYEN_COMMIT.tar.gz" \
		"$MCHS_PKG_CACHEDIR/binaryen.tar.gz" \
		"$BINARYEN_TGZ_SHA256"
	tar -xf "$MCHS_PKG_CACHEDIR/llvm.tar.gz" -C "$MCHS_PKG_CACHEDIR"
	tar -xf "$MCHS_PKG_CACHEDIR/binaryen.tar.gz" -C "$MCHS_PKG_CACHEDIR"

	cd "$MCHS_PKG_CACHEDIR/llvm-project-$LLVM_COMMIT"
	for patch in $MCHS_PKG_BUILDER_DIR/llvm-project-*.patch.diff; do
		patch -p1 -i "$patch"
	done
}

mchs_step_host_build() {
	mchs_setup_cmake
	mchs_setup_ninja

	cmake \
		-G Ninja \
		-S "$MCHS_PKG_CACHEDIR/llvm-project-$LLVM_COMMIT/llvm" \
		-DLLVM_ENABLE_PROJECTS=clang
	cmake \
		--build "$MCHS_PKG_HOSTBUILD_DIR" \
		-j "$MCHS_MAKE_PROCESSES" \
		--target llvm-tblgen clang-tblgen
}

mchs_step_make() {
	mchs_setup_cmake
	mchs_setup_ninja

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

	LLVM_BUILD_ARGS+=" -DLLVM_TARGET_ARCH=$LLVM_TARGET_ARCH"
	LLVM_BUILD_ARGS+=" -DLLVM_TARGETS_TO_BUILD=WebAssembly;$LLVM_TARGET_ARCH"
	LLVM_BUILD_ARGS+=" -DLLVM_HOST_TRIPLE=$LLVM_DEFAULT_TARGET_TRIPLE"

	cmake \
		-G Ninja \
		-S "$MCHS_PKG_CACHEDIR/llvm-project-$LLVM_COMMIT/llvm" \
		-B "$MCHS_PKG_CACHEDIR/build-llvm" \
		$LLVM_BUILD_ARGS
	cmake \
		--build "$MCHS_PKG_CACHEDIR/build-llvm" \
		-j "$MCHS_MAKE_PROCESSES" \
		--target install

	cmake \
		-G Ninja \
		-S "$MCHS_PKG_CACHEDIR/binaryen-$BINARYEN_COMMIT" \
		-B "$MCHS_PKG_CACHEDIR/build-binaryen" \
		$BINARYEN_BUILD_ARGS
	cmake \
		--build "$MCHS_PKG_CACHEDIR/build-binaryen" \
		-j "$MCHS_MAKE_PROCESSES" \
		--target install
}

mchs_step_make_install() {
	# https://github.com/emscripten-core/emscripten/pull/15840
	sed -e "s|-git||" -i "$MCHS_PKG_SRCDIR/emscripten-version.txt"

	# skip using Makefile which does host npm install
	rm -fr "$MCHS_PREFIX/opt/emscripten"
	./tools/install.py "$MCHS_PREFIX/opt/emscripten"

	# subpackage optional third party test suite files
	cp -fr "$MCHS_PKG_SRCDIR/tests/third_party" "$MCHS_PREFIX/opt/emscripten/tests/third_party"

	# first run generates .emscripten and exits immediately
	rm -f "$MCHS_PKG_SRCDIR/.emscripten"
	./emcc
	sed -i .emscripten -e "s|^EMSCRIPTEN_ROOT.*|EMSCRIPTEN_ROOT = '$MCHS_PREFIX/opt/emscripten' # directory|"
	sed -i .emscripten -e "s|^LLVM_ROOT.*|LLVM_ROOT = '$MCHS_PREFIX/opt/emscripten-llvm/bin' # directory|"
	sed -i .emscripten -e "s|^BINARYEN_ROOT.*|BINARYEN_ROOT = '$MCHS_PREFIX/opt/emscripten-binaryen' # directory|"
	sed -i .emscripten -e "s|^NODE_JS.*|NODE_JS = '$MCHS_PREFIX/bin/node' # executable|"
	grep "$MCHS_PREFIX" "$MCHS_PKG_SRCDIR/.emscripten"
	install -Dm644 "$MCHS_PKG_SRCDIR/.emscripten" "$MCHS_PREFIX/opt/emscripten/.emscripten"

	# add emscripten directory to PATH var
	cat <<- EOF > "$MCHS_PKG_TMPDIR/emscripten.sh"
	#!$MCHS_PREFIX/bin/sh
	export PATH=\$PATH:$MCHS_PREFIX/opt/emscripten
	EOF
	install -Dm644 "$MCHS_PKG_TMPDIR/emscripten.sh" "$MCHS_PREFIX/etc/profile.d/emscripten.sh"

	# add useful tools not installed by LLVM_INSTALL_TOOLCHAIN_ONLY=ON
	for tool in llc llvm-{addr2line,dwarfdump,dwp,link,nm,objdump,readobj,size} opt; do
		install -Dm755 "$MCHS_PKG_CACHEDIR/build-llvm/bin/$tool" "$MCHS_PREFIX/opt/emscripten-llvm/bin/$tool"
	done

	# wasm32 triplets
	ln -fsT "clang"   "$MCHS_PREFIX/opt/emscripten-llvm/bin/wasm32-clang"
	ln -fsT "clang++" "$MCHS_PREFIX/opt/emscripten-llvm/bin/wasm32-clang++"
	ln -fsT "clang"   "$MCHS_PREFIX/opt/emscripten-llvm/bin/wasm32-wasi-clang"
	ln -fsT "clang++" "$MCHS_PREFIX/opt/emscripten-llvm/bin/wasm32-wasi-clang++"

	# unable to determine the reason why different linker searches for
	# libclang_rt.builtins-*-android.a in different paths even after adding
	# the patches from libllvm (also which one is more correct?)
	#
	# binutils LD searches lib/clang/14.0.0/lib/linux (exist)
	# LLVM LD.LLD searches lib/clang/14.0.0/lib/android (not exist)
	ln -fsT "linux" "$MCHS_PREFIX/opt/emscripten-llvm/lib/clang/14.0.0/lib/android"
}

mchs_step_create_debscripts() {
	# emscripten's package-lock.json is generated with nodejs v12.13.0
	# which comes with npm v6 which used lockfile version 1
	# which isn't compatible with lockfile version 2 used in npm v7 and v8
	cat <<- EOF > postinst
	#!$MCHS_PREFIX/bin/bash
	if [ -n "\$(command -v npm)" ]; then
	cd "$MCHS_PREFIX/opt/emscripten"
	NPM_VERSION=\$(npm --version)
	NPM_MAJOR_VERSION=\${NPM_VERSION:0:1}
	if [ 6 = \$NPM_MAJOR_VERSION ]; then
	echo 'Running "npm ci --no-optional --production" in $MCHS_PREFIX/opt/emscripten ...'
	npm ci --no-optional --production
	else
	echo 'Running "npm install --no-optional --production" in $MCHS_PREFIX/opt/emscripten ...'
	rm package-lock.json
	npm install --no-optional --production
	fi
	else
	echo 'Warning: npm is not installed! Emscripten may not work properly without installing node modules!' >&2
	fi
	echo '
	====================
	Post-install notice:
	If this is the first time installing Emscripten,
	please start a new session to take effect.
	If you are upgrading, you may want to clear the
	cache by running the command below to fix issues.

	emcc --clear-cache

	===================='
	EOF

	cat <<- EOF > postrm
	#!$MCHS_PREFIX/bin/sh
	case "\$1" in
	purge|remove)
	rm -fr "$MCHS_PREFIX/opt/emscripten"
	esac
	EOF
}

# Emscripten Test Suite (Optional)
# Some preparations need to be made in Emscripten directory before running
# test suite on Android / McHs. Refer docs below:
# https://emscripten.org/docs/getting_started/test-suite.html
# https://github.com/emscripten-core/emscripten/pull/13493
# https://github.com/emscripten-core/emscripten/issues/9098
#
# Steps:
# - pkg install emscripten-tests-third-party openjdk-17
# - cd $PREFIX/opt/emscripten
# - npm ci --no-optional
# - export EMCC_CORES=1
# - export EMTEST_SKIP_V8=1
# - tests/runner {test_name}

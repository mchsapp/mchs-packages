MCHS_PKG_HOMEPAGE=https://www.rust-lang.org/
MCHS_PKG_DESCRIPTION="Systems programming language focused on safety, speed and concurrency"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.58.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://static.rust-lang.org/dist/rustc-$MCHS_PKG_VERSION-src.tar.xz
MCHS_PKG_SHA256=2b3643a48e7087053b0268971ec4154350342508922a8acb0707aaf94deb4469
MCHS_PKG_DEPENDS="libc++, clang, openssl, lld, zlib, libllvm"
MCHS_PKG_RM_AFTER_INSTALL="bin/llvm-dwp"

mchs_step_configure() {
	mchs_setup_cmake
	mchs_setup_rust

	# it breaks building rust tools without doing this because it tries to find
	# ../lib from bin location:
	# this is about to get ugly but i have to make sure a rustc in a proper bin lib
	# configuration is used otherwise it fails a long time into the build...
	# like 30 to 40 + minutes ... so lets get it right

	# upstream only tests build ver one version behind $MCHS_PKG_VERSION
	local BOOTSTRAP_VERSION=1.57.0
	rustup install $BOOTSTRAP_VERSION
	rustup default $BOOTSTRAP_VERSION-x86_64-unknown-linux-gnu
	export PATH=$HOME/.rustup/toolchains/$BOOTSTRAP_VERSION-x86_64-unknown-linux-gnu/bin:$PATH
	local RUSTC=$(command -v rustc)
	local CARGO=$(command -v cargo)

	sed "s%\\@MCHS_PREFIX\\@%$MCHS_PREFIX%g" \
		$MCHS_PKG_BUILDER_DIR/config.toml \
		| sed "s%\\@MCHS_STANDALONE_TOOLCHAIN\\@%$MCHS_STANDALONE_TOOLCHAIN%g" \
		| sed "s%\\@triple\\@%$CARGO_TARGET_NAME%g" \
		| sed "s%\\@RUSTC\\@%$RUSTC%g" \
		| sed "s%\\@CARGO\\@%$CARGO%g" \
		> config.toml

	local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
	export ${env_host}_OPENSSL_DIR=$MCHS_PREFIX
	export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu
	export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_INCLUDE_DIR=/usr/include
	export PKG_CONFIG_ALLOW_CROSS=1
	# for backtrace-sys
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu="-O2"
	export LLVM_VERSION=$(grep ^MCHS_PKG_VERSION= $MCHS_PKG_BUILDER_DIR/../libllvm/build.sh | cut -f2 -d=)
	unset CC CXX CPP LD CFLAGS CXXFLAGS CPPFLAGS LDFLAGS PKG_CONFIG RANLIB
	# we can't use -L$PREFIX/lib since it breaks things but we need to link against libLLVM-9.so
	ln -sf $PREFIX/lib/libLLVM-$LLVM_VERSION.so $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/

	# rust checks libs in PREFIX/lib. It then can't find libc.so and libdl.so because rust program doesn't
	# know where those are. Putting them temporarly in $PREFIX/lib prevents that failure
	mv $MCHS_PREFIX/lib/libtinfo.so.6 $MCHS_PREFIX/lib/libtinfo.so.6.tmp
	mv $MCHS_PREFIX/lib/libz.so.1 $MCHS_PREFIX/lib/libz.so.1.tmp
	mv $MCHS_PREFIX/lib/libz.so $MCHS_PREFIX/lib/libz.so.tmp
}

mchs_step_make() {
	return 0;
}
mchs_step_make_install() {
	if [ $MCHS_ARCH = "x86_64" ]; then
		 mv $MCHS_PREFIX ${MCHS_PREFIX}a
		 $MCHS_PKG_SRCDIR/x.py build --host x86_64-unknown-linux-gnu --stage 1 cargo || $MCHS_PKG_SRCDIR/x.py build --host x86_64-unknown-linux-gnu  --stage 1 rls ||  $MCHS_PKG_SRCDIR/x.py build --host x86_64-unknown-linux-gnu --stage 1 rustfmt || $MCHS_PKG_SRCDIR/x.py --stage 1 --host x86_64-unknown-linux-gnu  build rustdoc || $MCHS_PKG_SRCDIR/x.py --stage 1 --host x86_64-unknown-linux-gnu build error_index_generator  || true
		 mv ${MCHS_PREFIX}a ${MCHS_PREFIX}
	
	fi

	#$MCHS_PKG_SRCDIR/x.py dist --stage 1 --host $CARGO_TARGET_NAME --target $CARGO_TARGET_NAME || bash
	$MCHS_PKG_SRCDIR/x.py install --stage 1 --host $CARGO_TARGET_NAME --target $CARGO_TARGET_NAME  || bash
	$MCHS_PKG_SRCDIR/x.py install --stage 1 std --target wasm32-unknown-unknown || bash
	$MCHS_PKG_SRCDIR/x.py dist rustc-dev --host $CARGO_TARGET_NAME --target $CARGO_TARGET_NAME --target wasm32-unknown-unknown || bash
	tar xvf build/dist/rustc-dev-$MCHS_PKG_VERSION-$CARGO_TARGET_NAME.tar.gz
	./rustc-dev-$MCHS_PKG_VERSION-$CARGO_TARGET_NAME/install.sh --prefix=$MCHS_PREFIX

	cd "$MCHS_PREFIX/lib"
	rm -f libc.so libdl.so
	mv $MCHS_PREFIX/lib/libtinfo.so.6.tmp $MCHS_PREFIX/lib/libtinfo.so.6
	mv $MCHS_PREFIX/lib/libz.so.1.tmp $MCHS_PREFIX/lib/libz.so.1
	mv $MCHS_PREFIX/lib/libz.so.tmp $MCHS_PREFIX/lib/libz.so
	
	ln -sf rustlib/$CARGO_TARGET_NAME/lib/*.so .
	ln -sf $MCHS_PREFIX/bin/lld $MCHS_PREFIX/bin/rust-lld
	
	cd "$MCHS_PREFIX/lib/rustlib"
	rm -rf components \
		install.log \
		uninstall.sh \
		rust-installer-version \
		manifest-* \
		x86_64-unknown-linux-gnu
	rm $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/libLLVM-$LLVM_VERSION.so

}
mchs_step_post_massage() {
	rm -f lib/libtinfo.so.6
	rm -f lib/libz.so
	rm -f lib/libz.so.1
}


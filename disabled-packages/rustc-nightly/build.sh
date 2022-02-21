MCHS_PKG_HOMEPAGE=https://www.rust-lang.org
MCHS_PKG_DESCRIPTION="Rust compiler and utilities (nightly version)"
MCHS_PKG_DEPENDS="libc++, clang, openssl, lld, zlib, libllvm"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@its-pointless"
MCHS_PKG_VERSION=1.52.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://static.rust-lang.org/dist/2021-02-24/rustc-nightly-src.tar.xz
MCHS_PKG_SHA256=80536b0050fc83cdffedf617bac0fd23dc60081adc00648b90404e1a14baba18
MCHS_PKG_KEEP_SHARE_DOC=true

mchs_step_configure () {
	mchs_setup_cmake
	mchs_setup_rust
	
	# nightlys don't build with stable
	rustup install beta-2021-02-14-x86_64-unknown-linux-gnu
	rustup target add $CARGO_TARGET_NAME
	export  PATH=$HOME/.rustup/toolchains/beta-2021-02-14-x86_64-unknown-linux-gnu/bin:$PATH
	export	RUST_BACKTRACE=1
	mkdir -p $MCHS_PREFIX/opt/rust-nightly
	RUST_PREFIX=$MCHS_PREFIX/opt/rust-nightly
	export PATH=$MCHS_PKG_TMPDIR/bin:$PATH
		sed $MCHS_PKG_BUILDER_DIR/config.toml \
			-e "s|@RUST_PREFIX@|$RUST_PREFIX|g" \
			-e "s|@MCHS_PREFIX@|$MCHS_PREFIX|g" \
			-e "s|@MCHS_HOST_PLATFORM@|$MCHS_HOST_PLATFORM|g" \
			-e "s|@RUST_TARGET_TRIPLE@|$CARGO_TARGET_NAME|g" \
			-e "s|@CARGO@|$(command -v cargo)|g" \
			-e "s|@RUSTC@|$(command -v rustc)|g" > $MCHS_PKG_BUILDDIR/config.toml

	export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR=/usr/lib/x86_64-linux-gnu
	export X86_64_UNKNOWN_LINUX_GNU_OPENSSL_INCLUDE_DIR=/usr/include
	export PKG_CONFIG_ALLOW_CROSS=1
	# for backtrace-sys
	export CC_x86_64_unknown_linux_gnu=gcc
	export CFLAGS_x86_64_unknown_linux_gnu="-O2"
	# it won't link with it in MCHS_PREFIX/lib without breaking other things.
	cp $PREFIX/lib/libLLVM-11.1.0.so $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/
	unset CC CXX CPP LD CFLAGS CXXFLAGS CPPFLAGS LDFLAGS PKG_CONFIG AR RANLIB
	if [ $MCHS_ARCH = "x86_64" ]; then
		cp $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/x86_64-linux-android/$MCHS_PKG_API_LEVEL/libc.so $MCHS_PREFIX/lib/
		cp $MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/x86_64-linux-android/$MCHS_PKG_API_LEVEL/libdl.so $MCHS_PREFIX/lib/
		mv $MCHS_PREFIX/lib/libtinfo.so.6 $MCHS_PREFIX/lib/libtinfo.so.6.tmp
	fi
}

mchs_step_make_install () {
	if [ ! -f "/usr/bin/llvm-dwp" ]; then
		# errr yeah this needs to be here for docker stuff
		sudo ln -s /usr/bin/llvm-dwp-10 /usr/bin/llvm-dwp
	fi
	if [ $MCHS_ARCH = "x86_64" ]; then
		mv $MCHS_PREFIX ${MCHS_PREFIX}a
		../src/x.py dist cargo  --host x86_64-unknown-linux-gnu
		../src/x.py dist rls  --host x86_64-unknown-linux-gnu
		../src/x.py dist rust-analyzer  --host x86_64-unknown-linux-gnu
		../src/x.py dist rustfmt  --host x86_64-unknown-linux-gnu
		../src/x.py dist miri --host x86_64-unknown-linux-gnu
		mv ${MCHS_PREFIX}a ${MCHS_PREFIX}
	fi
        ../src/x.py build --host $CARGO_TARGET_NAME --target $CARGO_TARGET_NAME --target wasm32-unknown-unknown || bash
	../src/x.py dist --host $CARGO_TARGET_NAME --target $CARGO_TARGET_NAME --target wasm32-unknown-unknown || bash
	mkdir $MCHS_PKG_BUILDDIR/install
	# miri-nightly not working.
	for tar in rustc-nightly miri-nightly rustc-dev-nightly rust-docs-nightly rust-std-nightly rust-analysis-nightly cargo-nightly rls-nightly rustc-dev-nightly rustfmt-nightly clippy-nightly; do
		tar -xf $MCHS_PKG_BUILDDIR/build/dist/$tar-$CARGO_TARGET_NAME.tar.gz -C $MCHS_PKG_BUILDDIR/install
		# uninstall previous version
		$MCHS_PKG_BUILDDIR/install/$tar-$CARGO_TARGET_NAME/install.sh --uninstall --prefix=$RUST_PREFIX || true
		$MCHS_PKG_BUILDDIR/install/$tar-$CARGO_TARGET_NAME/install.sh --prefix=$RUST_PREFIX
	done

	tar -xf $MCHS_PKG_BUILDDIR/build/dist/rust-src-nightly.tar.gz -C $MCHS_PKG_BUILDDIR/install
	$MCHS_PKG_BUILDDIR/install/rust-src-nightly/install.sh --uninstall --prefix=$RUST_PREFIX || true
	$MCHS_PKG_BUILDDIR/install/rust-src-nightly/install.sh --prefix=$RUST_PREFIX
	WASM=wasm32-unknown-unknown
	for tar in rust-std-nightly rust-analysis-nightly; do
		tar -xf $MCHS_PKG_BUILDDIR/build/dist/$tar-$WASM.tar.gz -C $MCHS_PKG_BUILDDIR/install
		# uninstall previous version
		$MCHS_PKG_BUILDDIR/install/$tar-$WASM/install.sh --uninstall --prefix=$RUST_PREFIX || true
		$MCHS_PKG_BUILDDIR/install/$tar-$WASM/install.sh --prefix=$RUST_PREFIX
	done
	if [ $MCHS_ARCH = "x86_64" ]; then
		rm -f $MCHS_PREFIX/lib/libc.so  $MCHS_PREFIX/lib/libdl.so
		mv $MCHS_PREFIX/lib/libtinfo.so.6.tmp $MCHS_PREFIX/lib/libtinfo.so.6
	fi
	
}

mchs_step_post_massage () {
	rm $MCHS_PKG_MASSAGEDIR/$RUST_PREFIX/lib/rustlib/{components,rust-installer-version,install.log,uninstall.sh}
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/etc/profile.d
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib
	echo "#!$MCHS_PREFIX/bin/sh" > $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/etc/profile.d/rust-nightly.sh
	echo "export PATH=$RUST_PREFIX/bin:\$PATH" >> $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/etc/profile.d/rust-nightly.sh
	cd $MCHS_PKG_MASSAGEDIR/$RUST_PREFIX/lib
	ln -sf rustlib/$CARGO_TARGET_NAME/lib/lib*.so .
	cd $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib
	ln -sf ../opt/rust-nightly/lib/lib*.so .
	ln -sf $MCHS_PREFIX/bin/lld $MCHS_PKG_MASSAGEDIR$RUST_PREFIX/bin/rust-lld
	rm -f ../bin/llvm-dwp
	if [ $MCHS_ARCH = "x86_64" ]; then
		rm -f $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/lib/libtinfo.so.6
	fi
	rm	$MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/libLLVM-11.1.0.so
}
mchs_step_create_debscripts () {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "echo 'source \$PREFIX/etc/profile.d/rust-nightly.sh to use nightly'" >> postinst
	echo "echo 'or export RUSTC=\$PREFIX/opt/rust-nightly/bin/rustc'" >> postinst
}

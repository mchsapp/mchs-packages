MCHS_PKG_HOMEPAGE=https://www.nushell.sh
MCHS_PKG_DESCRIPTION="A new type of shell operating on structured data"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.44.0
MCHS_PKG_SRCURL=https://github.com/nushell/nushell/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=94bb003fd05b604a174a686c40286fef460bc06616a7d273c387a54a07576ecc
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="openssl, zlib"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	# CARGO_TARGET_NAME is not set before mchs_setup_rust
	local _CARGO_TARGET_NAME
	if [ $MCHS_ARCH = "arm" ]; then
		_CARGO_TARGET_NAME=armv7-linux-androideabi
	else
		_CARGO_TARGET_NAME=$MCHS_ARCH-linux-android
	fi
	local _CARGO_TARGET_LIBDIR=target/$_CARGO_TARGET_NAME/release/deps
	mkdir -p $_CARGO_TARGET_LIBDIR

	if [ $MCHS_ARCH = "i686" ]; then
		RUSTFLAGS+=" -C link-arg=-latomic"
	elif [ $MCHS_ARCH = "x86_64" ]; then
		pushd $_CARGO_TARGET_LIBDIR
		local libgcc="$($CC -print-libgcc-file-name)"
		echo "INPUT($libgcc -l:libunwind.a)" > libgcc.so
		popd
	fi

	mv $MCHS_PREFIX/lib/libz.so.1{,.tmp}
	mv $MCHS_PREFIX/lib/libz.so{,.tmp}

	ln -sfT $(readlink -f $MCHS_PREFIX/lib/libz.so.1.tmp) \
		$_CARGO_TARGET_LIBDIR/libz.so.1
	ln -sfT $(readlink -f $MCHS_PREFIX/lib/libz.so.tmp) \
		$_CARGO_TARGET_LIBDIR/libz.so
}

mchs_step_post_make_install() {
	mv $MCHS_PREFIX/lib/libz.so.1{.tmp,}
	mv $MCHS_PREFIX/lib/libz.so{.tmp,}
}

mchs_step_post_massage() {
	rm -f lib/libz.so.1
	rm -f lib/libz.so
}

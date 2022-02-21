MCHS_PKG_HOMEPAGE=https://github.com/xiph/rav1e/
MCHS_PKG_DESCRIPTION="An AV1 encoder library focused on speed and safety"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.1
MCHS_PKG_SRCURL=https://github.com/xiph/rav1e/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=7b3060e8305e47f10b79f3a3b3b6adc3a56d7a58b2cb14e86951cc28e1b089fd
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make_install(){
	mchs_setup_rust

	mchs_download \
		https://github.com/lu-zero/cargo-c/releases/download/v0.9.5/cargo-c-linux.tar.gz \
		$MCHS_PKG_CACHEDIR/cargo-c-linux.tar.gz \
		b16717417b5e07f7aabcff1227d94689a8a8bcbcac7df6999135ab86c762066f
	tar -xzf $MCHS_PKG_CACHEDIR/cargo-c-linux.tar.gz -C $HOME/.cargo/bin

	export CARGO_BUILD_TARGET=$CARGO_TARGET_NAME

	cargo fetch \
		--target $CARGO_TARGET_NAME \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS

	cargo install \
		--jobs $MCHS_MAKE_PROCESSES \
		--path . \
		--force \
		--locked \
		--no-track \
		--target $CARGO_TARGET_NAME \
		--root $MCHS_PREFIX \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS

	# `cargo cinstall` refuses to work with Android
	cargo cbuild \
		--release \
		--prefix $MCHS_PREFIX \
		--jobs $MCHS_MAKE_PROCESSES \
		--frozen \
		--target $CARGO_TARGET_NAME \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS

	cd target/$CARGO_TARGET_NAME/release/
	mkdir -p $MCHS_PREFIX/include/rav1e/
	cp rav1e.h $MCHS_PREFIX/include/rav1e/
	mkdir -p $MCHS_PREFIX/lib/pkgconfig/
	cp rav1e.pc $MCHS_PREFIX/lib/pkgconfig/
	cp librav1e.a $MCHS_PREFIX/lib/
	cp librav1e.so $MCHS_PREFIX/lib/librav1e.so.$MCHS_PKG_VERSION
	ln -s librav1e.so.$MCHS_PKG_VERSION \
		$MCHS_PREFIX/lib/librav1e.so.${MCHS_PKG_VERSION%%.*}
	ln -s librav1e.so.$MCHS_PKG_VERSION $MCHS_PREFIX/lib/librav1e.so
}

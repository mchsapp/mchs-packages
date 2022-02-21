MCHS_PKG_HOMEPAGE=https://neovim.io/
MCHS_PKG_DESCRIPTION="Ambitious Vim-fork focused on extensibility and agility (nvim)"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6.1
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/neovim/neovim/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=dd882c21a52e5999f656cae3f336b5fc702d52addd4d9b5cd3dc39cfff35e864
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libiconv, libuv, luv, libmsgpack, libandroid-support, libvterm, libtermkey, libluajit, libunibilium, libtreesitter"
MCHS_PKG_HOSTBUILD=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_JEMALLOC=OFF
-DGETTEXT_MSGFMT_EXECUTABLE=$(command -v msgfmt)
-DGETTEXT_MSGMERGE_EXECUTABLE=$(command -v msgmerge)
-DGPERF_PRG=$MCHS_PKG_HOSTBUILD_DIR/deps/usr/bin/gperf
-DLUA_PRG=$MCHS_PKG_HOSTBUILD_DIR/deps/usr/bin/luajit
-DPKG_CONFIG_EXECUTABLE=$(command -v pkg-config)
-DXGETTEXT_PRG=$(command -v xgettext)
-DLUAJIT_INCLUDE_DIR=$MCHS_PREFIX/include/luajit-2.1
"
MCHS_PKG_CONFFILES="share/nvim/sysinit.vim"

_patch_luv() {
	# git submodule update --init deps/lua-compat-5.3 failed
	cp -r $1/build/src/lua-compat-5.3/* $1/build/src/luv/deps/lua-compat-5.3/
	cp -r $1/build/src/luajit/* $1/build/src/luv/deps/luajit/
	cp -r $1/build/src/libuv/* $1/build/src/luv/deps/libuv/
}

mchs_step_host_build() {
	mchs_setup_cmake

	MCHS_ORIGINAL_CMAKE=$(command -v cmake)
	if [ ! -f "$MCHS_ORIGINAL_CMAKE.orig" ]; then
		mv "$MCHS_ORIGINAL_CMAKE" "$MCHS_ORIGINAL_CMAKE.orig"
	fi
	cp "$MCHS_PKG_BUILDER_DIR/custom-bin/cmake" "$MCHS_ORIGINAL_CMAKE"
	chmod +x "$MCHS_ORIGINAL_CMAKE"
	export MCHS_ORIGINAL_CMAKE="$MCHS_ORIGINAL_CMAKE.orig"

	mkdir -p $MCHS_PKG_HOSTBUILD_DIR/deps
	cd $MCHS_PKG_HOSTBUILD_DIR/deps
	cmake $MCHS_PKG_SRCDIR/third-party

	make -j 1 \
	|| (_patch_luv $MCHS_PKG_HOSTBUILD_DIR/deps && make -j 1 )

	cd $MCHS_PKG_SRCDIR

	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$MCHS_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install \
	|| (_patch_luv $MCHS_PKG_SRCDIR/.deps && make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$MCHS_PKG_HOSTBUILD_DIR -DUSE_BUNDLED_LUAROCKS=ON" install)

	make distclean
	rm -Rf build/

	cd $MCHS_PKG_HOSTBUILD_DIR
}

mchs_step_pre_configure() {
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" -DLUA_MATH_LIBRARY=$MCHS_STANDALONE_TOOLCHAIN/sysroot/usr/lib/$MCHS_HOST_PLATFORM/$MCHS_PKG_API_LEVEL/libm.so"
}

mchs_step_post_make_install() {
	local _CONFIG_DIR=$MCHS_PREFIX/share/nvim
	mkdir -p $_CONFIG_DIR
	cp $MCHS_PKG_BUILDER_DIR/sysinit.vim $_CONFIG_DIR/
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/nvim 40
			update-alternatives --install \
				$MCHS_PREFIX/bin/vi vi $MCHS_PREFIX/bin/nvim 15
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/nvim
			update-alternatives --remove vi $MCHS_PREFIX/bin/nvim
		fi
	fi
	EOF
}

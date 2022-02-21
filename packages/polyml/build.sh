MCHS_PKG_HOMEPAGE=https://www.polyml.org/
MCHS_PKG_DESCRIPTION="A Standard ML implementation"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.9
MCHS_PKG_SRCURL=https://github.com/polyml/polyml/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=5aa452a49f2ac0278668772af4ea0b9bf30c93457e60ff7f264c5aec2023c83e
MCHS_PKG_DEPENDS="libc++, libffi, libgmp"
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-pic
--disable-native-codegeneration
"

mchs_step_host_build() {
	_PREFIX_FOR_BUILD=$MCHS_PKG_HOSTBUILD_DIR/prefix
	mkdir -p $_PREFIX_FOR_BUILD

	MCHS_ORIG_PATH=$PATH
	mkdir -p native
	pushd native
	export PATH=$(pwd):$MCHS_ORIG_PATH
	$MCHS_PKG_SRCDIR/configure \
		CC="gcc -m${MCHS_ARCH_BITS}" CXX="g++ -m${MCHS_ARCH_BITS}" \
		--prefix=$_PREFIX_FOR_BUILD \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS
	sed -i -e 's/^\(#define HOSTARCHITECTURE\)_X32 1/\1_X86 1/g' config.h
	make -j $MCHS_MAKE_PROCESSES
	make install
	popd

	local arch
	case "$MCHS_ARCH" in
		aarch64 )
			arch=AARCH64 ;;
		arm )
			arch=ARM ;;
		x86_64 )
			arch=X86_64 ;;
		i686 )
			arch=X86 ;;
		* )
			echo "ERROR: Unknown architecture: $MCHS_ARCH"
			return 1 ;;
	esac

	mkdir -p cross
	pushd cross
	export PATH=$_PREFIX_FOR_BUILD/bin:$MCHS_ORIG_PATH
	$MCHS_PKG_SRCDIR/configure \
		CC="gcc -m${MCHS_ARCH_BITS}" CXX="g++ -m${MCHS_ARCH_BITS}" \
		--prefix=$(pwd) \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS
	sed -i -e '/^#define HOSTARCHITECTURE_/d' config.h
	echo >> config.h
	echo "#define HOSTARCHITECTURE_${arch} 1" >> config.h
	make -j $MCHS_MAKE_PROCESSES -C libpolyml libpolyml.la
	make -j $MCHS_MAKE_PROCESSES polyimport
	make -j $MCHS_MAKE_PROCESSES -C libpolymain libpolymain.la
	make -j $MCHS_MAKE_PROCESSES poly
	export PATH=$(pwd):$MCHS_ORIG_PATH
	popd
}

mchs_step_pre_configure() {
	_NEED_DUMMY_LIBSTDCXX_SO=
	_LIBSTDCXX_SO=$MCHS_PREFIX/lib/libstdc++.so
	if [ ! -e $_LIBSTDCXX_SO ]; then
		_NEED_DUMMY_LIBSTDCXX_SO=true
		echo 'INPUT(-lc++_shared)' > $_LIBSTDCXX_SO
	fi
}

mchs_step_post_make_install() {
	if [ $_NEED_DUMMY_LIBSTDCXX_SO ]; then
		rm -f $_LIBSTDCXX_SO
	fi
}

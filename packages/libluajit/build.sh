MCHS_PKG_HOMEPAGE=https://luajit.org/
MCHS_PKG_DESCRIPTION="Just-In-Time Compiler for Lua"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:2.1.0-beta3
MCHS_PKG_REVISION=3
_COMMIT="787736990ac3b7d5ceaba2697c7d0f58f77bb782"
MCHS_PKG_SRCURL=https://github.com/LuaJIT/LuaJIT/archive/${_COMMIT}.tar.gz
MCHS_PKG_SHA256=2e3f74bc279f46cc463abfc67b36e69faaf0366237004771f4cac4bf2a9f5efb
MCHS_PKG_BREAKS="libluajit-dev"
MCHS_PKG_REPLACES="libluajit-dev"
MCHS_PKG_EXTRA_MAKE_ARGS="amalg PREFIX=$MCHS_PREFIX"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_LUAJIT_JIT_FOLDER_RELATIVE=share/luajit-${MCHS_PKG_VERSION:2:3}/jit

mchs_step_pre_configure() {
	# luajit wants same pointer size for host and target build
	export HOST_CC="gcc"
	if [ $MCHS_ARCH_BITS = "32" ]; then
		if [ $(uname) = "Linux" ]; then
			# NOTE: "apt install libc6-dev-i386" for 32-bit headers
			export HOST_CFLAGS="-m32"
			export HOST_LDFLAGS="-m32"
		elif [ $(uname) = "Darwin" ]; then
			export HOST_CFLAGS="-m32 -arch i386"
			export HOST_LDFLAGS="-arch i386"
		fi
	fi
	export TARGET_FLAGS="$CFLAGS $CPPFLAGS $LDFLAGS"
	export TARGET_SYS=Linux
	unset CFLAGS LDFLAGS
}

mchs_step_make_install () {
	mkdir -p $MCHS_PREFIX/include/luajit-${MCHS_PKG_VERSION:2:3}/
	cp -f $MCHS_PKG_SRCDIR/src/{lauxlib.h,lua.h,lua.hpp,luaconf.h,luajit.h,lualib.h} $MCHS_PREFIX/include/luajit-${MCHS_PKG_VERSION:2:3}/
	rm -f $MCHS_PREFIX/lib/libluajit*

	install -Dm600 $MCHS_PKG_SRCDIR/src/libluajit.so $MCHS_PREFIX/lib/libluajit-5.1.so.2.1.0
	install -Dm600 $MCHS_PKG_SRCDIR/src/libluajit.a $MCHS_PREFIX/lib/libluajit-5.1.a
	(cd $MCHS_PREFIX/lib;
		ln -s -f libluajit-5.1.so.2.1.0 libluajit.so;
		ln -s -f libluajit-5.1.so.2.1.0 libluajit-5.1.so;
		ln -s -f libluajit-5.1.so.2.1.0 libluajit-5.1.so.2;
		ln -s -f libluajit-5.1.a libluajit.a;)

	install -Dm600 $MCHS_PKG_SRCDIR/etc/luajit.1 $MCHS_PREFIX/share/man/man1/luajit.1
	install -Dm600 $MCHS_PKG_SRCDIR/etc/luajit.pc $MCHS_PREFIX/lib/pkgconfig/luajit.pc
	install -Dm700 $MCHS_PKG_SRCDIR/src/luajit $MCHS_PREFIX/bin/luajit

	# Files needed for the -b option (http://luajit.org/running.html) to work.
	# Note that they end up in the 'luajit' subpackage, not the 'libluajit' one.
	local MCHS_LUAJIT_JIT_FOLDER=$MCHS_PREFIX/$MCHS_LUAJIT_JIT_FOLDER_RELATIVE
	rm -Rf $MCHS_LUAJIT_JIT_FOLDER
	mkdir -p $MCHS_LUAJIT_JIT_FOLDER
	cp $MCHS_PKG_SRCDIR/src/jit/*lua $MCHS_LUAJIT_JIT_FOLDER
}

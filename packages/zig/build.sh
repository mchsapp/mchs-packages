MCHS_PKG_HOMEPAGE=https://ziglang.org
MCHS_PKG_DESCRIPTION="General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@leapofazzam123"
MCHS_PKG_VERSION=0.9.0
MCHS_PKG_SRCURL=https://ziglang.org/download/$MCHS_PKG_VERSION/zig-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=cd1be83b12f8269cc5965e59877b49fdd8fa638efb6995ac61eb4cea36a2e381
MCHS_PKG_DEPENDS="libandroid-spawn, libc++, libxml2, ncurses, zlib"
MCHS_PKG_BUILD_DEPENDS="llvm, libllvm-static"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DZIG_PREFER_CLANG_CPP_DYLIB=OFF
-DLLVM_LIBDIRS=$MCHS_PREFIX/lib
"

mchs_step_pre_configure() {
	mchs_setup_zig
	MCHS_PKG_EXTRA_CONFIGURE_ARGS+="
		-DZIG_EXECUTABLE=$(command -v zig)
		-DZIG_TARGET_TRIPLE=$ZIG_TARGET_NAME
		"
	LDFLAGS+=" -landroid-spawn -lncursesw -lxml2 -lz"
}

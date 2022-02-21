MCHS_PKG_HOMEPAGE=https://sites.google.com/site/fullycapable/
MCHS_PKG_DESCRIPTION="POSIX 1003.1e capabilities"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.60
MCHS_PKG_SRCURL=https://kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=06a92076ce39a78bd28089e32085f1bde7f3bfa448fad37d895c2358f760b2eb
MCHS_PKG_DEPENDS="attr"
MCHS_PKG_BREAKS="libcap-dev"
MCHS_PKG_REPLACES="libcap-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	make CC="$CC -Wl,-rpath=$MCHS_PREFIX/lib -Wl,--enable-new-dtags" OBJCOPY=llvm-objcopy PREFIX="$MCHS_PREFIX" PTHREADS=no
}

mchs_step_make_install() {
	make CC="$CC -Wl,-rpath=$MCHS_PREFIX/lib -Wl,--enable-new-dtags" OBJCOPY=llvm-objcopy prefix="$MCHS_PREFIX" RAISE_SETFCAP=no lib=/lib PTHREADS=no install
}

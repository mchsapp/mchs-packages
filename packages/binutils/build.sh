MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/binutils/
MCHS_PKG_DESCRIPTION="Collection of binary tools, the main ones being ld, the GNU linker, and as, the GNU assembler"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.38
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/binutils/binutils-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=e316477a914f567eccc34d5d29785b8b0f5a10208d36bbacedcc39048ecfe024
MCHS_PKG_DEPENDS="libc++, zlib"
MCHS_PKG_BREAKS="binutils-dev"
MCHS_PKG_REPLACES="binutils-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--enable-gold --enable-plugins --disable-werror --with-system-zlib --enable-new-dtags"
MCHS_PKG_EXTRA_MAKE_ARGS="tooldir=$MCHS_PREFIX"
MCHS_PKG_RM_AFTER_INSTALL="share/man/man1/windmc.1 share/man/man1/windres.1 bin/ld.bfd"
MCHS_PKG_NO_STATICSPLIT=true
MCHS_PKG_GROUPS="base-devel"

# Avoid linking against libfl.so from flex if available:
export LEXLIB=

mchs_step_pre_configure() {
	export CPPFLAGS="$CPPFLAGS -Wno-c++11-narrowing"

	if [ $MCHS_ARCH_BITS = 32 ]; then
		export LIB_PATH="${MCHS_PREFIX}/lib:/system/lib"
	else
		export LIB_PATH="${MCHS_PREFIX}/lib:/system/lib64"
	fi
}

mchs_step_post_make_install() {
	cp $MCHS_PKG_BUILDER_DIR/ldd $MCHS_PREFIX/bin/ldd
	cd $MCHS_PREFIX/bin
	# Setup symlinks as these are used when building, so used by
	# system setup in e.g. python, perl and libtool:
	for b in ar ld nm objdump ranlib readelf strip; do
		ln -s -f $b $MCHS_HOST_PLATFORM-$b
	done
	ln -sf ld.gold gold
}

MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/tar/
MCHS_PKG_DESCRIPTION="GNU tar for manipulating tar archives"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.34
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/tar/tar-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=63bebd26879c5e1eea4352f0d03c991f966aeb3ddeb3c7445c902568d5411d28
MCHS_PKG_DEPENDS="libandroid-glob, libiconv"
MCHS_PKG_ESSENTIAL=true

# When cross-compiling configure guesses that d_ino in struct dirent only exists
# if triplet matches linux*-gnu*, so we force set it explicitly:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="gl_cv_struct_dirent_d_ino=yes"
# this needed to disable tar's implementation of mkfifoat() so it is possible
# to use own implementation (see patch 'mkfifoat.patch').
MCHS_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_mkfifoat=yes"

mchs_step_pre_configure() {
	CPPFLAGS+=" -D__USE_FORTIFY_LEVEL=0"
	LDFLAGS+=" -landroid-glob"
}

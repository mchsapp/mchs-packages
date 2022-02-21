MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gdb/
MCHS_PKG_DESCRIPTION="The standard GNU Debugger that runs on many Unix-like systems and works for many programming languages"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=10.1
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/gdb/gdb-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=f82f1eceeec14a3afa2de8d9b0d3c91d5a3820e23e0a01bbb70ef9f0276b62c0
MCHS_PKG_DEPENDS="libc++, liblzma, libexpat, readline, ncurses, libmpfr, python, zlib, libthread-db"
MCHS_PKG_BREAKS="gdb-dev"
MCHS_PKG_REPLACES="gdb-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--with-system-readline
--with-curses
--with-python=$MCHS_PREFIX/bin/python
ac_cv_func_getpwent=no
ac_cv_func_getpwnam=no
"
MCHS_PKG_RM_AFTER_INSTALL="share/gdb/syscalls share/gdb/system-gdbinit"
MCHS_PKG_MAKE_INSTALL_TARGET="-C gdb install"

mchs_step_pre_configure() {
	# Fix "undefined reference to 'rpl_gettimeofday'" when building:
	export gl_cv_func_gettimeofday_clobber=no
	export gl_cv_func_gettimeofday_posix_signature=yes
	export gl_cv_func_realpath_works=yes
	export gl_cv_func_lstat_dereferences_slashed_symlink=yes
	export gl_cv_func_memchr_works=yes
	export gl_cv_func_stat_file_slash=yes
	export gl_cv_func_frexp_no_libm=no
	export gl_cv_func_strerror_0_works=yes
	export gl_cv_func_working_strerror=yes
	export gl_cv_func_getcwd_path_max=yes

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

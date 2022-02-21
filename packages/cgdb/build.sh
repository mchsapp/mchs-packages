MCHS_PKG_HOMEPAGE=https://cgdb.github.io/
MCHS_PKG_DESCRIPTION="A lightweight curses (terminal-based) interface to the GNU Debugger (GDB)"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.1
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://cgdb.me/files/cgdb-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bb723be58ec68cb59a598b8e24a31d10ef31e0e9c277a4de07b2f457fe7de198
MCHS_PKG_DEPENDS="libc++, ncurses, readline, gdb"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_ncursesw6_addnwstr=yes ac_cv_file__dev_ptmx=yes
ac_cv_func_setpgrp_void=true ac_cv_rl_version=7
ac_cv_file__proc_self_status=yes
"
MCHS_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"

MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/global/
MCHS_PKG_DESCRIPTION="Source code search and browse tools"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.6.8
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/global/global-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6f93d9732a07175817907d26640a90dc1009918e02be761bba09d1fa068357cd
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_posix1_2008_realpath=yes
--with-posix-sort=$MCHS_PREFIX/bin/sort
--with-ncurses=$MCHS_PREFIX
"
# coreutils provides the posix sort executable:
MCHS_PKG_DEPENDS="coreutils, ncurses, libltdl"

MCHS_PKG_HOMEPAGE=https://github.com/dimkr/loksh
MCHS_PKG_DESCRIPTION="A Linux port of OpenBSD's ksh"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
# Versions >6.7 fail with lots errors in NDK headers.
#
#  Example error:
#
#  In file included from ../src/subprojects/lolibc/include/sys/types.h:5:
#  /home/builder/.mchs-build/_cache/android-r20-api-24-v3/bin/../sysroot/usr/include/time.h:96:1: error: unknown type name 'clock_t'
#  clock_t clock(void);
#  ^
#  /home/builder/.mchs-build/_cache/android-r20-api-24-v3/bin/../sysroot/usr/include/time.h:100:25: error: unknown type name 'pid_t'
#  int clock_getcpuclockid(pid_t __pid, clockid_t* __clock) __INTRODUCED_IN(23);
MCHS_PKG_VERSION=6.6
MCHS_PKG_SRCURL=https://github.com/dimkr/loksh/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=97a020df82ceebe216c5a306e87360c5e3398d7403347aaff50978446ccb764d
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_HOMEPAGE=https://gitlab.com/procps-ng/procps
MCHS_PKG_DESCRIPTION="Utilities that give information about processes using the /proc filesystem"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.3.17
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://fossies.org/linux/misc/procps-ng-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=4518b3e7aafd34ec07d0063d250fd474999b20b200218c3ae56f5d2113f141b4
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BREAKS="procps-dev"
MCHS_PKG_REPLACES="procps-dev"
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_search_dlopen=
--enable-sigwinch
--disable-modern-top
--enable-watch8bit
"

mchs_step_pre_configure() {
	autoreconf -fi
}

# About kill: https://bugs.launchpad.net/ubuntu/+source/coreutils/+bug/141168:
# "For compatibility between distributions, can we have /bin/kill made available from coreutils?"
# About top: The system top works better.
MCHS_PKG_RM_AFTER_INSTALL="
bin/top share/man/man1/top.1
bin/kill share/man/man1/kill.1
bin/slabtop share/man/man1/slabtop.1
bin/w share/man/man1/w.1
"

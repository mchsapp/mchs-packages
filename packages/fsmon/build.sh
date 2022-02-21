MCHS_PKG_HOMEPAGE=https://github.com/nowsecure/fsmon
MCHS_PKG_DESCRIPTION="Filesystem monitor with fanotify and inotify backends"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.8.4
MCHS_PKG_SRCURL=https://github.com/nowsecure/fsmon/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=3e9ac1f20c76caf8d576535f21723419fe73bfe63178d306ea07f141f7dbaf0a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	make FANOTIFY_CFLAGS="-DHAVE_FANOTIFY=1 -DHAVE_SYS_FANOTIFY=0"
}

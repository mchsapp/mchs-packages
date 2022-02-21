MCHS_PKG_HOMEPAGE=https://github.com/rvoicilas/inotify-tools/wiki
MCHS_PKG_DESCRIPTION="Programs providing a simple interface to inotify"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.20.11.0
MCHS_PKG_SRCURL=https://github.com/rvoicilas/inotify-tools/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=58a3cde89e4a5111a87ac16b56b06a8f885460fca0aea51b69c856ce30a37a14
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BREAKS="inotify-tools-dev"
MCHS_PKG_REPLACES="inotify-tools-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	./autogen.sh
}

mchs_step_make() {
	:
}

mchs_step_make_install() {
	# the command-line tools needs the libinotifytools installed before building
	make -C libinotifytools install
	make install
}

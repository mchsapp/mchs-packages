MCHS_PKG_HOMEPAGE=https://jonas.github.io/tig/
MCHS_PKG_DESCRIPTION="Ncurses-based text-mode interface for git"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.5.5
MCHS_PKG_SRCURL=https://github.com/jonas/tig/releases/download/tig-$MCHS_PKG_VERSION/tig-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=24ba2c8beae889e6002ea7ced0e29851dee57c27fde8480fb9c64d5eb8765313
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="libiconv, ncurses, git, libandroid-support"

mchs_step_post_make_install() {
	make -j 1 install-doc
}

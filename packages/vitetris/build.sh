MCHS_PKG_HOMEPAGE=http://victornils.net/tetris/
MCHS_PKG_DESCRIPTION="Virtual terminal *tris clone"
MCHS_PKG_LICENSE="BSD 2-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_LICENSE_FILE="licence.txt"
MCHS_PKG_VERSION=0.59.1
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/vicgeralds/vitetris/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=699443df03c8d4bf2051838c1015da72039bbbdd0ab0eede891c59c840bdf58d
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_REMOVE_AFTER_INSTALL="share/applications/vitetris.desktop"
MCHS_PKG_GROUPS="games"

mchs_step_configure() {
	"$MCHS_PKG_SRCDIR/configure" \
		--prefix=$MCHS_PREFIX \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS
}

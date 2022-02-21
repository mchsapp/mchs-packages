MCHS_PKG_HOMEPAGE=https://www.eblong.com/zarf/glulx/
MCHS_PKG_DESCRIPTION="Interpreter for the Glulx portable VM for interactive fiction (IF) games"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=(0.5.4
                    1.0.4)
MCHS_PKG_REVISION=5
MCHS_PKG_SRCURL=(https://www.eblong.com/zarf/glulx/glulxe-${MCHS_PKG_VERSION[0]//.}.tar.gz
                   https://www.eblong.com/zarf/glk/glktermw-${MCHS_PKG_VERSION[1]//.}.tar.gz)
MCHS_PKG_SHA256=(1fc26f8aa31c880dbc7c396ede196c5d2cdff9bdefc6b192f320a96c5ef3376e
                   5968630b45e2fd53de48424559e3579db0537c460f4dc2631f258e1c116eb4ea)
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_GROUPS="games"

mchs_step_post_configure () {
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" PREFIX=$MCHS_PREFIX make -C glkterm
}

mchs_step_make_install () {
	install glulxe $MCHS_PREFIX/bin
}

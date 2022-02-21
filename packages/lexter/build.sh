MCHS_PKG_HOMEPAGE=https://www.kyne.com.au/~mark/software/lexter.php
MCHS_PKG_DESCRIPTION="A real-time word puzzle for text terminals"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=1.0.3
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://www.kyne.com.au/~mark/software/download/lexter-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b61a28fd5249b7d6c0df9be91c97c2acd00ccd9ad1e7b0c99808f6cdc96d5188
MCHS_PKG_DEPENDS="ncurses, gettext"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--datadir=$MCHS_PREFIX/share/lexter"
MCHS_PKG_GROUPS="games"

mchs_step_pre_configure() {
	autoreconf -vfi
}

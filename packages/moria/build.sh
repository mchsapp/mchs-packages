MCHS_PKG_HOMEPAGE=https://umoria.org
MCHS_PKG_DESCRIPTION="Rogue-like game with an infinite dungeon"
MCHS_PKG_LICENSE="GPL-3.0-or-later"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.7.15
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/dungeons-of-moria/umoria/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=97f76a68b856dd5df37c20fc57c8a51017147f489e8ee8866e1764778b2e2d57
MCHS_PKG_DEPENDS="libc++, ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-Dbuild_dir=$MCHS_PKG_BUILDDIR"
MCHS_PKG_GROUPS="games"

mchs_step_create_debscripts() {
    # Create scores file in a debscript, so an update to the package wouldn't erease any scores
    echo "mkdir -p $MCHS_PREFIX/lib/games/moria/" > postinst
    echo "touch $MCHS_PREFIX/lib/games/moria/scores.dat" >> postinst
    chmod 0755 postinst
}

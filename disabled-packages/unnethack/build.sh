# Crashes with "Dungeon description not valid"
MCHS_PKG_HOMEPAGE=http://sourceforge.net/apps/trac/unnethack
MCHS_PKG_DESCRIPTION="Dungeon crawling game, fork of NetHack"
MCHS_PKG_VERSION=5.1.0
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/unnethack/unnethack/${MCHS_PKG_VERSION}/unnethack-${MCHS_PKG_VERSION}-20131208.tar.gz
# --with-owner=$USER to avoid unnethack trying to use a "games" user, --with-groups to avoid "bin" group
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-owner=$USER --with-group=$(groups | cut -d ' ' -f 1)"
MCHS_PKG_DEPENDS="gsl, ncurses"

# unnethack builds util/{makedefs,lev_comp,dgn_comp} binaries which are later used during the build.
# we first build these host tools in $MCHS_PKG_TMPDIR/host-build and copy them into the ordinary
# cross compile tree after configure, bumping their modification time so that they do not get rebuilt.

CFLAGS="$CFLAGS $CPPFLAGS $LDFLAGS"
export LFLAGS="$LDFLAGS"
LD="$CC"

mchs_step_pre_configure() {
	# Create a host build for the makedefs binary
	mkdir $MCHS_PKG_TMPDIR/host-build
	cd $MCHS_PKG_TMPDIR/host-build
	ORIG_CC=$CC; export CC=gcc
	ORIG_CFLAGS=$CFLAGS; export CFLAGS=""
	ORIG_CPPFLAGS=$CPPFLAGS; export CPPFLAGS=""
	ORIG_CXXFLAGS=$CXXFLAGS; export CXXFLAGS=""
	ORIG_LDFLAGS=$LDFLAGS; export LDFLAGS=""
	ORIG_LFLAGS=$LFLAGS; export LFLAGS=""
	$MCHS_PKG_SRCDIR/configure --with-owner=$USER
	make
	make spec_levs
	make dungeon
	set +e
	make dlb
	set -e
	export CC=$ORIG_CC
	export CFLAGS=$ORIG_CFLAGS
	export CPPFLAGS=$ORIG_CPPFLAGS
	export CXXFLAGS=$ORIG_CXXFLAGS
	export LDFLAGS=$ORIG_LDFLAGS
	export LFLAGS=$ORIG_LFLAGS
}

mchs_step_post_configure() {
	# Use the host built makedefs
	cp $MCHS_PKG_TMPDIR/host-build/util/makedefs $MCHS_PKG_BUILDDIR/util/makedefs
	cp $MCHS_PKG_TMPDIR/host-build/util/lev_comp $MCHS_PKG_BUILDDIR/util/lev_comp
	cp $MCHS_PKG_TMPDIR/host-build/util/dgn_comp $MCHS_PKG_BUILDDIR/util/dgn_comp
	cp $MCHS_PKG_TMPDIR/host-build/util/dlb $MCHS_PKG_BUILDDIR/util/dlb
	# Update timestamp so the binary does not get rebuilt
	touch -d "next hour" $MCHS_PKG_BUILDDIR/util/makedefs $MCHS_PKG_BUILDDIR/util/lev_comp $MCHS_PKG_BUILDDIR/util/dgn_comp $MCHS_PKG_BUILDDIR/util/dlb
}

mchs_step_post_make_install() {
	# Add directory which must exist:
	mkdir -p $MCHS_PREFIX/var/unnethack/level
	echo "This directory stores locks" > $MCHS_PREFIX/var/unnethack/level/README
}

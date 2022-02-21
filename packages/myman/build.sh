MCHS_PKG_HOMEPAGE=https://sourceforge.net/projects/myman/
MCHS_PKG_DESCRIPTION="Video game for color and monochrome text terminals in the genre of Namco's Pac-Man"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=0.7.1
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://sourceforge.net/projects/myman/files/myman-cvs/myman-cvs-2009-10-30/myman-cvs-2009-10-30.tar.gz
MCHS_PKG_SHA256=253e22f26dc95c63388bc4cb81075a05f77f7709d1d64ed9fde7aae38a7fc962
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_HOSTBUILD=true
# myman is installed twice for no reason
MCHS_PKG_RM_AFTER_INSTALL="bin/myman-$MCHS_PKG_VERSION"
MCHS_PKG_GROUPS="games"

mchs_step_get_source() {
	cd $MCHS_PKG_CACHEDIR
	mchs_download "${MCHS_PKG_SRCURL}" "$(basename ${MCHS_PKG_SRCURL})" "${MCHS_PKG_SHA256}"
	tar -xf "$(basename ${MCHS_PKG_SRCURL})"
	mkdir -p $MCHS_PKG_SRCDIR
	cd $MCHS_PKG_SRCDIR
	cvs -d$MCHS_PKG_CACHEDIR/myman-cvs co -P myman
	mv myman/* .
}

mchs_step_host_build() {
	$MCHS_PKG_SRCDIR/configure
	make obj/s1game
}

mchs_step_post_configure() {
	mkdir -p obj
	cp $MCHS_PKG_HOSTBUILD_DIR/obj/s1game obj/
	touch -d "next hour" obj/s1game
}

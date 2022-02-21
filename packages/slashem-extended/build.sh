MCHS_PKG_HOMEPAGE=https://nethackwiki.com/wiki/Slash%27EM_Extended
MCHS_PKG_DESCRIPTION="A variant of SLASH'EM (a variant of NetHack)"
MCHS_PKG_LICENSE="Nethack"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.7.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/SLASHEM-Extended/SLASHEM-Extended/archive/refs/tags/slex-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=54d301bcb8d79d92030a30195f091e694f843d4656061dbce85730fc12023dee
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	for s in dgn lev; do
		ln -sf ${s}_comp.h include/${s}.tab.h
	done
	for f in alloc.c decl.c dlb.c drawing.c monst.c objects.c; do
		ln -sf ../src/$f util/$f
	done
}

mchs_step_make() {
	CFLAGS+=" -fcommon -DMAILPATH=\\\"/dev/null\\\""
	export CFLAGS_FOR_BUILD="-m${MCHS_ARCH_BITS} -O2 -fcommon"
	export LDFLAGS_FOR_BUILD="-m${MCHS_ARCH_BITS}"
	make -f sys/unix/GNUmakefile
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin "$MCHS_PKG_BUILDDIR/src/slex"
	install -Dm600 -t $MCHS_PREFIX/share/games/slex "$MCHS_PKG_BUILDDIR/dat/nhdat"
	install -Dm600 -t $MCHS_PREFIX/share/doc/slex "$MCHS_PKG_SRCDIR/dat/license"
}

mchs_step_create_debscripts() {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "mkdir -p $MCHS_PREFIX/var/games/slex" >> postinst
	echo "touch $MCHS_PREFIX/var/games/slex/perm" >> postinst
	echo "touch $MCHS_PREFIX/var/games/slex/record" >> postinst
	echo "mkdir -p $MCHS_PREFIX/var/games/slex/save" >> postinst
	echo "mkdir -p $MCHS_PREFIX/var/games/slex/unshare" >> postinst
	echo "exit 0" >> postinst
	chmod 0755 postinst
}

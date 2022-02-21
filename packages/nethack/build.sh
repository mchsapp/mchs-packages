MCHS_PKG_HOMEPAGE=http://www.nethack.org/
MCHS_PKG_DESCRIPTION="Dungeon crawl game"
MCHS_PKG_LICENSE="Nethack"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.6.6
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=http://www.nethack.org/download/${MCHS_PKG_VERSION}/nethack-${MCHS_PKG_VERSION//./}-src.tgz
MCHS_PKG_SHA256=cfde0c3ab6dd7c22ae82e1e5a59ab80152304eb23fb06e3129439271e5643ed2
MCHS_PKG_DEPENDS="gzip, ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_GROUPS="games"

mchs_step_host_build() {
	cp -r $MCHS_PKG_SRCDIR/* .
	pushd sys/unix
	sh setup.sh hints/linux
	popd && cd util
	if [ $MCHS_ARCH_BITS = 32 ]; then
		HOST_CC="gcc -m32"
	else
		HOST_CC="gcc"
	fi
	CFLAGS="" CC="$HOST_CC" LD="ld" make makedefs
	CFLAGS="" CC="$HOST_CC" LD="ld" make lev_comp
	CFLAGS="" CC="$HOST_CC" LD="ld" make dgn_comp dlb recover
}

mchs_step_pre_configure() {
	WINTTYLIB="$LDFLAGS -lcurses"
	export LFLAGS="$LDFLAGS"
	export CFLAGS="$CPPFLAGS $CFLAGS"
	cd sys/unix
	sh setup.sh hints/linux
}

mchs_step_post_configure() {
	# cp hostbuilt tools from hostbuild dir
	cp $MCHS_PKG_HOSTBUILD_DIR/util/{makedefs,lev_comp,dgn_comp,dlb} \
		util/
	touch -d "next hour" util/*
}

mchs_step_post_make_install() {
	cd doc
	mkdir -p $MCHS_PREFIX/share/man/man6
	install -m600 nethack.6 $MCHS_PREFIX/share/man/man6/
	ln -sf $MCHS_PREFIX/games/nethack $MCHS_PREFIX/bin/
}

mchs_step_create_debscripts() {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "mkdir -p $MCHS_PREFIX/games/nethackdir/save" >> postinst
	echo "exit 0" >> postinst
}

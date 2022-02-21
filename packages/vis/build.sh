MCHS_PKG_HOMEPAGE=https://www.brain-dump.org/projects/vis/
MCHS_PKG_DESCRIPTION="Modern, legacy free, simple yet efficient vim-like editor"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7
MCHS_PKG_SRCURL=https://github.com/martanne/vis/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=359ebb12a986b2f4e2a945567ad7587eb7d354301a5050ce10d51544570635eb
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="liblua53, libtermkey, lua-lpeg, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" -I$MCHS_PREFIX/include -I$MCHS_PREFIX/include/lua5.3"
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/vis 30
			update-alternatives --install \
				$MCHS_PREFIX/bin/vi vi $MCHS_PREFIX/bin/vis 10
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/vis
			update-alternatives --remove vi $MCHS_PREFIX/bin/vis
		fi
	fi
	EOF
}

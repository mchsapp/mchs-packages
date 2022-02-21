MCHS_PKG_HOMEPAGE=https://ne.di.unimi.it/
MCHS_PKG_DESCRIPTION="Easy-to-use and powerful text editor"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.3.0
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/vigna/ne/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=77a0c8e8564a29cd18069eebf04cee4855fae183f1e8f25d5fbb0c2651f07e6c
MCHS_PKG_DEPENDS="libandroid-support, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	export OPTS="$CFLAGS $CPPFLAGS"
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/ne 15
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/ne
		fi
	fi
	EOF
}

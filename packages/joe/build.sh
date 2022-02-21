MCHS_PKG_HOMEPAGE=http://joe-editor.sourceforge.net
MCHS_PKG_DESCRIPTION="Wordstar like text editor"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_CONFLICTS="jupp"
MCHS_PKG_VERSION=4.6
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://sourceforge.net/projects/joe-editor/files/JOE%20sources/joe-${MCHS_PKG_VERSION}/joe-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=495a0a61f26404070fe8a719d80406dc7f337623788e445b92a9f6de512ab9de
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-termcap"

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/joe 10
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/joe
		fi
	fi
	EOF
}

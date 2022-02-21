MCHS_PKG_HOMEPAGE=https://github.com/hboetes/mg
MCHS_PKG_DESCRIPTION="microscopic GNU Emacs-style editor"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=20180927
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/hboetes/mg/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=fbb09729ea00fe42dcdbc96ac7fc1d2b89eac651dec49e4e7af52fad4f5788f6
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d{8}"
MCHS_PKG_DEPENDS="libbsd, ncurses"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -fcommon"
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/mg 30
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/mg
		fi
	fi
	EOF
}

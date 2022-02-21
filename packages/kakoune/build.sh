MCHS_PKG_HOMEPAGE=https://github.com/mawww/kakoune
MCHS_PKG_DESCRIPTION="Code editor heavily inspired by Vim"
MCHS_PKG_LICENSE="Unlicense"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2021.11.08
MCHS_PKG_SRCURL=https://github.com/mawww/kakoune/releases/download/v$MCHS_PKG_VERSION/kakoune-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=aa30889d9da11331a243a8f40fe4f6a8619321b19217debac8f565e06eddb5f4
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS=" -C src debug=no "

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/kak 45
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/kak
		fi
	fi
	EOF
}

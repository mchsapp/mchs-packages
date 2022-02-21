MCHS_PKG_HOMEPAGE=https://www.nano-editor.org/
MCHS_PKG_DESCRIPTION="Small, free and friendly text editor"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=6.2
MCHS_PKG_SRCURL=https://nano-editor.org/dist/latest/nano-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=2bca1804bead6aaf4ad791f756e4749bb55ed860eec105a97fba864bc6a77cb3
MCHS_PKG_DEPENDS="libandroid-support, libandroid-glob, ncurses"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_pwd_h=no
--disable-libmagic
--enable-utf8
--with-wordbounds
"
MCHS_PKG_CONFFILES="etc/nanorc"
MCHS_PKG_RM_AFTER_INSTALL="bin/rnano share/man/man1/rnano.1 share/nano/man-html"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}

mchs_step_post_make_install() {
	# Configure nano to use syntax highlighting:
	NANORC=$MCHS_PREFIX/etc/nanorc
	echo include \"$MCHS_PREFIX/share/nano/\*nanorc\" > $NANORC
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/nano 20
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/nano
		fi
	fi
	EOF
}

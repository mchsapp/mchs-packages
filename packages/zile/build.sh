MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/zile/
MCHS_PKG_DESCRIPTION="Lightweight clone of the Emacs text editor"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4.15
MCHS_PKG_SRCURL=https://mirrors.kernel.org/gnu/zile/zile-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=39c300a34f78c37ba67793cf74685935a15568e14237a3a66fda8fcf40e3035e
MCHS_PKG_DEPENDS="libgc, ncurses"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_spawn_h=no
"

mchs_step_post_configure() {
	# zile uses help2man to build the zile.1 man page, which would require
	# a host build. To avoid that just copy a pre-built man page.
	cp $MCHS_PKG_BUILDER_DIR/zile.1 $MCHS_PKG_BUILDDIR/doc/zile.1
	touch -d "next hour" $MCHS_PKG_BUILDDIR/doc/zile.1*
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/zile 35
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/zile
		fi
	fi
	EOF
}

MCHS_PKG_HOMEPAGE=http://www.mirbsd.org/jupp.htm
MCHS_PKG_DESCRIPTION="User friendly full screen text editor"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.1jupp40
MCHS_PKG_SRCURL=http://www.mirbsd.org/MirOS/dist/jupp/joe-${MCHS_PKG_VERSION}.tgz
MCHS_PKG_SHA256=4bed439cde7f2be294e96e49ef3e913ea90fbe5e914db888403e3a27e8035b1a
MCHS_PKG_DEPENDS="ncurses"
MCHS_PKG_CONFLICTS="joe"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dependency-tracking
--disable-getpwnam
--disable-termcap
--disable-termidx
--enable-sysconfjoesubdir=/jupp
"

mchs_step_post_get_source() {
	chmod +x $MCHS_PKG_SRCDIR/configure
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/editor editor $MCHS_PREFIX/bin/jupp 10
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove editor $MCHS_PREFIX/bin/jupp
		fi
	fi
	EOF
}

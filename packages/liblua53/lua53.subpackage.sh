MCHS_SUBPKG_INCLUDE="bin/ share/man/man1/"
MCHS_SUBPKG_DESCRIPTION="Simple, extensible, embeddable programming language"
MCHS_SUBPKG_DEPENDS="readline"
MCHS_SUBPKG_BREAKS="lua (<< 5.3.5-6)"
MCHS_SUBPKG_REPLACES="lua (<< 5.3.5-6)"

mchs_step_create_subpkg_debscripts() {
	cat <<- EOF > ./postinst
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" = "configure" ] || [ "\$1" = "abort-upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --install \
				$MCHS_PREFIX/bin/lua lua $MCHS_PREFIX/bin/lua5.3 130
			update-alternatives --install \
				$MCHS_PREFIX/bin/luac luac $MCHS_PREFIX/bin/luac5.3 130
		fi
	fi
	EOF

	cat <<- EOF > ./prerm
	#!$MCHS_PREFIX/bin/sh
	if [ "$MCHS_PACKAGE_FORMAT" = "pacman" ] || [ "\$1" != "upgrade" ]; then
		if [ -x "$MCHS_PREFIX/bin/update-alternatives" ]; then
			update-alternatives --remove lua $MCHS_PREFIX/bin/lua
			update-alternatives --remove luac $MCHS_PREFIX/bin/luac
		fi
	fi
	EOF
}

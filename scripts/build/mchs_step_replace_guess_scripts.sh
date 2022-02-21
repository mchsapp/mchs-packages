mchs_step_replace_guess_scripts() {
	[ "$MCHS_PKG_METAPACKAGE" = "true" ] && return

	cd "$MCHS_PKG_SRCDIR"
	find . -name config.sub -exec chmod u+w '{}' \; -exec cp "$MCHS_SCRIPTDIR/scripts/config.sub" '{}' \;
	find . -name config.guess -exec chmod u+w '{}' \; -exec cp "$MCHS_SCRIPTDIR/scripts/config.guess" '{}' \;
}

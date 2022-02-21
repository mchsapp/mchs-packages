mchs_step_handle_hostbuild() {
	[ "$MCHS_PKG_METAPACKAGE" = "true" ] && return
	[ "$MCHS_PKG_HOSTBUILD" = "false" ] && return

	cd "$MCHS_PKG_SRCDIR"
	for patch in $MCHS_PKG_BUILDER_DIR/*.patch.beforehostbuild; do
		echo "Applying patch: $(basename $patch)"
		test -f "$patch" && sed "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" "$patch" | patch --silent -p1
	done

	if [ ! -f "$MCHS_HOSTBUILD_MARKER" ]; then
		rm -Rf "$MCHS_PKG_HOSTBUILD_DIR"
		mkdir -p "$MCHS_PKG_HOSTBUILD_DIR"
		cd "$MCHS_PKG_HOSTBUILD_DIR"
		mchs_step_host_build
		touch "$MCHS_HOSTBUILD_MARKER"
	fi
}

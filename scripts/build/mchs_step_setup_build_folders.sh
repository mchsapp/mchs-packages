mchs_step_setup_build_folders() {
	# Following directories may contain files with read-only
	# permissions which makes them undeletable. We need to fix
	# that.
	[ -d "$MCHS_PKG_BUILDDIR" ] && chmod +w -R "$MCHS_PKG_BUILDDIR" || true
	[ -d "$MCHS_PKG_SRCDIR" ] && chmod +w -R "$MCHS_PKG_SRCDIR" || true
	if [ "$MCHS_SKIP_DEPCHECK" = false ] && \
		   [ "$MCHS_INSTALL_DEPS" = true ] && \
		   [ "$MCHS_PKG_METAPACKAGE" = false ] && \
		   [ "$MCHS_NO_CLEAN" = false ] && \
		   [ "$MCHS_ON_DEVICE_BUILD" = false ]; then
		# Remove all previously extracted/built files from
		# $MCHS_PREFIX:
		rm -rf $MCHS_PREFIX
		rm -f $MCHS_BUILT_PACKAGES_DIRECTORY/*
	fi

	# Cleanup old build state:
	rm -Rf "$MCHS_PKG_BUILDDIR" \
		"$MCHS_PKG_SRCDIR"

	# Cleanup old packaging state:
	rm -Rf "$MCHS_PKG_PACKAGEDIR" \
		"$MCHS_PKG_TMPDIR" \
		"$MCHS_PKG_MASSAGEDIR"

	# Ensure folders present (but not $MCHS_PKG_SRCDIR, it will
	# be created in build)
	mkdir -p "$MCHS_COMMON_CACHEDIR" \
		 "$MCHS_COMMON_CACHEDIR-$MCHS_ARCH" \
		 "$MCHS_COMMON_CACHEDIR-all" \
		 "$MCHS_OUTPUT_DIR" \
		 "$MCHS_PKG_BUILDDIR" \
		 "$MCHS_PKG_PACKAGEDIR" \
		 "$MCHS_PKG_TMPDIR" \
		 "$MCHS_PKG_CACHEDIR" \
		 "$MCHS_PKG_MASSAGEDIR" \
		 $MCHS_PREFIX/{bin,etc,lib,libexec,share,share/LICENSES,tmp,include}
}

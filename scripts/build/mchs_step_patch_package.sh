mchs_step_patch_package() {
	[ "$MCHS_PKG_METAPACKAGE" = "true" ] && return

	cd "$MCHS_PKG_SRCDIR"
	# Suffix patch with ".patch32" or ".patch64" to only apply for
	# these bitnesses
	local PATCHES=$(find $MCHS_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 \
			     -name \*.patch -o -name \*.patch$MCHS_ARCH_BITS | sort)
	local DEBUG_PATCHES=""
	if [ "$MCHS_DEBUG_BUILD" = "true" ]; then
		DEBUG_PATCHES=$(find $MCHS_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name \*.patch.debug | sort)
	fi
	local ON_DEVICE_PATCHES=""
	# .patch.ondevice patches should only be applied when building
	# on device
	if [ "$MCHS_ON_DEVICE_BUILD" = "true" ]; then
		ON_DEVICE_PATCHES=$(find $MCHS_PKG_BUILDER_DIR -mindepth 1 -maxdepth 1 -name \*.patch.ondevice | sort)
	fi
	shopt -s nullglob
	for patch in $PATCHES $DEBUG_PATCHES $ON_DEVICE_PATCHES; do
		echo "Applying patch: $(basename $patch)"
		test -f "$patch" && sed \
			-e "s%\@MCHS_APP_PACKAGE\@%${MCHS_APP_PACKAGE}%g" \
			-e "s%\@MCHS_BASE_DIR\@%${MCHS_BASE_DIR}%g" \
			-e "s%\@MCHS_CACHE_DIR\@%${MCHS_CACHE_DIR}%g" \
			-e "s%\@MCHS_HOME\@%${MCHS_ANDROID_HOME}%g" \
			-e "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" \
			"$patch" | patch --silent -p1
	done
	shopt -u nullglob
}

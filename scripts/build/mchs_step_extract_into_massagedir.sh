mchs_step_extract_into_massagedir() {
	local TARBALL_ORIG=$MCHS_PKG_PACKAGEDIR/${MCHS_PKG_NAME}_orig.tar.gz

	# Build diff tar with what has changed during the build:
	cd $MCHS_PREFIX
	tar -N "$MCHS_BUILD_TS_FILE" \
		--exclude='lib/libutil.so' --exclude='tmp' \
		-czf "$TARBALL_ORIG" .

	# Extract tar in order to massage it
	mkdir -p "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"
	cd "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX"
	tar xf "$TARBALL_ORIG"
	rm "$TARBALL_ORIG"
}

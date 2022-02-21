mchs_step_create_timestamp_file() {
	# Keep track of when build started so we can see what files
	# have been created.  We start by sleeping so that any
	# generated files (such as zlib.pc) get an older timestamp
	# than the MCHS_BUILD_TS_FILE.
	sleep 1
	MCHS_BUILD_TS_FILE=$MCHS_PKG_TMPDIR/timestamp_$MCHS_PKG_NAME
	touch "$MCHS_BUILD_TS_FILE"
}

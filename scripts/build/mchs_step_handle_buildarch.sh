mchs_step_handle_buildarch() {
	[ "$MCHS_ON_DEVICE_BUILD" = "true" ] && return

	# If $MCHS_PREFIX already exists, it may have been built for a different arch
	local MCHS_ARCH_FILE=/data/MCHS_ARCH
	if [ -f "${MCHS_ARCH_FILE}" ]; then
		local MCHS_PREVIOUS_ARCH
		MCHS_PREVIOUS_ARCH=$(cat $MCHS_ARCH_FILE)
		if [ "$MCHS_PREVIOUS_ARCH" != "$MCHS_ARCH" ]; then
			local MCHS_DATA_BACKUPDIRS=$MCHS_TOPDIR/_databackups
			mkdir -p "$MCHS_DATA_BACKUPDIRS"
			local MCHS_DATA_PREVIOUS_BACKUPDIR=$MCHS_DATA_BACKUPDIRS/$MCHS_PREVIOUS_ARCH
			local MCHS_DATA_CURRENT_BACKUPDIR=$MCHS_DATA_BACKUPDIRS/$MCHS_ARCH
			# Save current /data (removing old backup if any)
			if test -e "$MCHS_DATA_PREVIOUS_BACKUPDIR"; then
				mchs_error_exit "Directory already exists"
			fi
			if [ -d /data/data ]; then
				mv /data/data "$MCHS_DATA_PREVIOUS_BACKUPDIR"
			fi
			# Restore new one (if any)
			if [ -d "$MCHS_DATA_CURRENT_BACKUPDIR" ]; then
				mv "$MCHS_DATA_CURRENT_BACKUPDIR" /data/data
			fi
		fi
	fi

	# Keep track of current arch we are building for.
	echo "$MCHS_ARCH" > $MCHS_ARCH_FILE
}

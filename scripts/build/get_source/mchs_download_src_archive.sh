mchs_download_src_archive() {
	local PKG_SRCURL=(${MCHS_PKG_SRCURL[@]})
	local PKG_SHA256=(${MCHS_PKG_SHA256[@]})
	if  [ ! ${#PKG_SRCURL[@]} == ${#PKG_SHA256[@]} ] && [ ! ${#PKG_SHA256[@]} == 0 ]; then
		mchs_error_exit "Error: length of MCHS_PKG_SRCURL isn't equal to length of MCHS_PKG_SHA256."
	fi

	for i in $(seq 0 $(( ${#PKG_SRCURL[@]}-1 ))); do
		local file="$MCHS_PKG_CACHEDIR/$(basename "${PKG_SRCURL[$i]}")"
		if [ "${PKG_SHA256[$i]}" == "" ]; then
			mchs_download "${PKG_SRCURL[$i]}" "$file"
		else
			mchs_download "${PKG_SRCURL[$i]}" "$file" "${PKG_SHA256[$i]}"
		fi
	done
}

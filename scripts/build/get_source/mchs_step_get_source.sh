mchs_step_get_source() {
	: "${MCHS_PKG_SRCURL:=""}"

	if [ "${MCHS_PKG_SRCURL: -4}" == ".git" ]; then
		mchs_git_clone_src
	else
		if [ -z "${MCHS_PKG_SRCURL}" ] || [ "${MCHS_PKG_SKIP_SRC_EXTRACT-false}" = "true" ] || [ "$MCHS_PKG_METAPACKAGE" = "true" ]; then
			mkdir -p "$MCHS_PKG_SRCDIR"
			return
		fi
		mchs_download_src_archive
		cd $MCHS_PKG_TMPDIR
		mchs_extract_src_archive
	fi
}

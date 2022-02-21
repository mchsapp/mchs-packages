mchs_step_finish_build() {
	printf "\033[0;34m[McHs]\033[0m - Build Of \033[0;32m$MCHS_PKG_NAME\033[0m Done\n"
	test -t 1 && printf "\033]0;%s - DONE\007" "$MCHS_PKG_NAME"

	mkdir -p "$MCHS_BUILT_PACKAGES_DIRECTORY"
	echo "$MCHS_PKG_FULLVERSION" > "$MCHS_BUILT_PACKAGES_DIRECTORY/$MCHS_PKG_NAME"
	
	#Upload file on server then delete file
	bash $MCHS_SCRIPTDIR/upload-remove.sh
	
	exit 0
}

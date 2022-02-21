mchs_step_configure_autotools() {
	if [ ! -e "$MCHS_PKG_SRCDIR/configure" ]; then return; fi

	local ENABLE_STATIC="--enable-static"
	if [ "$MCHS_PKG_EXTRA_CONFIGURE_ARGS" != "${MCHS_PKG_EXTRA_CONFIGURE_ARGS/--disable-static/}" ]; then
		ENABLE_STATIC=""
	fi

	local DISABLE_NLS="--disable-nls"
	if [ "$MCHS_PKG_EXTRA_CONFIGURE_ARGS" != "${MCHS_PKG_EXTRA_CONFIGURE_ARGS/--enable-nls/}" ]; then
		# Do not --disable-nls if package explicitly enables it (for gettext itself)
		DISABLE_NLS=""
	fi

	local ENABLE_SHARED="--enable-shared"
	if [ "$MCHS_PKG_EXTRA_CONFIGURE_ARGS" != "${MCHS_PKG_EXTRA_CONFIGURE_ARGS/--disable-shared/}" ]; then
		ENABLE_SHARED=""
	fi

	local HOST_FLAG="--host=$MCHS_HOST_PLATFORM"
	if [ "$MCHS_PKG_EXTRA_CONFIGURE_ARGS" != "${MCHS_PKG_EXTRA_CONFIGURE_ARGS/--host=/}" ]; then
		HOST_FLAG=""
	fi

	local LIBEXEC_FLAG="--libexecdir=$MCHS_PREFIX/libexec"
	if [ "$MCHS_PKG_EXTRA_CONFIGURE_ARGS" != "${MCHS_PKG_EXTRA_CONFIGURE_ARGS/--libexecdir=/}" ]; then
		LIBEXEC_FLAG=""
	fi

	local QUIET_BUILD=
	if [ "$MCHS_QUIET_BUILD" = true ]; then
		QUIET_BUILD="--enable-silent-rules --silent --quiet"
	fi

	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
		# Some packages provides a $PKG-config script which some configure scripts pickup instead of pkg-config:
		mkdir "$MCHS_PKG_TMPDIR/config-scripts"
		for f in $MCHS_PREFIX/bin/*config; do
			test -f "$f" && cp "$f" "$MCHS_PKG_TMPDIR/config-scripts"
		done
		export PATH=$MCHS_PKG_TMPDIR/config-scripts:$PATH
	fi

	# Avoid gnulib wrapping of functions when cross compiling. See
	# http://wiki.osdev.org/Cross-Porting_Software#Gnulib
	# https://gitlab.com/sortix/sortix/wikis/Gnulib
	# https://github.com/mchs/mchs-packages/issues/76
	local AVOID_GNULIB=""
	AVOID_GNULIB+=" ac_cv_func_nl_langinfo=yes"
	AVOID_GNULIB+=" ac_cv_func_calloc_0_nonnull=yes"
	AVOID_GNULIB+=" ac_cv_func_chown_works=yes"
	AVOID_GNULIB+=" ac_cv_func_getgroups_works=yes"
	AVOID_GNULIB+=" ac_cv_func_malloc_0_nonnull=yes"
	AVOID_GNULIB+=" ac_cv_func_posix_spawn=no"
	AVOID_GNULIB+=" ac_cv_func_posix_spawnp=no"
	AVOID_GNULIB+=" ac_cv_func_realloc_0_nonnull=yes"
	AVOID_GNULIB+=" am_cv_func_working_getline=yes"
	AVOID_GNULIB+=" gl_cv_func_dup2_works=yes"
	AVOID_GNULIB+=" gl_cv_func_fcntl_f_dupfd_cloexec=yes"
	AVOID_GNULIB+=" gl_cv_func_fcntl_f_dupfd_works=yes"
	AVOID_GNULIB+=" gl_cv_func_fnmatch_posix=yes"
	AVOID_GNULIB+=" gl_cv_func_getcwd_abort_bug=no"
	AVOID_GNULIB+=" gl_cv_func_getcwd_null=yes"
	AVOID_GNULIB+=" gl_cv_func_getcwd_path_max=yes"
	AVOID_GNULIB+=" gl_cv_func_getcwd_posix_signature=yes"
	AVOID_GNULIB+=" gl_cv_func_gettimeofday_clobber=no"
	AVOID_GNULIB+=" gl_cv_func_gettimeofday_posix_signature=yes"
	AVOID_GNULIB+=" gl_cv_func_link_works=yes"
	AVOID_GNULIB+=" gl_cv_func_lstat_dereferences_slashed_symlink=yes"
	AVOID_GNULIB+=" gl_cv_func_malloc_0_nonnull=yes"
	AVOID_GNULIB+=" gl_cv_func_memchr_works=yes"
	AVOID_GNULIB+=" gl_cv_func_mkdir_trailing_dot_works=yes"
	AVOID_GNULIB+=" gl_cv_func_mkdir_trailing_slash_works=yes"
	AVOID_GNULIB+=" gl_cv_func_mkfifo_works=yes"
	AVOID_GNULIB+=" gl_cv_func_mknod_works=yes"
	AVOID_GNULIB+=" gl_cv_func_realpath_works=yes"
	AVOID_GNULIB+=" gl_cv_func_select_detects_ebadf=yes"
	AVOID_GNULIB+=" gl_cv_func_snprintf_posix=yes"
	AVOID_GNULIB+=" gl_cv_func_snprintf_retval_c99=yes"
	AVOID_GNULIB+=" gl_cv_func_snprintf_truncation_c99=yes"
	AVOID_GNULIB+=" gl_cv_func_stat_dir_slash=yes"
	AVOID_GNULIB+=" gl_cv_func_stat_file_slash=yes"
	AVOID_GNULIB+=" gl_cv_func_strerror_0_works=yes"
	AVOID_GNULIB+=" gl_cv_func_strtold_works=yes"
	AVOID_GNULIB+=" gl_cv_func_symlink_works=yes"
	AVOID_GNULIB+=" gl_cv_func_tzset_clobber=no"
	AVOID_GNULIB+=" gl_cv_func_unlink_honors_slashes=yes"
	AVOID_GNULIB+=" gl_cv_func_unlink_honors_slashes=yes"
	AVOID_GNULIB+=" gl_cv_func_vsnprintf_posix=yes"
	AVOID_GNULIB+=" gl_cv_func_vsnprintf_zerosize_c99=yes"
	AVOID_GNULIB+=" gl_cv_func_wcrtomb_works=yes"
	AVOID_GNULIB+=" gl_cv_func_wcwidth_works=yes"
	AVOID_GNULIB+=" gl_cv_func_working_getdelim=yes"
	AVOID_GNULIB+=" gl_cv_func_working_mkstemp=yes"
	AVOID_GNULIB+=" gl_cv_func_working_mktime=yes"
	AVOID_GNULIB+=" gl_cv_func_working_strerror=yes"
	AVOID_GNULIB+=" gl_cv_header_working_fcntl_h=yes"
	AVOID_GNULIB+=" gl_cv_C_locale_sans_EILSEQ=yes"

	# NOTE: We do not want to quote AVOID_GNULIB as we want word expansion.
	# shellcheck disable=SC2086
	env $AVOID_GNULIB "$MCHS_PKG_SRCDIR/configure" \
		--disable-dependency-tracking \
		--prefix=$MCHS_PREFIX \
		--libdir=$MCHS_PREFIX/lib \
		--sbindir=$MCHS_PREFIX/bin \
		--disable-rpath --disable-rpath-hack \
		$HOST_FLAG \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS \
		$DISABLE_NLS \
		$ENABLE_SHARED \
		$ENABLE_STATIC \
		$LIBEXEC_FLAG \
		$QUIET_BUILD \
		|| (cat config.log && false)
}

mchs_step_override_config_scripts() {
	if [ "$MCHS_ON_DEVICE_BUILD" == true ] || [ "$MCHS_INSTALL_DEPS" == false ]; then
		return
	fi

	if [ "$MCHS_PKG_DEPENDS" != "${MCHS_PKG_DEPENDS/libllvm/}" ]; then
		LLVM_DEFAULT_TARGET_TRIPLE=$MCHS_HOST_PLATFORM
		if [ $MCHS_ARCH = "arm" ]; then
			LLVM_TARGET_ARCH=ARM
		elif [ $MCHS_ARCH = "aarch64" ]; then
			LLVM_TARGET_ARCH=AArch64
		elif [ $MCHS_ARCH = "i686" ]; then
			LLVM_TARGET_ARCH=X86
		elif [ $MCHS_ARCH = "x86_64" ]; then
			LLVM_TARGET_ARCH=X86
		fi
		LIBLLVM_VERSION=$(. $MCHS_SCRIPTDIR/packages/libllvm/build.sh; echo $MCHS_PKG_VERSION)
		sed $MCHS_SCRIPTDIR/packages/libllvm/llvm-config.in \
			-e "s|@MCHS_PKG_VERSION@|$LIBLLVM_VERSION|g" \
			-e "s|@MCHS_PREFIX@|$MCHS_PREFIX|g" \
			-e "s|@MCHS_PKG_SRCDIR@|$MCHS_TOPDIR/libllvm/src|g" \
			-e "s|@LLVM_TARGET_ARCH@|$LLVM_TARGET_ARCH|g" \
			-e "s|@LLVM_DEFAULT_TARGET_TRIPLE@|$LLVM_DEFAULT_TARGET_TRIPLE|g" \
			-e "s|@MCHS_ARCH@|$MCHS_ARCH|g" > $MCHS_PREFIX/bin/llvm-config
		chmod 755 $MCHS_PREFIX/bin/llvm-config
	fi

	if [ "$MCHS_PKG_DEPENDS" != "${MCHS_PKG_DEPENDS/postgresql/}" ]; then
		local postgresql_version=$(. $MCHS_SCRIPTDIR/packages/postgresql/build.sh; echo $MCHS_PKG_VERSION)
		sed $MCHS_SCRIPTDIR/packages/postgresql/pg_config.in \
			-e "s|@POSTGRESQL_VERSION@|$postgresql_version|g" \
			-e "s|@MCHS_HOST_PLATFORM@|$MCHS_HOST_PLATFORM|g" \
			-e "s|@MCHS_PREFIX@|$MCHS_PREFIX|g" > $MCHS_PREFIX/bin/pg_config
		chmod 755 $MCHS_PREFIX/bin/pg_config
	fi
}

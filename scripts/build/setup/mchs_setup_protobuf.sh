mchs_setup_protobuf() {
	local _PROTOBUF_VERSION=$(bash -c ". $MCHS_SCRIPTDIR/packages/libprotobuf/build.sh; echo \${MCHS_PKG_VERSION:2}")
	local _PROTOBUF_ZIP=protoc-$_PROTOBUF_VERSION-linux-x86_64.zip
	local _PROTOBUF_FOLDER

	if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
		_PROTOBUF_FOLDER=${MCHS_SCRIPTDIR}/build-tools/protobuf-${_PROTOBUF_VERSION}
	else
		_PROTOBUF_FOLDER=${MCHS_COMMON_CACHEDIR}/protobuf-${_PROTOBUF_VERSION}
	fi

	if [ "$MCHS_ON_DEVICE_BUILD" = "false" ]; then
		if [ ! -d "$_PROTOBUF_FOLDER" ]; then
			mchs_download \
				https://github.com/protocolbuffers/protobuf/releases/download/v$_PROTOBUF_VERSION/$_PROTOBUF_ZIP \
				$MCHS_PKG_TMPDIR/$_PROTOBUF_ZIP \
				e7acbd3f3477c593cee58cd995490c0f95dcb4058dd4677d015535fc20a372f3

			rm -Rf "$MCHS_PKG_TMPDIR/protoc-$_PROTOBUF_VERSION-linux-x86_64"
			unzip $MCHS_PKG_TMPDIR/$_PROTOBUF_ZIP -d $MCHS_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION
			mv "$MCHS_PKG_TMPDIR/protobuf-$_PROTOBUF_VERSION" \
				$_PROTOBUF_FOLDER
		fi

		export PATH=$_PROTOBUF_FOLDER/bin/:$PATH
	fi
}

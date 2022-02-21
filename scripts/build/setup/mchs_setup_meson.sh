mchs_setup_meson() {
	mchs_setup_ninja
	local MESON_VERSION=0.61.1
	local MESON_FOLDER

	if [ "${MCHS_PACKAGES_OFFLINE-false}" = "true" ]; then
		MESON_FOLDER=${MCHS_SCRIPTDIR}/build-tools/meson-${MESON_VERSION}
	else
		MESON_FOLDER=${MCHS_COMMON_CACHEDIR}/meson-${MESON_VERSION}
	fi

	if [ ! -d "$MESON_FOLDER" ]; then
		local MESON_TAR_NAME=meson-$MESON_VERSION.tar.gz
		local MESON_TAR_FILE=$MCHS_PKG_TMPDIR/$MESON_TAR_NAME
		local MESON_TMP_FOLDER=$MCHS_PKG_TMPDIR/meson-$MESON_VERSION
		mchs_download \
			"https://github.com/mesonbuild/meson/releases/download/$MESON_VERSION/meson-$MESON_VERSION.tar.gz" \
			"$MESON_TAR_FILE" \
			feb2cefb325b437dbf36146df7c6b87688ddff0b0205caa31dc64055c6da410c
		tar xf "$MESON_TAR_FILE" -C "$MCHS_PKG_TMPDIR"
		if [ "$MESON_VERSION" = "0.61.1" ]; then
			local MESON_0_61_1_GTKDOC_PATCH_FILE=$MCHS_PKG_TMPDIR/meson-0.61.1-gtkdoc.patch
			mchs_download \
				"https://github.com/mesonbuild/meson/pull/9841/commits/a5c479cebfcc9c909631df404fb127e4270260a3.diff" \
				"$MESON_0_61_1_GTKDOC_PATCH_FILE" \
				1fbcbe899e99264823dc4ef380271b71a022eda261472f15fd2b241d55b33dcd
			patch --silent -p1 -d "$MESON_TMP_FOLDER" < "$MESON_0_61_1_GTKDOC_PATCH_FILE"
		fi
		mv "$MESON_TMP_FOLDER" "$MESON_FOLDER"
	fi
	MCHS_MESON="$MESON_FOLDER/meson.py"
	MCHS_MESON_CROSSFILE=$MCHS_PKG_TMPDIR/meson-crossfile-$MCHS_ARCH.txt
	local MESON_CPU MESON_CPU_FAMILY
	if [ "$MCHS_ARCH" = "arm" ]; then
		MESON_CPU_FAMILY="arm"
		MESON_CPU="armv7"
	elif [ "$MCHS_ARCH" = "i686" ]; then
		MESON_CPU_FAMILY="x86"
		MESON_CPU="i686"
	elif [ "$MCHS_ARCH" = "x86_64" ]; then
		MESON_CPU_FAMILY="x86_64"
		MESON_CPU="x86_64"
	elif [ "$MCHS_ARCH" = "aarch64" ]; then
		MESON_CPU_FAMILY="aarch64"
		MESON_CPU="aarch64"
	else
		mchs_error_exit "Unsupported arch: $MCHS_ARCH"
	fi

	local CONTENT=""
	echo "[binaries]" > $MCHS_MESON_CROSSFILE
	echo "ar = '$AR'" >> $MCHS_MESON_CROSSFILE
	echo "c = '$CC'" >> $MCHS_MESON_CROSSFILE
	echo "cpp = '$CXX'" >> $MCHS_MESON_CROSSFILE
	echo "ld = '$LD'" >> $MCHS_MESON_CROSSFILE
	echo "pkgconfig = '$PKG_CONFIG'" >> $MCHS_MESON_CROSSFILE
	echo "strip = '$STRIP'" >> $MCHS_MESON_CROSSFILE

	echo '' >> $MCHS_MESON_CROSSFILE
	echo "[properties]" >> $MCHS_MESON_CROSSFILE
	echo "needs_exe_wrapper = true" >> $MCHS_MESON_CROSSFILE

	echo '' >> $MCHS_MESON_CROSSFILE
	echo "[built-in options]" >> $MCHS_MESON_CROSSFILE

	echo -n "c_args = [" >> $MCHS_MESON_CROSSFILE
	local word first=true
	for word in $CFLAGS $CPPFLAGS; do
		if [ "$first" = "true" ]; then
			first=false
		else
			echo -n ", " >> $MCHS_MESON_CROSSFILE
		fi
		echo -n "'$word'" >> $MCHS_MESON_CROSSFILE
	done
	echo ']' >> $MCHS_MESON_CROSSFILE

	echo -n "cpp_args = [" >> $MCHS_MESON_CROSSFILE
	local word first=true
	for word in $CXXFLAGS $CPPFLAGS; do
		if [ "$first" = "true" ]; then
			first=false
		else
			echo -n ", " >> $MCHS_MESON_CROSSFILE
		fi
		echo -n "'$word'" >> $MCHS_MESON_CROSSFILE
	done
	echo ']' >> $MCHS_MESON_CROSSFILE

	local property
	for property in c_link_args cpp_link_args; do
		echo -n "$property = [" >> $MCHS_MESON_CROSSFILE
		first=true
		for word in $LDFLAGS; do
			if [ "$first" = "true" ]; then
				first=false
			else
				echo -n ", " >> $MCHS_MESON_CROSSFILE
			fi
			echo -n "'$word'" >> $MCHS_MESON_CROSSFILE
		done
		echo ']' >> $MCHS_MESON_CROSSFILE
	done

	echo '' >> $MCHS_MESON_CROSSFILE
	echo "[host_machine]" >> $MCHS_MESON_CROSSFILE
	echo "cpu_family = '$MESON_CPU_FAMILY'" >> $MCHS_MESON_CROSSFILE
	echo "cpu = '$MESON_CPU'" >> $MCHS_MESON_CROSSFILE
	echo "endian = 'little'" >> $MCHS_MESON_CROSSFILE
	echo "system = 'android'" >> $MCHS_MESON_CROSSFILE
}

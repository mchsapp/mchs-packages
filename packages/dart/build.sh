MCHS_PKG_HOMEPAGE=https://www.dartlang.org/
MCHS_PKG_DESCRIPTION="Dart is a general-purpose programming language"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_LICENSE_FILE="sdk/LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.16.1
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_SKIP_SRC_EXTRACT=true

# Dart uses tar and gzip to extract downloaded packages.
# Busybox-based versions of such utilities cause issues so
# complete ones should be used.
MCHS_PKG_DEPENDS="gzip, tar"

mchs_step_get_source() {
	mkdir -p $MCHS_PKG_SRCDIR
	cd $MCHS_PKG_SRCDIR

	git clone --depth=1 https://chromium.googlesource.com/chromium/tools/depot_tools.git
	mkdir -p depot_tools/fakebin
	ln -sfr /usr/bin/python2 depot_tools/fakebin/python
	export PATH="$(pwd)/depot_tools/fakebin:$(pwd)/depot_tools:${PATH}"

	fetch dart

	cd sdk
	git checkout $MCHS_PKG_VERSION
	cd ../

	echo "target_os = ['android']" >> .gclient
	gclient sync -D --force --reset
}

mchs_step_pre_configure() {
	sed -i -e 's:\([^A-Za-z0-9_]\)/usr/bin:\1'$MCHS_PREFIX'/local/bin:g' \
		-e 's:\([^A-Za-z0-9_]\)/bin:\1'$MCHS_PREFIX'/bin:g' \
		"$MCHS_PKG_SRCDIR/sdk/third_party/pkg/pub/lib/src/io.dart"
}

mchs_step_make() {
	:
}

mchs_step_make_install() {
	cd sdk

	rm -f ./out/*/args.gn

	if [ $MCHS_ARCH = "arm" ]; then
		python2 ./tools/build.py --no-goma --mode release --arch=arm --os=android create_sdk
		chmod +x ./out/ReleaseAndroidARM/dart-sdk/bin/*
		cp -r ./out/ReleaseAndroidARM/dart-sdk ${MCHS_PREFIX}/lib
	elif [ $MCHS_ARCH = "i686" ]; then
		python2 ./tools/build.py --no-goma --mode release --arch=ia32 --os=android create_sdk
		chmod +x ./out/ReleaseAndroidIA32/dart-sdk/bin/*
		cp -r ./out/ReleaseAndroidIA32/dart-sdk ${MCHS_PREFIX}/lib
	elif [ $MCHS_ARCH = "aarch64" ]; then
		python2 ./tools/build.py --no-goma --mode release --arch=arm64c --os=android create_sdk
		chmod +x ./out/ReleaseAndroidARM64C/dart-sdk/bin/*
		cp -r ./out/ReleaseAndroidARM64C/dart-sdk ${MCHS_PREFIX}/lib
	elif [ $MCHS_ARCH = "x86_64" ]; then
		python2 ./tools/build.py --no-goma --mode release --arch=x64c --os=android create_sdk
		chmod +x ./out/ReleaseAndroidX64C/dart-sdk/bin/*
		cp -r ./out/ReleaseAndroidX64C/dart-sdk ${MCHS_PREFIX}/lib
	else
		mchs_error_exit "Unsupported arch '$MCHS_ARCH'"
	fi

	for file in ${MCHS_PREFIX}/lib/dart-sdk/bin/*; do
		if [[ -f "$file" ]]; then
			echo -e "#!${MCHS_PREFIX}/bin/sh\nexec $file  \"\$@\"" > ${MCHS_PREFIX}/bin/$(basename $file)
			chmod +x ${MCHS_PREFIX}/bin/$(basename $file)
		fi
	done
}

mchs_step_post_make_install() {
	install -Dm600 $MCHS_PKG_BUILDER_DIR/dart-pub-bin.sh \
		$MCHS_PREFIX/etc/profile.d/dart-pub-bin.sh
}

MCHS_PKG_HOMEPAGE=https://ibotpeaches.github.io/Apktool/
MCHS_PKG_DESCRIPTION="A tool for reverse engineering 3rd party, closed, binary Android apps"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.6.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/iBotPeaches/Apktool/archive/refs/tags/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=74739cdb1434ca35ec34e51ca7272ad3f378ae3ed0a2d5805d9a2fab5016037f
MCHS_PKG_DEPENDS="aapt, aapt2, openjdk-17"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	local prebuilt_dir="brut.apktool/apktool-lib/src/main/resources/prebuilt"
	rm -rf $prebuilt_dir/{linux,macosx,windows}
	mkdir -p $prebuilt_dir/linux
	for exe_name in aapt aapt2; do
		local exe_path=$prebuilt_dir/linux/${exe_name}
		$CC $CFLAGS $CPPFLAGS aapt-wrapper/${exe_name}-wrapper.c \
			-o ${exe_path} $LDFLAGS
		$STRIP --strip-unneeded ${exe_path}
		$MCHS_ELF_CLEANER ${exe_path}
		cp -a ${exe_path} ${exe_path}_64
	done
}

mchs_step_make() {
	sh gradlew build shadowJar -x test
}

mchs_step_make_install() {
	install -Dm600 brut.apktool/apktool-cli/build/libs/apktool-cli-all.jar \
		$MCHS_PREFIX/share/java/apktool.jar
	cat <<- EOF > $MCHS_PREFIX/bin/apktool
	#!${MCHS_PREFIX}/bin/sh
	exec java -jar $MCHS_PREFIX/share/java/apktool.jar "\$@"
	EOF
	chmod 700 $MCHS_PREFIX/bin/apktool
}

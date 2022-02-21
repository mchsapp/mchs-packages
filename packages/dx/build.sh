MCHS_PKG_HOMEPAGE=http://developer.android.com/tools/help/index.html
MCHS_PKG_DESCRIPTION="Command which takes in Java class files and converts them to format executable by Dalvik VM"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:1.16
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://github.com/mchs/distfiles/releases/download/2021.01.04/dx-android-${MCHS_PKG_VERSION:2}.jar
MCHS_PKG_SHA256=b9b7917267876b74c8ff6707e7a576c93b6dfe8cacc4f1cc791d606bcbbb7bd5
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	mchs_download "$MCHS_PKG_SRCURL" \
		"$MCHS_PKG_CACHEDIR/dx-${MCHS_PKG_VERSION:2}.jar" \
		"$MCHS_PKG_SHA256"

	install -Dm600 "$MCHS_PKG_CACHEDIR/dx-${MCHS_PKG_VERSION:2}.jar" \
		"$MCHS_PREFIX"/share/dex/dx.jar

	cat <<- EOF > "$MCHS_PREFIX"/bin/dx
	#!${MCHS_PREFIX}/bin/sh
	exec dalvikvm \
		-Xcompiler-option --compiler-filter=speed \
		-Xmx256m \
		-cp ${MCHS_PREFIX}/share/dex/dx.jar \
		dx.dx.command.Main "\$@"
	EOF
	chmod 700 "$MCHS_PREFIX"/bin/dx

	cat <<- EOF > "$MCHS_PREFIX"/bin/dx-merge
	#!${MCHS_PREFIX}/bin/sh
	exec dalvikvm \
		-Xcompiler-option --compiler-filter=speed \
		-Xmx256m \
		-cp ${MCHS_PREFIX}/share/dex/dx.jar \
		dx.dx.merge.DexMerger "\$@"
	EOF
	chmod 700 "$MCHS_PREFIX"/bin/dx-merge
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${MCHS_PREFIX}/bin/bash
	rm -f $MCHS_PREFIX/share/dex/oat/*/dx.{art,oat,odex,vdex} >/dev/null 2>&1
	exit 0
	EOF
}

MCHS_PKG_HOMEPAGE=http://www.eclipse.org/jdt/core/
MCHS_PKG_DESCRIPTION="Eclipse Compiler for Java"
MCHS_PKG_LICENSE="EPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
# Version 4.12 is the last known to work on Android 7-8.
_VERSION=4.12
_DATE=201906051800
MCHS_PKG_VERSION=1:${_VERSION}
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=http://archive.eclipse.org/eclipse/downloads/drops${_VERSION:0:1}/R-${_VERSION}-${_DATE}/ecj-${_VERSION}.jar
MCHS_PKG_SHA256=69dad18a1fcacd342a7d44c5abf74f50e7529975553a24c64bce0b29b86af497
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_CONFLICTS="ecj4.6"

RAW_JAR=$MCHS_PKG_CACHEDIR/ecj-${_VERSION}.jar

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

mchs_step_get_source() {
	mkdir -p $MCHS_PKG_SRCDIR
	mchs_download $MCHS_PKG_SRCURL \
		$RAW_JAR \
		$MCHS_PKG_SHA256
}

mchs_step_make() {
	mkdir -p $MCHS_PREFIX/share/{dex,java}
	$MCHS_D8 \
		--classpath $ANDROID_HOME/platforms/android-$MCHS_PKG_API_LEVEL/android.jar \
		--release \
		--min-api $MCHS_PKG_API_LEVEL \
		--output $MCHS_PKG_TMPDIR \
		$RAW_JAR

	# Package classes.dex into jar:
	cd $MCHS_PKG_TMPDIR
	jar cf ecj.jar classes.dex
	# Add needed properties file to jar file:
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/batch/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/batch/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/problem/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/problem/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/messages.properties
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/messages.properties
	jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/parser/readableNames.props
	jar uf ecj.jar	org/eclipse/jdt/internal/compiler/parser/readableNames.props
	for i in $(seq 1 24); do
		jar xf $RAW_JAR org/eclipse/jdt/internal/compiler/parser/parser$i.rsc
		jar uf ecj.jar	org/eclipse/jdt/internal/compiler/parser/parser$i.rsc
	done
	# Move into place:
	mv ecj.jar $MCHS_PREFIX/share/dex/ecj.jar

	rm -rf android-jar
	mkdir android-jar
	cd android-jar

	# We need the android classes for JDT to compile against.
	cp $ANDROID_HOME/platforms/android-28/android.jar .
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android.jar .

	cp $MCHS_PKG_TMPDIR/android-jar/android.jar $MCHS_PREFIX/share/java/android.jar

	# Bundle in an android.jar from an older API also, for those who want to
	# build apps that run on older Android versions.
	rm -Rf ./*
	cp $ANDROID_HOME/platforms/android-$MCHS_PKG_API_LEVEL/android.jar android.jar
	unzip -q android.jar
	rm -Rf android.jar resources.arsc res assets
	jar cfM android-$MCHS_PKG_API_LEVEL.jar .
	cp $MCHS_PKG_TMPDIR/android-jar/android-$MCHS_PKG_API_LEVEL.jar $MCHS_PREFIX/share/java/

	rm -Rf $MCHS_PREFIX/bin/javac
	install $MCHS_PKG_BUILDER_DIR/ecj $MCHS_PREFIX/bin/ecj
	perl -p -i -e "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" $MCHS_PREFIX/bin/ecj
	install $MCHS_PKG_BUILDER_DIR/ecj-$MCHS_PKG_API_LEVEL $MCHS_PREFIX/bin/ecj-$MCHS_PKG_API_LEVEL
	perl -p -i -e "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" $MCHS_PREFIX/bin/ecj-$MCHS_PKG_API_LEVEL
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!${MCHS_PREFIX}/bin/bash
	rm -f $MCHS_PREFIX/share/dex/oat/*/ecj.{art,oat,odex,vdex} >/dev/null 2>&1
	exit 0
	EOF
}

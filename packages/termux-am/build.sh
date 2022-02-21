MCHS_PKG_HOMEPAGE=https://github.com/mchs/McHsAm
MCHS_PKG_DESCRIPTION="Android Oreo-compatible am command reimplementation"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="Michal Bednarski @michalbednarski"
MCHS_PKG_VERSION=0.4
MCHS_PKG_SRCURL=https://github.com/mchs/McHsAm/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f13e7de6682b2a8303ac69e6a908fc7bd2ae091b3941eb33ecc35f47ea77a435
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_CONFLICTS="mchs-tools (<< 0.51)"
_GRADLE_VERSION=6.5.1

mchs_step_make() {
	# Download and use a new enough gradle version to avoid the process hanging after running:
	mchs_download \
		https://services.gradle.org/distributions/gradle-$_GRADLE_VERSION-bin.zip \
		$MCHS_PKG_CACHEDIR/gradle-$_GRADLE_VERSION-bin.zip \
		50a7d30529fa939721fe9268a0205142f3f2302bcac5fb45b27a3902e58db54a
	mkdir $MCHS_PKG_TMPDIR/gradle
	unzip -q $MCHS_PKG_CACHEDIR/gradle-$_GRADLE_VERSION-bin.zip -d $MCHS_PKG_TMPDIR/gradle

	# Avoid spawning the gradle daemon due to org.gradle.jvmargs
	# being set (https://github.com/gradle/gradle/issues/1434):
	rm gradle.properties

	export ANDROID_HOME
	export GRADLE_OPTS="-Dorg.gradle.daemon=false -Xmx1536m"

	$MCHS_PKG_TMPDIR/gradle/gradle-$_GRADLE_VERSION/bin/gradle \
		:app:assembleRelease
}

mchs_step_make_install() {
	cp $MCHS_PKG_SRCDIR/am-libexec-packaged $MCHS_PREFIX/bin/am
	mkdir -p $MCHS_PREFIX/libexec/mchs-am
	cp $MCHS_PKG_SRCDIR/app/build/outputs/apk/release/app-release-unsigned.apk $MCHS_PREFIX/libexec/mchs-am/am.apk
}

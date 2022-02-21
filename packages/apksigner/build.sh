MCHS_PKG_HOMEPAGE=https://developer.android.com/studio/command-line/apksigner
MCHS_PKG_DESCRIPTION="APK signing tool from Android SDK"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=${MCHS_ANDROID_BUILD_TOOLS_VERSION}
MCHS_PKG_REVISION=5
MCHS_PKG_DEPENDS="openjdk-17"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_SKIP_SRC_EXTRACT=true

mchs_step_pre_configure() {
	# Requires Android SDK, not available on device
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not available for on-device builds."
	fi
}

mchs_step_make_install() {
	install -Dm600 $ANDROID_HOME/build-tools/${MCHS_PKG_VERSION}/lib/apksigner.jar \
		$MCHS_PREFIX/share/java/apksigner.jar
	cat <<- EOF > $MCHS_PREFIX/bin/apksigner
	#!${MCHS_PREFIX}/bin/sh
	exec java -jar $MCHS_PREFIX/share/java/apksigner.jar "\$@"
	EOF
	chmod 700 $MCHS_PREFIX/bin/apksigner
}

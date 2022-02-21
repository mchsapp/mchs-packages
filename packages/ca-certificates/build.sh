MCHS_PKG_HOMEPAGE=https://curl.se/docs/caextract.html
MCHS_PKG_DESCRIPTION="Common CA certificates"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1:2021-10-26
MCHS_PKG_SRCURL=https://curl.se/ca/cacert-${MCHS_PKG_VERSION:2}.pem
# If the checksum has changed, it may be time to update the package version:
MCHS_PKG_SHA256=ae31ecb3c6e9ff3154cb7a55f017090448f88482f0e94ac927c0c67a1f33b9cf
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	local CERTDIR=$MCHS_PREFIX/etc/tls
	local CERTFILE=$CERTDIR/cert.pem

	mkdir -p $CERTDIR

	mchs_download $MCHS_PKG_SRCURL \
		$CERTFILE \
		$MCHS_PKG_SHA256
	touch $CERTFILE

	# Build java keystore which is split out into a ca-certificates-java subpackage:
	local KEYUTIL_JAR=$MCHS_PKG_CACHEDIR/keyutil-0.4.0.jar
	mchs_download \
		https://github.com/use-sparingly/keyutil/releases/download/0.4.0/keyutil-0.4.0.jar \
		$KEYUTIL_JAR \
		18f1d2c82839d84949b1ad015343c509e81ef678c24db6112acc6c0761314610

	local JAVA_KEYSTORE_DIR=$MCHS_PREFIX/opt/openjdk-17/lib/security
	mkdir -p $JAVA_KEYSTORE_DIR

	java -jar $KEYUTIL_JAR \
		--import \
		--new-keystore $JAVA_KEYSTORE_DIR/jssecacerts \
		--password changeit \
		--force-new-overwrite \
		--import-pem-file $CERTFILE
}

MCHS_PKG_HOMEPAGE=https://www.privoxy.org
MCHS_PKG_DESCRIPTION="Non-caching web proxy with advanced filtering capabilities"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.0.32
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://www.privoxy.org/sf-download-mirror/Sources/$MCHS_PKG_VERSION%20%28stable%29/privoxy-$MCHS_PKG_VERSION-stable-src.tar.gz
MCHS_PKG_SHA256=c61de4008c62445ec18f1f270407cbf2372eaba93beaccdc9e3238bb2defeed7
# McHs-services adds the run scripts to MCHS_PKG_CONFFILES. Those ones can not be copied in mchs_step_post_massage so setup special variable for that
DEFAULT_CONFFILES='etc/privoxy/config etc/privoxy/match-all.action etc/privoxy/trust etc/privoxy/user.action etc/privoxy/user.filter etc/privoxy/default.action etc/privoxy/default.filter'
MCHS_PKG_CONFFILES=$DEFAULT_CONFFILES
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_pcreposix_regcomp=no
--sysconfdir=$MCHS_PREFIX/etc/privoxy
"
MCHS_PKG_DEPENDS="pcre, libpcreposix, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_SERVICE_SCRIPT=("privoxy" "if [ -f \"$MCHS_ANDROID_HOME/.config/privoxy/config\" ]; then CONFIG=\"$MCHS_ANDROID_HOME/.config/privoxy/config\"; else CONFIG=\"$MCHS_PREFIX/etc/privoxy/config\"; fi\nexec privoxy --no-daemon \$CONFIG 2>&1")

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi

    autoheader
    autoconf
}

mchs_step_post_massage() {
    # copy default config files
    for f in $DEFAULT_CONFFILES; do
	cp "$MCHS_PKG_SRCDIR/$(basename $f)" "$MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/$f"
    done
}

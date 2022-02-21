MCHS_PKG_HOMEPAGE=https://transmissionbt.com/
MCHS_PKG_DESCRIPTION="Easy, lean and powerful BitTorrent client"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.00
MCHS_PKG_GIT_BRANCH=$MCHS_PKG_VERSION
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://github.com/transmission/transmission.git
MCHS_PKG_DEPENDS="libcurl, libevent, miniupnpc, openssl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-gtk --enable-lightweight --cache-file=mchs_configure.cache"
# transmission already puts timestamps in the info printed to stdout so no need for svlogd -tt,
# therefore we override the transmission/log run script
MCHS_PKG_SERVICE_SCRIPT=(
	"transmission" 'exec transmission-daemon -f 2>&1'
	"transmission/log" 'mkdir -p "$LOGDIR/sv/transmission"\nexec svlogd "$LOGDIR/sv/transmission"'
)

mchs_step_pre_configure() {
	CFLAGS+=" -D_POSIX_C_SOURCE=200809L"
	./autogen.sh

	echo "ac_cv_func_getmntent=no" >> mchs_configure.cache
	echo "ac_cv_search_getmntent=false" >> mchs_configure.cache
	chmod a-w mchs_configure.cache
}

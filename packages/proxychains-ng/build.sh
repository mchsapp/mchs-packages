MCHS_PKG_HOMEPAGE=https://github.com/rofl0r/proxychains-ng
MCHS_PKG_DESCRIPTION="A hook preloader that allows to redirect TCP traffic of existing dynamically linked programs through one or more SOCKS or HTTP proxies"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.14
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/rofl0r/proxychains-ng/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=ab31626af7177cc2669433bb244b99a8f98c08031498233bb3df3bcc9711a9cc
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

mchs_step_post_make_install() {
	# Remove conf file from previous build, otherwise nothing will be done and it won't be included in the package
	rm -f "$MCHS_PREFIX"/etc/proxychains.conf
	make install-config
}

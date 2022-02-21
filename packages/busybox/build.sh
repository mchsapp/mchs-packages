MCHS_PKG_HOMEPAGE=https://busybox.net/
MCHS_PKG_DESCRIPTION="Tiny versions of many common UNIX utilities into a single small executable"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.33.1
MCHS_PKG_REVISION=6
MCHS_PKG_SRCURL=https://busybox.net/downloads/busybox-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=12cec6bd2b16d8a9446dd16130f2b92982f1819f6e1c5f5887b6db03f5660d28
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_SERVICE_SCRIPT=(
	"telnetd" 'exec busybox telnetd -F'
	"ftpd" "exec busybox tcpsvd -vE 0.0.0.0 8021 busybox ftpd -w $MCHS_ANDROID_HOME"
	"busybox-httpd" "exec busybox httpd -f -p 0.0.0.0:8080 -h $MCHS_PREFIX/srv/www/ 2>&1"
)

mchs_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $MCHS_PREFIX.
	if $MCHS_ON_DEVICE_BUILD; then
		mchs_error_exit "Package '$MCHS_PKG_NAME' is not safe for on-device builds."
	fi
}

mchs_step_configure() {
	# Prevent spamming logs with useless warnings to make them more readable.
	CFLAGS+=" -Wno-ignored-optimization-argument -Wno-unused-command-line-argument"

	sed -e "s|@MCHS_PREFIX@|$MCHS_PREFIX|g" \
		-e "s|@MCHS_SYSROOT@|$MCHS_STANDALONE_TOOLCHAIN/sysroot|g" \
		-e "s|@MCHS_HOST_PLATFORM@|${MCHS_HOST_PLATFORM}|g" \
		-e "s|@MCHS_CFLAGS@|$CFLAGS|g" \
		-e "s|@MCHS_LDFLAGS@|$LDFLAGS|g" \
		-e "s|@MCHS_LDLIBS@|log|g" \
		$MCHS_PKG_BUILDER_DIR/busybox.config > .config

	unset CFLAGS LDFLAGS
	make oldconfig
}

mchs_step_post_make_install() {
	if $MCHS_DEBUG_BUILD; then
		install -Dm700 busybox_unstripped $MCHS_PREFIX/bin/busybox
	fi

	# Install busybox man page.
	install -Dm600 -t $MCHS_PREFIX/share/man/man1 $MCHS_PKG_SRCDIR/docs/busybox.1
}

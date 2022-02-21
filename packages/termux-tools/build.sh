MCHS_PKG_HOMEPAGE=https://mchs.com/
MCHS_PKG_DESCRIPTION="Basic system tools for McHs"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.162
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_ESSENTIAL=true
MCHS_PKG_BREAKS="mchs-keyring (<< 1.9)"
MCHS_PKG_CONFLICTS="procps (<< 3.3.15-2)"
MCHS_PKG_SUGGESTS="mchs-api"
MCHS_PKG_CONFFILES="
etc/motd
etc/motd-playstore
etc/mchs-login.sh
"

# Some of these packages are not dependencies and used only to ensure
# that core packages are installed after upgrading (we removed busybox
# from essentials).
MCHS_PKG_DEPENDS="bzip2, coreutils, curl, dash, diffutils, findutils, gawk, grep, gzip, less, procps, psmisc, sed, tar, mchs-am, mchs-am-socket, mchs-exec, util-linux, xz-utils, dialog"

# Optional packages that are distributed as part of bootstrap archives.
MCHS_PKG_RECOMMENDS="ed, dos2unix, inetutils, net-tools, patch, unzip"

mchs_step_make_install() {
	# Remove LD_LIBRARY_PATH from environment to avoid conflicting
	# with system libraries that system binaries may link against:
	for tool in df getprop logcat mount ping ping6 pm settings top umount cmd; do
		WRAPPER_FILE=$MCHS_PREFIX/bin/$tool
		echo '#!/bin/sh' > $WRAPPER_FILE
		echo 'unset LD_LIBRARY_PATH LD_PRELOAD' >> $WRAPPER_FILE
		# Some tools require having /system/bin/app_process in the PATH,
		# at least am&pm on a Nexus 6p running Android 6.0:
		echo -n 'PATH=$PATH:/system/bin ' >> $WRAPPER_FILE
		echo "exec /system/bin/$tool \"\$@\"" >> $WRAPPER_FILE
		chmod +x $WRAPPER_FILE
	done

	for script in chsh dalvikvm login pkg su mchs-fix-shebang mchs-backup \
		mchs-info mchs-open mchs-open-url mchs-reload-settings \
		mchs-reset mchs-restore mchs-setup-storage mchs-wake-lock \
		mchs-wake-unlock mchs-change-repo; do
			install -Dm700 $MCHS_PKG_BUILDER_DIR/$script $MCHS_PREFIX/bin/$script
			sed -i -e "s%\@MCHS_APP_PACKAGE\@%${MCHS_APP_PACKAGE}%g" \
				-e "s%\@MCHS_BASE_DIR\@%${MCHS_BASE_DIR}%g" \
				-e "s%\@MCHS_CACHE_DIR\@%${MCHS_CACHE_DIR}%g" \
				-e "s%\@MCHS_HOME\@%${MCHS_ANDROID_HOME}%g" \
				-e "s%\@MCHS_PREFIX\@%${MCHS_PREFIX}%g" \
				-e "s%\@PACKAGE_VERSION\@%${MCHS_PKG_VERSION}%g" \
				-e "s%\@MCHS_PACKAGE_FORMAT\@%${MCHS_PACKAGE_FORMAT}%g" \
				$MCHS_PREFIX/bin/$script
	done

	install -Dm600 $MCHS_PKG_BUILDER_DIR/motd $MCHS_PREFIX/etc/motd
	install -Dm600 $MCHS_PKG_BUILDER_DIR/motd-playstore $MCHS_PREFIX/etc/motd-playstore
	ln -sfr $MCHS_PREFIX/bin/mchs-open $MCHS_PREFIX/bin/xdg-open

	mkdir -p $MCHS_PREFIX/share/man/man1
	sed -e "s|@MCHS_PREFIX@|${MCHS_PREFIX}|g" -e "s|@MCHS_HOME@|${MCHS_ANDROID_HOME}|g" \
		$MCHS_PKG_BUILDER_DIR/mchs.1.md.in > $MCHS_PKG_TMPDIR/mchs.1.md
	pandoc --standalone --to man --output $MCHS_PREFIX/share/man/man1/mchs.1 \
		$MCHS_PKG_TMPDIR/mchs.1.md

	mkdir -p $MCHS_PREFIX/share/examples/mchs
	install -Dm600 $MCHS_PKG_BUILDER_DIR/mchs.properties $MCHS_PREFIX/share/examples/mchs/

	mkdir -p $MCHS_PREFIX/etc/profile.d
	cat <<- EOF > $MCHS_PREFIX/etc/profile.d/init-mchs-properties.sh
	if [ ! -f $MCHS_ANDROID_HOME/.config/mchs/mchs.properties ] && [ ! -e $MCHS_ANDROID_HOME/.mchs/mchs.properties ]; then
		mkdir -p $MCHS_ANDROID_HOME/.mchs
		cp $MCHS_PREFIX/share/examples/mchs/mchs.properties $MCHS_ANDROID_HOME/.mchs/
	fi
	EOF

	cat <<- EOF > $MCHS_PREFIX/etc/mchs-login.sh
	##
	## This script is sourced by $PREFIX/bin/login before executing shell.
	##
	EOF
}

MCHS_PKG_HOMEPAGE=https://github.com/mchs/proot-distro
MCHS_PKG_DESCRIPTION="McHs official utility for managing proot'ed Linux distributions"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.0.0
MCHS_PKG_SRCURL=https://github.com/mchs/proot-distro/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=7e60744146463ba095ca9aca3af62da4df29d4364a7142e2087861567f6eeee7
MCHS_PKG_DEPENDS="bash, bzip2, coreutils, curl, findutils, gzip, ncurses-utils, proot (>= 5.1.107-32), sed, tar, xz-utils"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true


mchs_step_make_install() {
	env MCHS_APP_PACKAGE="$MCHS_APP_PACKAGE" \
		MCHS_PREFIX="$MCHS_PREFIX" \
		MCHS_ANDROID_HOME="$MCHS_ANDROID_HOME" \
		./install.sh
}

mchs_step_create_debscripts() {
	cat <<- EOF > ./preinst
	#!${MCHS_PREFIX}/bin/bash
	set -e
	shopt -s nullglob

	for i in ${MCHS_PREFIX}/etc/proot-distro/*.sh; do
	  if ! grep -qP "^\s*TARBALL_URL" "\$i"; then
	    echo "Disabling old style v1.x proot-distro plug-in: \$(basename "\$i")"
	    mv -f "\${i}" "\${i}.bak"
	  fi
	done

	exit 0
	EOF
}

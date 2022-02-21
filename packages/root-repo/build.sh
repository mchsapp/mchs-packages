MCHS_PKG_HOMEPAGE=https://github.com/mchs/mchs-root-packages
MCHS_PKG_DESCRIPTION="Package repository containing programs for rooted devices"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_VERSION=2.0
MCHS_PKG_DEPENDS="mchs-keyring"
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make_install() {
	mkdir -p $MCHS_PREFIX/etc/apt/sources.list.d
	echo "deb https://packages.mchs.org/apt/mchs-root root stable" > $MCHS_PREFIX/etc/apt/sources.list.d/root.list
}

mchs_step_create_debscripts() {
	[ "$MCHS_PACKAGE_FORMAT" = "pacman" ] && return 0
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "echo Downloading updated package list ..." >> postinst
	echo "apt update" >> postinst
	echo "exit 0" >> postinst
}

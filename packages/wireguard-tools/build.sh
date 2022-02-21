MCHS_PKG_HOMEPAGE=https://www.wireguard.com
MCHS_PKG_DESCRIPTION="Tools for the WireGuard secure network tunnel"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.20210424
MCHS_PKG_SRCURL=https://git.zx2c4.com/wireguard-tools/snapshot/wireguard-tools-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=b288b0c43871d919629d7e77846ef0b47f8eeaa9ebc9cedeee8233fc6cc376ad
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_MAKE_ARGS=" -C src WITH_BASHCOMPLETION=yes WITH_WGQUICK=no WITH_SYSTEMDUNITS=no"

mchs_step_post_make_install() {
	cd src/wg-quick
	$CC $CFLAGS $LDFLAGS -DWG_CONFIG_SEARCH_PATHS="\"$MCHS_ANDROID_HOME/.wireguard $MCHS_PREFIX/etc/wireguard /data/misc/wireguard /data/data/com.wireguard.android/files\"" -o wg-quick android.c
	install -Dm0700 wg-quick $MCHS_PREFIX/bin/wg-quick
}

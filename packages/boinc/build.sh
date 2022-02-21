MCHS_PKG_HOMEPAGE=https://boinc.berkeley.edu/
MCHS_PKG_DESCRIPTION="Open-source software for volunteer computing"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=7.18.1
MCHS_PKG_SRCURL=https://github.com/BOINC/boinc/archive/client_release/${MCHS_PKG_VERSION:0:4}/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=274388d9c49e488b6c8502ffc6eb605d5ceae391fb0c2fc56dbb0254d0ceb27e
MCHS_PKG_DEPENDS="libandroid-shmem, libc++, libcurl, openssl, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_NO_STATICSPLIT=true

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-server
--disable-manager
"

MCHS_PKG_CONFFILES="etc/boinc-client.conf"

mchs_step_pre_configure() {
	# for benchmark purposes
	CFLAGS="${CFLAGS/-Oz/-Os}"
	CXXFLAGS="${CXXFLAGS/-Oz/-Os}"
	LDFLAGS+=" -landroid-shmem"
	./_autosetup
}

mchs_step_post_make_install() {
	mkdir -p "$MCHS_PREFIX/share/bash-completion/completions"
	install -m 644 "$MCHS_PKG_SRCDIR/client/scripts/boinc.bash" "$MCHS_PREFIX/share/bash-completion/completions/boinc"
}

MCHS_PKG_HOMEPAGE=https://wiki.debian.org/Debootstrap
MCHS_PKG_DESCRIPTION="Bootstrap a basic Debian system"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.125
MCHS_PKG_SRCURL=http://http.debian.net/debian/pool/main/d/debootstrap/debootstrap_${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=9c4c7ca8f3f6653e7eca65aae77bbf7f723d7395fb48403bbc2256ce8b24ec1a
MCHS_PKG_DEPENDS="perl, proot, wget"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_post_make_install() {
    mkdir -p ${MCHS_PREFIX}/share/man/man8/
    install ${MCHS_PKG_SRCDIR}/debootstrap.8 ${MCHS_PREFIX}/share/man/man8/
}

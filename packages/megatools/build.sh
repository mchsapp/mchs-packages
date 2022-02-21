MCHS_PKG_HOMEPAGE=https://megatools.megous.com/
MCHS_PKG_DESCRIPTION="Open-source command line tools and C library (libmega) for accessing Mega.co.nz cloud storage"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10.3
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://megatools.megous.com/builds/megatools-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=8dc1ca348633fd49de7eb832b323e8dc295f1c55aefb484d30e6475218558bdb
MCHS_PKG_DEPENDS="glib, libandroid-support, libcurl, libgmp, openssl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-fuse --enable-docs-build"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
    mkdir -p m4
    autoreconf -v --install

    sed -i -e 's/-V -qversion//' configure
    sed -i -e 's/GOBJECT_INTROSPECTION_CHECK/#GOBJECT_INTROSPECTION_CHECK/' configure
}

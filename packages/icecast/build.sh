MCHS_PKG_HOMEPAGE=https://icecast.org
MCHS_PKG_DESCRIPTION="Icecast is a streaming media (audio/video) server"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.4.4
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.xiph.org/releases/icecast/icecast-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=49b5979f9f614140b6a38046154203ee28218d8fc549888596a683ad604e4d44
MCHS_PKG_DEPENDS="libcurl, libgnutls, libogg, libvorbis, libxml2, libxslt, mime-support, openssl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
    perl -p -i -e "s#/etc/mime.types#$MCHS_PREFIX/etc/mime.types#" $MCHS_PKG_SRCDIR/src/cfgfile.c
}

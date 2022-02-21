MCHS_PKG_HOMEPAGE=https://libsodium.org/
MCHS_PKG_DESCRIPTION="Network communication, cryptography and signaturing library"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.0.18
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/jedisct1/libsodium/archive/${MCHS_PKG_VERSION}-RELEASE.tar.gz
MCHS_PKG_SHA256=b7292dd1da67a049c8e78415cd498ec138d194cfdb302e716b08d26b80fecc10
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_BREAKS="libsodium-dev"
MCHS_PKG_REPLACES="libsodium-dev"

MCHS_PKG_HOMEPAGE=https://github.com/boothj5/libmesode
MCHS_PKG_DESCRIPTION="Minimal XMPP library written for use with Profanity XMPP client"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_VERSION=0.10.1
MCHS_PKG_REVISION=1
MCHS_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MCHS_PKG_SRCURL=https://github.com/boothj5/libmesode/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c9dd90648e73d92b90f2b0ae41a75d8f469b116d3e6aa297c14cd57be937d99e
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="openssl,libexpat"
MCHS_PKG_BREAKS="libmesode-dev"
MCHS_PKG_REPLACES="libmesode-dev"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
./bootstrap.sh
}

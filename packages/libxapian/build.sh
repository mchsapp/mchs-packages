MCHS_PKG_HOMEPAGE=https://xapian.org
MCHS_PKG_DESCRIPTION="Xapian search engine library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.18
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=http://oligarchy.co.uk/xapian/${MCHS_PKG_VERSION}/xapian-core-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=196ddbb4ad10450100f0991a599e4ed944cbad92e4a6fe813be6dce160244b77
# Note that we cannot /proc/sys/kernel/random/uuid (permission denied on
# new android versions) so need libuuid.
MCHS_PKG_DEPENDS="libc++, libuuid, zlib"
MCHS_PKG_BREAKS="libxapian-dev"
MCHS_PKG_REPLACES="libxapian-dev"

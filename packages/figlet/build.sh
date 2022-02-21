MCHS_PKG_HOMEPAGE=http://www.figlet.org/
MCHS_PKG_DESCRIPTION="Program for making large letters out of ordinary text"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.2.5
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=bf88c40fd0f077dab2712f54f8d39ac952e4e9f2e1882f1195be9e5e4257417d
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	LD=$CC
}

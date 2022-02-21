MCHS_PKG_HOMEPAGE=https://www.keystone-engine.org/
MCHS_PKG_DESCRIPTION="Keystone is a lightweight multi-platform, multi-architecture assembler framework"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.2
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/keystone-engine/keystone/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=c9b3a343ed3e05ee168d29daf89820aff9effb2c74c6803c2d9e21d55b5b7c24
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libc++"
MCHS_PKG_BREAKS="keystone-dev"
MCHS_PKG_REPLACES="keystone-dev"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DPYTHON_EXECUTABLE=$(command -v python2.7)
-DBUILD_SHARED_LIBS=ON"

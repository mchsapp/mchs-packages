MCHS_PKG_HOMEPAGE=https://gitlab.com/surfraw/Surfraw
MCHS_PKG_DESCRIPTION="Shell Users' Revolutionary Front Rage Against the Web"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.3.0
MCHS_PKG_REVISION=10
MCHS_PKG_SRCURL=https://gitlab.com/surfraw/Surfraw/-/archive/surfraw-${MCHS_PKG_VERSION}/Surfraw-surfraw-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b5e2b451a822ed437b165a5c81d8448570ee590db902fcd8174d6c51fcc4a16d
MCHS_PKG_DEPENDS="lynx, perl"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	./prebuild
}

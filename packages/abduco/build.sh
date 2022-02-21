MCHS_PKG_HOMEPAGE=https://www.brain-dump.org/projects/abduco/
MCHS_PKG_DESCRIPTION="Clean and simple terminal session manager"
MCHS_PKG_LICENSE="ISC"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=http://www.brain-dump.org/projects/abduco/abduco-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c90909e13fa95770b5afc3b59f311b3d3d2fdfae23f9569fa4f96a3e192a35f4
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="dvtm"

mchs_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
}

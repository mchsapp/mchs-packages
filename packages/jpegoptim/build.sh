MCHS_PKG_HOMEPAGE=https://www.kokkonen.net/tjko/projects.html
MCHS_PKG_DESCRIPTION="JPEG optimizer that recompresses image files to a smaller size, without losing any information"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.6
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://www.kokkonen.net/tjko/src/jpegoptim-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=88b1eb64c2a33a2f013f068df8b0331f42c019267401ae3fa28e3277403a5ab7
MCHS_PKG_DEPENDS="libjpeg-turbo"
MCHS_PKG_EXTRA_CONFIGURE_ARGS=" --mandir=$MCHS_PREFIX/share/man"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	LD=$CC
}

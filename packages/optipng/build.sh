MCHS_PKG_HOMEPAGE=http://optipng.sourceforge.net/
MCHS_PKG_DESCRIPTION="PNG optimizer that recompresses image files to a smaller size, without losing any information"
MCHS_PKG_LICENSE="ZLIB"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.7.7
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/project/optipng/OptiPNG/optipng-${MCHS_PKG_VERSION}/optipng-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=4f32f233cef870b3f95d3ad6428bfe4224ef34908f1b42b0badf858216654452
MCHS_PKG_DEPENDS="libpng, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-system-zlib --with-system-libpng --mandir=$MCHS_PREFIX/share/man"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	LD=$CC
}

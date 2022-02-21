MCHS_PKG_HOMEPAGE=https://pngquant.org
MCHS_PKG_DESCRIPTION="PNG image optimising utility"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.16.0
# If both archives are .tar.gz then they overwrite eachother since they are the same version and hence the same name.
# Work around this by using .zip for one of them...
MCHS_PKG_SRCURL=(https://github.com/pornel/pngquant/archive/$MCHS_PKG_VERSION.tar.gz
		   https://github.com/ImageOptim/libimagequant/archive/$MCHS_PKG_VERSION.zip)
MCHS_PKG_SHA256=(6b186b76bc995ee12949a48a1041173459eb8050ef1dceb5f7ba43726327b1ea
		   0abd696af22c85fefa584b531d67f484c37a4196c66c7774ac6b2280a60df76a)
MCHS_PKG_DEPENDS="libpng, littlecms, zlib"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-sse"

mchs_step_post_get_source() {
	mv $MCHS_PKG_SRCDIR/libimagequant-$MCHS_PKG_VERSION/* $MCHS_PKG_SRCDIR/lib/
}

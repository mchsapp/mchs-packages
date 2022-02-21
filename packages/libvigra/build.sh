MCHS_PKG_HOMEPAGE=https://ukoethe.github.io/vigra/
MCHS_PKG_DESCRIPTION="Computer vision library"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.11.1
MCHS_PKG_SRCURL=https://github.com/ukoethe/vigra/releases/download/Version-${MCHS_PKG_VERSION//./-}/vigra-${MCHS_PKG_VERSION}-src.tar.gz
MCHS_PKG_SHA256=a5564e1083f6af6a885431c1ee718bad77d11f117198b277557f8558fa461aaf
MCHS_PKG_DEPENDS="libc++, libhdf5, libjpeg-turbo, libpng, libtiff, zlib"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
-DRUN_RESULT=0
-DRUN_RESULT__TRYRUN_OUTPUT=201103
"
MCHS_PKG_RM_AFTER_INSTALL="doc"

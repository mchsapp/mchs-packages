MCHS_PKG_HOMEPAGE=https://libvips.github.io/libvips/
MCHS_PKG_DESCRIPTION="A fast image processing library with low memory needs"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="Thibault Meyer <meyer.thibault@gmail.com>"
MCHS_PKG_VERSION=8.12.2
MCHS_PKG_SRCURL=https://github.com/libvips/libvips/releases/download/v${MCHS_PKG_VERSION}/vips-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=565252992aff2c7cd10c866c7a58cd57bc536e03924bde29ae0f0cb9e074010b
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="fftw, giflib, imagemagick, libexif, libexpat, libjpeg-turbo, libtiff, libwebp"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--disable-gtk-doc"

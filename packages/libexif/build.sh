MCHS_PKG_HOMEPAGE=https://libexif.github.io/
MCHS_PKG_DESCRIPTION="Library for reading and writing EXIF image metadata"
MCHS_PKG_LICENSE="LGPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.6.24
MCHS_PKG_SRCURL=https://github.com/libexif/libexif/archive/libexif-0_6_22-release.tar.gz
MCHS_PKG_SHA256=46498934b7b931526fdee8fd8eb77a1dddedd529d5a6dbce88daf4384baecc54
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+.\d+.\d+"
MCHS_PKG_BREAKS="libexif-dev"
MCHS_PKG_REPLACES="libexif-dev"

mchs_step_pre_configure() {
	autoreconf -fi
}

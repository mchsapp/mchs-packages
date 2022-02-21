MCHS_PKG_HOMEPAGE=https://github.com/jart/hiptext
MCHS_PKG_DESCRIPTION="Turn images into text better than caca/aalib"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.2
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://github.com/jart/hiptext/releases/download/$MCHS_PKG_VERSION/hiptext-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=7f2217dec8775b445be6745f7bd439c24ce99c4316a9faf657bee7b42bc72e8f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="ffmpeg, freetype, gflags, google-glog, libjpeg-turbo, libpng, ncurses"
MCHS_PKG_BUILD_DEPENDS="ragel"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	#Font reference on file font.cc --> Patch by font.cc.patch
	#Because of ttf-dejavu is x11 package, the hiptext is not a x11 package.
	install -Dm600 -t "$MCHS_PREFIX"/share/hiptext/ \
		"$MCHS_PKG_SRCDIR"/DejaVuSansMono.ttf
}

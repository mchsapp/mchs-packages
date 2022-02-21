MCHS_PKG_HOMEPAGE=https://sites.google.com/site/gogdownloader/
MCHS_PKG_DESCRIPTION="Open source downloader to GOG.com for Linux users using the same API as the official GOGDownloader"
MCHS_PKG_LICENSE="WTFPL"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.8
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/Sude-/lgogdownloader/releases/download/v${MCHS_PKG_VERSION}/lgogdownloader-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=2f4941f07b94f4e96557ca86f33f7d839042bbcac7535f6f9736092256d31eb5
MCHS_PKG_DEPENDS="boost, jsoncpp, libc++, libcurl, libhtmlcxx, libtinyxml2, rhash"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="-DHELP2MAN=OFF"

MCHS_PKG_HOMEPAGE=https://6xq.net/pianobar/
MCHS_PKG_DESCRIPTION="pianobar is a free/open-source, console-based client for the personalized online radio Pandora."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2020.11.28
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/PromyLOPh/pianobar/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f8cdd564e2a12ee0740c54e8bc4028b328e9afb041d9ea40bcb762e08034b9e9
MCHS_PKG_DEPENDS="libao, ffmpeg, libgcrypt, libcurl, json-c"
MCHS_PKG_BUILD_DEPENDS="libao, ffmpeg, libgcrypt, libcurl, json-c"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_post_make_install(){
    #install useful script
    install -Dm755 "$MCHS_PKG_SRCDIR"/contrib/headless_pianobar "$MCHS_PREFIX"/bin/pianoctl
}

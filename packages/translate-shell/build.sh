MCHS_PKG_HOMEPAGE=https://www.soimort.org/translate-shell
MCHS_PKG_DESCRIPTION="Command-line translator using Google Translate, Bing Translator, Yandex.Translate, etc."
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.9.6.12
MCHS_PKG_SRCURL=https://github.com/soimort/translate-shell/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=4c4843a8c66276190535b8435775ecb5d9c8286083a33cdbe2db608eba93ca97
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="bash, curl, gawk, less, rlwrap"
# hunspell - spell checking
# mpv - text-to-speech functionality
MCHS_PKG_RECOMMENDS="hunspell, mpv"
MCHS_PKG_EXTRA_MAKE_ARGS="PREFIX=$MCHS_PREFIX"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

MCHS_PKG_HOMEPAGE=https://dejavu-fonts.github.io/
MCHS_PKG_DESCRIPTION="Font family based on the Bitstream Vera Fonts with a wider range of characters"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.37
MCHS_PKG_REVISION=8
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/dejavu/dejavu/${MCHS_PKG_VERSION}/dejavu-fonts-ttf-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=fa9ca4d13871dd122f61258a80d01751d603b4d3ee14095d65453b4e846e17d7
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_CONFFILES="
etc/fonts/conf.d/20-unhint-small-dejavu-sans-mono.conf
etc/fonts/conf.d/20-unhint-small-dejavu-sans.conf
etc/fonts/conf.d/20-unhint-small-dejavu-serif.conf
etc/fonts/conf.d/57-dejavu-sans-mono.conf
etc/fonts/conf.d/57-dejavu-sans.conf
etc/fonts/conf.d/57-dejavu-serif.conf
"

mchs_step_make_install() {
	## Install fonts.
	mkdir -p "${MCHS_PREFIX}/share/fonts/TTF"
	cp -f ttf/*.ttf "${MCHS_PREFIX}/share/fonts/TTF/"

	## Install config files used by 'fontconfig' package.
	mkdir -p "${MCHS_PREFIX}/etc/fonts/conf.d"
	cp -f fontconfig/*.conf "${MCHS_PREFIX}/etc/fonts/conf.d/"
}

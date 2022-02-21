MCHS_PKG_HOMEPAGE=http://mp3gain.sourceforge.net/
MCHS_PKG_DESCRIPTION="Analyzes and adjusts mp3 files so that they have the same volume"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.6.2
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/mp3gain/mp3gain-${MCHS_PKG_VERSION//./_}-src.zip
MCHS_PKG_SHA256=5cc04732ef32850d5878b28fbd8b85798d979a025990654aceeaa379bcc9596d
MCHS_PKG_DEPENDS="mpg123"
MCHS_PKG_BUILD_IN_SRC=true

mchs_extract_src_archive() {
	rm -Rf mp3gain
	mkdir mp3gain
	pushd mp3gain
	unzip -q "$MCHS_PKG_CACHEDIR/$(basename "${MCHS_PKG_SRCURL}")"
	popd
	mv mp3gain "$MCHS_PKG_SRCDIR"
}

mchs_step_make_install() {
	install -Dm700 -t $MCHS_PREFIX/bin mp3gain
}

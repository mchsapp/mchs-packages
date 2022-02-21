MCHS_PKG_HOMEPAGE=http://www-zeuthen.desy.de/~friebel/unix/lesspipe.html
MCHS_PKG_DESCRIPTION="An input filter for the pager less"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.91
MCHS_PKG_SRCURL=https://github.com/wofr06/lesspipe/archive/$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=6192e7e451c5db26841c6dc3cbcc23c1ef396c1cc4588288effa699dbc665cdb
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="less"
MCHS_PKG_SUGGESTS="imagemagick, p7zip, unrar, unzip"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	./configure \
		--prefix="$MCHS_PREFIX" \
		--yes
}

mchs_step_post_make_install() {
	mkdir -p "$MCHS_PREFIX"/etc/profile.d
	echo "export LESSOPEN='|$MCHS_PREFIX/bin/lesspipe.sh %s'" \
		> "$MCHS_PREFIX"/etc/profile.d/lesspipe.sh
}

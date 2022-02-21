MCHS_PKG_HOMEPAGE=https://www.freetype.org
MCHS_PKG_DESCRIPTION="Software font engine capable of producing high-quality output"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.11.0
MCHS_PKG_SRCURL=https://download.savannah.gnu.org/releases/freetype/freetype-$MCHS_PKG_VERSION.tar.xz
MCHS_PKG_SHA256=8bee39bd3968c4804b70614a0a3ad597299ad0e824bc8aad5ce8aaf48067bde7
MCHS_PKG_DEPENDS="libbz2, libpng, zlib"
MCHS_PKG_BREAKS="freetype-dev"
MCHS_PKG_REPLACES="freetype-dev"
# Use with-harfbuzz=no to avoid circular dependency between freetype and harfbuzz:
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--with-harfbuzz=no"
# not install these files anymore so install them manually.
mchs_step_post_make_install() {
	install -Dm700 freetype-config $MCHS_PREFIX/bin/freetype-config
	install -Dm600 ../src/docs/freetype-config.1 $MCHS_PREFIX/share/man/man1/freetype-config.1
}


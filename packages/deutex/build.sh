MCHS_PKG_HOMEPAGE=https://github.com/Doom-Utils/deutex/
MCHS_PKG_DESCRIPTION="WAD composer for Doom, Heretic, Hexen, and Strife"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.2.2
MCHS_PKG_SRCURL=https://github.com/Doom-Utils/deutex/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=767e75eb3615bb732947448b81031410e26f808dfc3a099d64a483931fe0b313
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="libpng, zlib"

mchs_step_pre_configure() {
	./bootstrap
}

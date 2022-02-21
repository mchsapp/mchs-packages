MCHS_PKG_HOMEPAGE=http://www.digital-scurf.org/software/libgfshare
MCHS_PKG_DESCRIPTION="Utilities for multi-way secret-sharing"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.0
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=http://www.digital-scurf.org/files/libgfshare/libgfshare-$MCHS_PKG_VERSION.tar.bz2
MCHS_PKG_SHA256=86f602860133c828356b7cf7b8c319ba9b27adf70a624fe32275ba1ed268331f
MCHS_PKG_BREAKS="libgfshare-dev"
MCHS_PKG_REPLACES="libgfshare-dev"

mchs_step_post_configure() {
	gcc -DHAVE_CONFIG_H \
		-I. \
		-I"$MCHS_PKG_SRCDIR" \
		-I"$MCHS_PKG_SRCDIR"/include \
		"$MCHS_PKG_SRCDIR"/src/gfshare_maketable.c \
		-o gfshare_maketable
	touch -d "next hour" gfshare_maketable
}

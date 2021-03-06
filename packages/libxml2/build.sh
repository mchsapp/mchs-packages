MCHS_PKG_HOMEPAGE=http://www.xmlsoft.org
MCHS_PKG_DESCRIPTION="Library for parsing XML documents"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.9.12
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=ftp://xmlsoft.org/libxml2/libxml2-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c8d6681e38c56f172892c85ddc0852e1fd4b53b4209e7f4ebf17f7e2eae71d92
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-python"
MCHS_PKG_RM_AFTER_INSTALL="share/gtk-doc"
MCHS_PKG_DEPENDS="libiconv, liblzma, zlib"
MCHS_PKG_BREAKS="libxml2-dev"
MCHS_PKG_REPLACES="libxml2-dev"

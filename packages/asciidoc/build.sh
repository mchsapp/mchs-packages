MCHS_PKG_HOMEPAGE=https://asciidoc.org
MCHS_PKG_DESCRIPTION="Text document format for short documents, articles, books and UNIX man pages."
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=9.1.1
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/asciidoc/asciidoc-py3/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=914dfc1542c30bd47faa0aaaae0985cb57d0ca584015729ccd1b94d90da3a616
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="docbook-xsl, libxml2-utils, python, xsltproc"
MCHS_PKG_SUGGESTS="w3m"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	autoreconf -vfi
}

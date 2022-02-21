MCHS_PKG_HOMEPAGE=https://www.w3.org/Tools/HTML-XML-utils/
MCHS_PKG_DESCRIPTION="A number of simple utilities for manipulating HTML and XML files"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="COPYING"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=8.0
MCHS_PKG_SRCURL=https://www.w3.org/Tools/HTML-XML-utils/html-xml-utils-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=749059906c331c2c7fbaceee02466245a237b91bd408dff8f396d0734a060ae2
MCHS_PKG_DEPENDS="libcurl, libidn2"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	aclocal
	automake
}

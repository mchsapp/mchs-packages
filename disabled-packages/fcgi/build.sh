MCHS_PKG_HOMEPAGE=http://www.fastcgi.com/
MCHS_PKG_DESCRIPTION="A language independent, high performant extension to CGI"
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="LICENSE.TERMS"
MCHS_PKG_VERSION=2.4.2
MCHS_PKG_SRCURL=https://github.com/FastCGI-Archives/fcgi2/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=1fe83501edfc3a7ec96bb1e69db3fd5ea1730135bd73ab152186fd0b437013bc
MCHS_PKG_BREAKS="fcgi-dev"
MCHS_PKG_REPLACES="fcgi-dev"

mchs_step_pre_configure() {
	libtoolize --automake --copy --force
	aclocal
	autoheader
	automake --add-missing --force-missing --copy
	autoconf
	export LIBS="-lm"
}

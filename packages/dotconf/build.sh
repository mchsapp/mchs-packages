MCHS_PKG_HOMEPAGE=https://github.com/williamh/dotconf
MCHS_PKG_DESCRIPTION="dot.conf configuration file parser"
MCHS_PKG_VERSION=1.3
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_SHA256=7f1ecf40de1ad002a065a321582ed34f8c14242309c3547ad59710ae3c805653
MCHS_PKG_SRCURL=https://github.com/williamh/dotconf/archive/v${MCHS_PKG_VERSION}.tar.gz

mchs_step_pre_configure () {
	aclocal && libtoolize --force && autoreconf -fi
}

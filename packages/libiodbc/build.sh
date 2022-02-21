MCHS_PKG_HOMEPAGE=http://www.iodbc.org/
MCHS_PKG_DESCRIPTION="Independent Open DataBase Connectivity for Linux, MacOS X and Unix systems"
MCHS_PKG_LICENSE="LGPL-2.0, BSD 3-Clause"
MCHS_PKG_LICENSE_FILE="LICENSE, LICENSE.BSD, LICENSE.LGPL"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=3.52.15
MCHS_PKG_SRCURL=https://github.com/openlink/iODBC/releases/download/v${MCHS_PKG_VERSION}/libiodbc-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=c74541e3327fc9a1c7ccf103645471c67bc014542d70f572476eb07c0b2dd43c
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--disable-libodbc
--with-layout=gnu
"

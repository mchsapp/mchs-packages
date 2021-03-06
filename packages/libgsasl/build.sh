MCHS_PKG_HOMEPAGE=https://www.gnu.org/software/gsasl
MCHS_PKG_DESCRIPTION="GNU SASL library"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.10.0
MCHS_PKG_SRCURL=https://ftp.gnu.org/gnu/gsasl/libgsasl-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=f1b553384dedbd87478449775546a358d6f5140c15cccc8fb574136fdc77329f
MCHS_PKG_DEPENDS="libidn"
MCHS_PKG_BREAKS="libgsasl-dev"
MCHS_PKG_REPLACES="libgsasl-dev"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-libgcrypt"

MCHS_PKG_HOMEPAGE=https://www.pcre.org
MCHS_PKG_DESCRIPTION="Perl 5 compatible regular expression library"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=10.39
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/PhilipHazel/pcre2/releases/download/pcre2-${MCHS_PKG_VERSION}/pcre2-${MCHS_PKG_VERSION}.tar.bz2
MCHS_PKG_SHA256=0f03caf57f81d9ff362ac28cd389c055ec2bf0678d277349a1a4bee00ad6d440
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+"
MCHS_PKG_BREAKS="pcre2-dev"
MCHS_PKG_REPLACES="pcre2-dev"
MCHS_PKG_RM_AFTER_INSTALL="
bin/pcre2test
share/man/man1/pcre2test.1
lib/libpcre2-posix.so
lib/pkgconfig/libpcre2-posix.pc
"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--enable-jit
--enable-pcre2-16
--enable-pcre2-32
"

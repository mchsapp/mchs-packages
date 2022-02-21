MCHS_PKG_HOMEPAGE=https://ngircd.barton.de/
MCHS_PKG_DESCRIPTION="Free, portable and lightweight Internet Relay Chat server"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@yonle <yonle@protonmail.com>"
MCHS_PKG_VERSION=26.1
MCHS_PKG_SRCURL="https://github.com/ngircd/ngircd/releases/download/rel-${MCHS_PKG_VERSION}/ngircd-26.tar.xz"
MCHS_PKG_SHA256=56dcc6483058699fcdd8e54f5010eecee09824b93bad7ed5f18818e550d855c6
MCHS_PKG_DEPENDS="zlib, openssl"

# McHs does not use /sbin. Place the binary to $PATH/bin instead
# Also enable OpenSSL & IPv6 support
MCHS_PKG_EXTRA_CONFIGURE_ARGS="
--sbindir=$MCHS_PREFIX/bin
--with-openssl
--enable-ipv6
"


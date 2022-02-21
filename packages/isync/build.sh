MCHS_PKG_HOMEPAGE=http://isync.sourceforge.net
MCHS_PKG_DESCRIPTION="IMAP and MailDir mailbox synchronizer"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4.3
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/project/isync/isync/${MCHS_PKG_VERSION}/isync-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=b4c720745bda3447fbd5b9f71783b23f699a55295917ae7586ee5c22e91b9708
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--without-sasl ac_cv_header_db=no ac_cv_berkdb4=no"
MCHS_PKG_DEPENDS="openssl, zlib"

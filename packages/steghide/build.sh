MCHS_PKG_HOMEPAGE=http://steghide.sourceforge.net/
MCHS_PKG_DESCRIPTION="Embeds a message in a file by replacing some of the least significant bits"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.5.1
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=http://downloads.sourceforge.net/steghide/steghide-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=78069b7cfe9d1f5348ae43f918f06f91d783c2b3ff25af021e6a312cf541b47b
MCHS_PKG_DEPENDS="libjpeg-turbo, libmcrypt, libmhash, zlib"

MCHS_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_file__dev_random=yes
ac_cv_file__dev_urandom=yes
--mandir=$MCHS_PREFIX/share/man
"

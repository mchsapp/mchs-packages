MCHS_PKG_HOMEPAGE=https://www.agwa.name/projects/git-crypt/
MCHS_PKG_DESCRIPTION="Enables transparent encryption and decryption of files for a git repository"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@jottr"
MCHS_PKG_VERSION=0.6.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/AGWA/git-crypt/archive/${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=777c0c7aadbbc758b69aff1339ca61697011ef7b92f1d1ee9518a8ee7702bb78
MCHS_PKG_DEPENDS="git, libc++, openssl"
MCHS_PKG_EXTRA_CONFIGURE_ARGS=" -DCMAKE_BUILD_TYPE=Release -Dbuild_parse=yes -Dbuild_xmlparser=yes"
MCHS_PKG_EXTRA_MAKE_ARGS="make ENABLE_MAN=yes"

mchs_step_make() {
	cd $MCHS_PKG_SRCDIR
	make
}

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR
	make install
}

MCHS_PKG_HOMEPAGE=http://bftpd.sourceforge.net/
MCHS_PKG_DESCRIPTION="Small, easy-to-configure FTP server"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=5.7
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://kumisystems.dl.sourceforge.net/project/bftpd/bftpd/bftpd-${MCHS_PKG_VERSION}/bftpd-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=a543ce62a8092a7b5065146875cc9878534b09dc4a853f2c2b56e2de397a6f4b
MCHS_PKG_DEPENDS="libcrypt"
MCHS_PKG_BUILD_IN_SRC=true

MCHS_PKG_CONFFILES="etc/bftpd.conf"
MCHS_PKG_RM_AFTER_INSTALL="var/log/bftpd.log"

mchs_step_pre_configure() {
	CFLAGS+=" -fcommon"
}

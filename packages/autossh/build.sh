MCHS_PKG_HOMEPAGE=https://www.harding.motd.ca/autossh/
MCHS_PKG_DESCRIPTION="Automatically restart SSH sessions and tunnels"
MCHS_PKG_LICENSE="BSD"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.4g
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://fossies.org/linux/privat/autossh-${MCHS_PKG_VERSION}.tar.xz
MCHS_PKG_SHA256=83766463763364a1be56d6bf1a75b40a59302586645bf0c4fa885188cf01ebfc
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="openssh | dropbear"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$MCHS_PREFIX/share/man ac_cv_path_ssh=$MCHS_PREFIX/bin/ssh"

MCHS_PKG_HOMEPAGE=https://taskwarrior.org
MCHS_PKG_DESCRIPTION="Shell command wrapping Taskwarrior commands"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.2.0
MCHS_PKG_REVISION=7
MCHS_PKG_SRCURL=https://taskwarrior.org/download/tasksh-${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=6e42f949bfd7fbdde4870af0e7b923114cc96c4344f82d9d924e984629e21ffd
MCHS_PKG_DEPENDS="libc++, readline, taskwarrior, libandroid-glob"

mchs_step_pre_configure() {
	LDFLAGS+=" -landroid-glob"
}


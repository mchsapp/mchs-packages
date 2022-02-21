MCHS_PKG_HOMEPAGE=https://github.com/Parchive/par2cmdline
MCHS_PKG_DESCRIPTION="par2cmdline is a PAR 2.0 compatible file verification and repair tool."
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="Oliver Schmidhauser @Neo-Oli"
MCHS_PKG_VERSION=0.8.1
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/Parchive/par2cmdline/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=529f85857ec44e501cd8d95b0c8caf47477d7daa5bfb989e422c800bb71b689a
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_pre_configure() {
	if [ $MCHS_ARCH = "i686" ]; then
		# Avoid undefined reference to __atomic_* functions:
		export LIBS=" -latomic"
	fi
	aclocal
	automake --add-missing
	autoconf
}

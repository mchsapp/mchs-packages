MCHS_PKG_HOMEPAGE=https://github.com/yrp604/rappel
MCHS_PKG_DESCRIPTION="Rappel is a pretty janky assembly REPL."
MCHS_PKG_LICENSE="custom"
MCHS_PKG_LICENSE_FILE="LICENSE"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2020.09.18
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://github.com/yrp604/rappel/archive/dd45bfa000efb89357d5c80a3a77550b96dee499.tar.gz
MCHS_PKG_SHA256=c310855880051a9e0c802b74ba0c8eafddeb5bd2a930728356101e385d04d015
MCHS_PKG_DEPENDS="binutils, libedit"
MCHS_PKG_BUILD_IN_SRC=true

# Need nasm.
MCHS_PKG_BLACKLISTED_ARCHES="i686, x86_64"

mchs_step_make() {
	local _ARCH

	if [ "$MCHS_ARCH" = "i686" ]; then
		_ARCH="x86"
	elif [ "$MCHS_ARCH" = "x86_64" ]; then
		_ARCH="amd64"
        elif [ "$MCHS_ARCH" = "arm" ]; then
                _ARCH="armv7"
	elif [ "$MCHS_ARCH" = "aarch64" ]; then
		_ARCH="armv8"
	else
		_ARCH=$MCHS_ARCH
	fi

	make ARCH=$_ARCH CC="$CC $CPPFLAGS $CFLAGS" LDFLAGS="$LDFLAGS" -j $MCHS_MAKE_PROCESSES
}

mchs_step_make_install() {
	cd bin
	install -Dm755 -t "$MCHS_PREFIX/bin" rappel
}

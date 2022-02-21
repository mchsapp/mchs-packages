MCHS_PKG_HOMEPAGE=https://rdiff-backup.net
MCHS_PKG_DESCRIPTION="A utility for local/remote mirroring and incremental backups"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.0.5
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/rdiff-backup/rdiff-backup/releases/download/v${MCHS_PKG_VERSION/\~/}/rdiff-backup-${MCHS_PKG_VERSION/\~/}.tar.gz
MCHS_PKG_SHA256=2bb7837b4a9712b6efaebfa7da8ed6348ffcb02fcecff0e19d8fff732e933b87
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_DEPENDS="librsync, python"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_make() {
	continue
}

mchs_step_make_install() {
	local _PYTHON_VERSION=3.10
	export PYTHONPATH=$MCHS_PREFIX/lib/python${_PYTHON_VERSION}/site-packages
	export CPPFLAGS+=" -I${MCHS_PREFIX}/include/python${_PYTHON_VERSION}"
	export LDFLAGS+=" -lpython${_PYTHON_VERSION}"
	export LDSHARED="$CC -shared"
	python${_PYTHON_VERSION} setup.py install --prefix=$MCHS_PREFIX --force
}

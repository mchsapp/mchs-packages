MCHS_PKG_HOMEPAGE=https://asciinema.org/
MCHS_PKG_DESCRIPTION="Record and share your terminal sessions, the right way"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=2.1.0
MCHS_PKG_SRCURL=https://github.com/asciinema/asciinema/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=f4f4a04ab891dd513c99f72527c83fa9e634e858f2744a17e80258b90a6bf409
MCHS_PKG_AUTO_UPDATE=true
# ncurses-utils for tput which asciinema uses:
MCHS_PKG_DEPENDS="python, ncurses-utils"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
MCHS_PKG_HAS_DEBUG=false

_PYTHON_VERSION=3.10

MCHS_PKG_RM_AFTER_INSTALL="
lib/python${_PYTHON_VERSION}/site-packages/easy-install.pth
lib/python${_PYTHON_VERSION}/site-packages/site.py
lib/python${_PYTHON_VERSION}/site-packages/__pycache__
"

mchs_step_make() {
	return
}

mchs_step_make_install() {
	export PYTHONPATH=$MCHS_PREFIX/lib/python${_PYTHON_VERSION}/site-packages/
	python${_PYTHON_VERSION} setup.py install --prefix=$MCHS_PREFIX --force
}

MCHS_PKG_HOMEPAGE=https://ranger.github.io/
MCHS_PKG_DESCRIPTION="File manager with VI key bindings"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.9.3
MCHS_PKG_REVISION=3
MCHS_PKG_SRCURL=https://github.com/ranger/ranger/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ce088a04c91c25263a9675dc5c43514b7ec1b38c8ea43d9a9d00923ff6cdd251
MCHS_PKG_DEPENDS="python, file"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_make() {
	echo Skipping make step...
}

mchs_step_make_install() {
	python3.10 setup.py install --prefix=$MCHS_PREFIX --force
}

mchs_step_post_massage() {
	find . -path '*/__pycache__*' -delete
}

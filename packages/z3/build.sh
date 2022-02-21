MCHS_PKG_HOMEPAGE=https://github.com/Z3Prover/z3
MCHS_PKG_DESCRIPTION="Z3 is a theorem prover from Microsoft Research."
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.8.14
MCHS_PKG_SRCURL=https://github.com/Z3Prover/z3/archive/z3-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=96a1f49a7701120cc38bfa63c02ff93be4d64c7926cea41977dedec7d87a1364
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_AUTO_UPDATE_TAG_REGEXP="\d+\.\d+\.\d+"
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_configure() {
	_PYTHON_VERSION=$(source $MCHS_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)

	chmod +x scripts/mk_make.py
	CXX="$CXX" CC="$CC" python${_PYTHON_VERSION} scripts/mk_make.py --prefix=$MCHS_PREFIX --build=$MCHS_PKG_BUILDDIR
	if $MCHS_ON_DEVICE_BUILD; then
		sed 's%../../../../../../../../%%g' -i Makefile
	else
		sed 's%../../../../../%%g' -i Makefile
	fi
	sed 's/\-lpthread//g' -i config.mk
}

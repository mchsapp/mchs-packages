MCHS_PKG_HOMEPAGE=http://www.sbcl.org/
MCHS_PKG_DESCRIPTION="Steel Bank Common Lisp"
MCHS_PKG_VERSION=1.3.9
MCHS_PKG_SRCURL=http://prdownloads.sourceforge.net/sbcl/sbcl-${MCHS_PKG_VERSION}-source.tar.bz2

mchs_step_pre_configure() {
	local SBCL_HOST_TARFILE=$MCHS_PKG_CACHEDIR/sbcl-host-${MCHS_PKG_VERSION}.tar.bz2
	if [ ! -f $SBCL_HOST_TARFILE ]; then
		curl -o $SBCL_HOST_TARFILE -L http://downloads.sourceforge.net/project/sbcl/sbcl/${MCHS_PKG_VERSION}/sbcl-${MCHS_PKG_VERSION}-x86-64-linux-binary.tar.bz2
		cd $MCHS_PKG_TMPDIR
		tar xf $SBCL_HOST_TARFILE
		cd sbcl-${MCHS_PKG_VERSION}-x86-64-linux
		INSTALL_ROOT=$MCHS_PKG_CACHEDIR/sbcl-host sh install.sh
	fi
	export PATH=$PATH:$MCHS_PKG_CACHEDIR/sbcl-host/bin
	export SBCL_HOME=$MCHS_PKG_CACHEDIR/sbcl-host/lib/sbcl
}

mchs_step_make_install() {
	cd $MCHS_PKG_SRCDIR
	sh make.sh --prefix=$MCHS_PREFIX
}

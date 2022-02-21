MCHS_PKG_HOMEPAGE=https://golang.org/
MCHS_PKG_DESCRIPTION="Go programming language compiler"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
_MAJOR_VERSION=1.17.7
# Use the ~ deb versioning construct in the future:
MCHS_PKG_VERSION=3:${_MAJOR_VERSION}
MCHS_PKG_SRCURL=https://storage.googleapis.com/golang/go${_MAJOR_VERSION}.src.tar.gz
MCHS_PKG_SHA256=c108cd33b73b1911a02b697741df3dea43e01a5c4e08e409e8b3a0e3745d2b4d
MCHS_PKG_DEPENDS="clang"
MCHS_PKG_NO_STATICSPLIT=true

mchs_step_make_install() {
	mchs_setup_golang

	MCHS_GOLANG_DIRNAME=${GOOS}_$GOARCH
	MCHS_GODIR=$MCHS_PREFIX/lib/go
	local LINKER=/system/bin/linker
	if [ "${MCHS_ARCH}" == "x86_64" ] || [ "${MCHS_ARCH}" == "aarch64" ]; then
		LINKER+=64
	fi
	cd $MCHS_PKG_SRCDIR/src
	# Unset PKG_CONFIG to avoid the path being hardcoded into src/cmd/cgo/zdefaultcc.go,
	# see https://github.com/mchs/mchs-packages/issues/3505.
	env CC_FOR_TARGET=$CC \
	    CXX_FOR_TARGET=$CXX \
	    CC=gcc \
	    GO_LDFLAGS="-extldflags=-pie" \
	    GO_LDSO="$LINKER" \
	    GOROOT_BOOTSTRAP=$GOROOT \
	    GOROOT_FINAL=$MCHS_GODIR \
	    PKG_CONFIG= \
	    ./make.bash

	cd ..
	rm -Rf $MCHS_GODIR
	mkdir -p $MCHS_GODIR/{bin,src,doc,lib,pkg/tool/$MCHS_GOLANG_DIRNAME,pkg/include,pkg/${MCHS_GOLANG_DIRNAME}}
	cp bin/$MCHS_GOLANG_DIRNAME/{go,gofmt} $MCHS_GODIR/bin/
	ln -sfr $MCHS_GODIR/bin/go $MCHS_PREFIX/bin/go
	ln -sfr $MCHS_GODIR/bin/gofmt $MCHS_PREFIX/bin/gofmt
	cp VERSION $MCHS_GODIR/
	cp pkg/tool/$MCHS_GOLANG_DIRNAME/* $MCHS_GODIR/pkg/tool/$MCHS_GOLANG_DIRNAME/
	cp -Rf src/* $MCHS_GODIR/src/
	cp -Rf doc/* $MCHS_GODIR/doc/
	cp pkg/include/* $MCHS_GODIR/pkg/include/
	cp -Rf lib/* $MCHS_GODIR/lib
	cp -Rf pkg/${MCHS_GOLANG_DIRNAME}/* $MCHS_GODIR/pkg/${MCHS_GOLANG_DIRNAME}/
	cp -Rf misc/ $MCHS_GODIR/
}

mchs_step_post_massage() {
	find . -path '*/testdata*' -delete
}

MCHS_PKG_HOMEPAGE=https://gn.googlesource.com/gn
MCHS_PKG_DESCRIPTION="Meta-build system that generates build files for Ninja"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="Yaksh Bariya <yakshbari4@gmail.com>"
# While updating commit hash here also update it in
# mchs_setup_gn
_COMMIT=e0afadf7a743d5b14737bd454df45d5f1caf0d23
MCHS_PKG_VERSION=20211203
MCHS_PKG_RECOMMENDS="ninja"
MCHS_PKG_SKIP_SRC_EXTRACT=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_get_source() {
	MCHS_PKG_SRCURL=https://gn.googlesource.com/gn/+archive/$_COMMIT.tar.gz
	# Prevent caching of builds
	rm -rf $MCHS_PKG_SRCDIR
	# FIXME: We would like to enable checksums when downloading
	# tar files, but they change each time as the tar metadata
	# differs: https://github.com/google/gitiles/issues/84
	GN_TARFILE=$MCHS_PKG_CACHEDIR/gn_$_COMMIT.tar.gz
	test ! -f $GN_TARFILE && mchs_download \
		$MCHS_PKG_SRCURL \
		$GN_TARFILE \
		SKIP_CHECKSUM
	mkdir -p $MCHS_PKG_SRCDIR
	tar xf $GN_TARFILE -C $MCHS_PKG_SRCDIR
}

mchs_step_configure() {
	./build/gen.py \
		--no-last-commit-position \
		--no-static-libstdc++

	cat <<- EOF > ./out/last_commit_position.h
	#ifndef OUT_LAST_COMMIT_POSITION_H_
	#define OUT_LAST_COMMIT_POSITION_H_
	#define LAST_COMMIT_POSITION_NUM 1953
	#define LAST_COMMIT_POSITION "1953 ${_COMMIT:0:8}"
	#endif  // OUT_LAST_COMMIT_POSITION_H_
	EOF
}

mchs_step_make() {
	mchs_setup_ninja
	ninja -C out/
}

mchs_step_make_install() {
	install -Dm755 -t $MCHS_PREFIX/bin out/gn
}

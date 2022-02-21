MCHS_PKG_HOMEPAGE=https://github.com/mitnk/cicada
MCHS_PKG_DESCRIPTION="A bash like Unix shell"
MCHS_PKG_MAINTAINER="Hugo Wang <w@mitnk.com>"
MCHS_PKG_LICENSE="MIT"
MCHS_PKG_VERSION=0.9.25
MCHS_PKG_SRCURL=https://github.com/mitnk/cicada/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=86c2d0bcd5ea7118358b3138fea0753ada081f7fcceee59646d37b4a8186f99f
MCHS_PKG_AUTO_UPDATE=true
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_BLACKLISTED_ARCHES="arm, i686"

mchs_step_pre_configure() {
	rm -f Makefile

	if [ "$MCHS_ARCH" == "x86_64" ]; then
		local libdir=target/x86_64-linux-android/release/deps
		mkdir -p $libdir
		pushd $libdir
		local libgcc="$($CC -print-libgcc-file-name)"
		echo "INPUT($libgcc -l:libunwind.a)" > libgcc.so
		popd
	fi
}

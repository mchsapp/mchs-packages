MCHS_PKG_HOMEPAGE=http://www.softsynth.com/pforth/
MCHS_PKG_DESCRIPTION="Portable Forth in C"
MCHS_PKG_LICENSE="Public Domain"
MCHS_PKG_MAINTAINER="@mchs"
_COMMIT=1aa4eb4976630fdb6882bb3aacb97aa09f69571e
MCHS_PKG_VERSION=20211129
MCHS_PKG_SRCURL=https://github.com/philburk/pforth/archive/${_COMMIT}.zip
MCHS_PKG_SHA256=f06e5142d37c203a706057b303db18494919069583414731e2578ac374c01f61
MCHS_PKG_HOSTBUILD=true
MCHS_PKG_BUILD_IN_SRC=true

mchs_step_host_build() {
	mchs_setup_cmake

	cp -a $MCHS_PKG_SRCDIR/* .

	mkdir -p 32bit
	# Add -Wno-shift-count-overflow to ignore:
	# /home/builder/.mchs-build/pforth/src/csrc/pf_save.c:223:34: error: right shift count >= width of type [-Werror=shift-count-overflow
	#   223 |         *addr++ = (uint8_t) (data>>56);
	#       |                                  ^~
	CC="gcc -m32" CFLAGS="-Wno-shift-count-overflow" cmake .
	make
	install -m700 fth/pforth 32bit/
	install -m600 csrc/pfdicdat.h 32bit/

	rm -rf CMakeCache.txt CMakeFiles

	mkdir -p 64bit
	cmake .
	make
	install -m700 fth/pforth 64bit/
	install -m600 csrc/pfdicdat.h 64bit/
}

mchs_step_post_configure() {
	if [ $MCHS_ARCH_BITS = "32" ]; then
		local folder=32bit
	else
		local folder=64bit
	fi
	cp $MCHS_PKG_HOSTBUILD_DIR/$folder/pforth fth/
	cp $MCHS_PKG_HOSTBUILD_DIR/$folder/pfdicdat.h csrc/
}

mchs_step_make_install() {
	install -m700 fth/pforth_standalone $MCHS_PREFIX/bin/pforth
}

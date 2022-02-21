MCHS_PKG_HOMEPAGE=https://www.openfoam.com
MCHS_PKG_DESCRIPTION="OpenFOAM is a CFD software written in C++"
MCHS_PKG_MAINTAINER="Henrik Grimler @Grimler91"
MCHS_PKG_LICENSE="GPL-3.0"
MCHS_PKG_VERSION=2112
MCHS_PKG_SRCURL=https://develop.openfoam.com/Development/openfoam/-/archive/OpenFOAM-v${MCHS_PKG_VERSION}/openfoam-OpenFOAM-v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=ede3e2f6d7aed50969e5b9dbc06a0667f6d69b0d76adfc53f474d9ba5bf42272
MCHS_PKG_DEPENDS="openmpi, flex, boost, cgal, fftw, readline, libc++"
MCHS_PKG_GROUPS="science"
MCHS_PKG_RM_AFTER_INSTALL="opt/OpenFOAM-v${MCHS_PKG_VERSION}/build"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HOSTBUILD=true

mchs_step_host_build() {
	(
		cd $MCHS_PKG_SRCDIR
		set +u
		source etc/bashrc WM_ARCH_OPTION=32 || true
		cd wmake/src
		make
		source ../../etc/bashrc WM_ARCH_OPTION=64 || true
		set -u
		make
	)
	mkdir -p platforms/tools
	mv $MCHS_PKG_SRCDIR/platforms/tools/linuxGcc platforms/tools/
	mv $MCHS_PKG_SRCDIR/platforms/tools/linux64Gcc platforms/tools/
}

mchs_step_pre_configure() {
	if [ "$MCHS_ARCH" == "aarch64" ]; then
		ARCH_FOLDER=linuxARM64Clang
		MCHS_COMPILER_PREFIX="aarch64-linux-android"
		ARCH=aarch64
	elif [ "$MCHS_ARCH" == "arm" ]; then
		ARCH_FOLDER=linuxARM7Clang
		MCHS_COMPILER_PREFIX="arm-linux-androideabi"
		ARCH=armv7l
	elif [ "$MCHS_ARCH" == "i686" ]; then
		ARCH_FOLDER=linuxClang
		MCHS_COMPILER_PREFIX="i686-linux-android"
		ARCH=i686
	elif [ "$MCHS_ARCH" == "x86_64" ]; then
		ARCH_FOLDER=linux64Clang
		MCHS_COMPILER_PREFIX="x86_64-linux-android"
		ARCH=x86_64
	fi
	sed -i "s%\@MCHS_COMPILER_PREFIX\@%${MCHS_COMPILER_PREFIX}%g" "$MCHS_PKG_SRCDIR/wmake/rules/General/Clang/c"
	sed -i "s%\@MCHS_COMPILER_PREFIX\@%${MCHS_COMPILER_PREFIX}%g" "$MCHS_PKG_SRCDIR/wmake/rules/General/Clang/c++"
	sed -i "s%\@MCHS_COMPILER_PREFIX\@%${MCHS_COMPILER_PREFIX}%g" "$MCHS_PKG_SRCDIR/wmake/rules/General/general"

	mkdir -p platforms/tools
	cp -r $MCHS_PKG_HOSTBUILD_DIR/platforms/tools/linux64Gcc platforms/tools/${ARCH_FOLDER}
	if [ $MCHS_ARCH_BITS = 32 ]; then
		cp -r $MCHS_PKG_HOSTBUILD_DIR/platforms/tools/linuxGcc platforms/tools/${ARCH_FOLDER}
	else
		cp -r $MCHS_PKG_HOSTBUILD_DIR/platforms/tools/linux64Gcc platforms/tools/${ARCH_FOLDER}
	fi
}

mchs_step_make() {
	# Set ARCH here again so that continued builds work
	if [ "$MCHS_ARCH" == "aarch64" ]; then
		ARCH=aarch64
	elif [ "$MCHS_ARCH" == "arm" ]; then
		ARCH=armv7l
	elif [ "$MCHS_ARCH" == "i686" ]; then
		ARCH=i686
	elif [ "$MCHS_ARCH" == "x86_64" ]; then
		ARCH=x86_64
	fi

	# Lots and lots of unset env. variables that "set -u"
	# complains about, so disable exit on error temporarily
	set +u
	source "$MCHS_PKG_SRCDIR"/etc/bashrc || true
	set -u
	unset LD_LIBRARY_PATH
	./Allwmake
	cd wmake/src
	make clean
	make
}

mchs_step_make_install() {
	mkdir -p $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/opt
	cp -a $MCHS_PKG_SRCDIR $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/opt/OpenFOAM-v${MCHS_PKG_VERSION}
}

mchs_step_post_make_install() {
	sed -i 's%$ARCH%$(uname -m)%g' $MCHS_PKG_MASSAGEDIR/$MCHS_PREFIX/opt/OpenFOAM-v${MCHS_PKG_VERSION}/etc/config.sh/settings
}

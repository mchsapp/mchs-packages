MCHS_PKG_HOMEPAGE=https://github.com/PojavLauncherTeam/mobile
MCHS_PKG_DESCRIPTION="Java development kit and runtime"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=17.0
MCHS_PKG_REVISION=17
MCHS_PKG_SRCURL=https://github.com/mchs/openjdk-mobile-mchs/archive/ec285598849a27f681ea6269342cf03cf382eb56.tar.gz
MCHS_PKG_SHA256=d7c6ead9d80d0f60d98d0414e9dc87f5e18a304e420f5cd21f1aa3210c1a1528
MCHS_PKG_DEPENDS="freetype, giflib, libandroid-shmem, libandroid-spawn, libiconv, zlib, xorgproto, libx11, libxcursor, libxext, cups, fontconfig, libjpeg-turbo, libpng, libxrender, libxtst, libxrandr, libxt, libxi"
MCHS_PKG_BUILD_DEPENDS="cups, fontconfig, libpng, libx11, libxrender"
MCHS_PKG_SUGGESTS="cups, fontconfig, libx11, libxrender"
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_HAS_DEBUG=false

mchs_step_pre_configure() {
	unset JAVA_HOME

	# Provide fake gcc.
	mkdir -p $MCHS_PKG_SRCDIR/wrappers-bin
	cat <<- EOF > $MCHS_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	#!/bin/bash
	name=\$(basename "\$0")
	if [ "\$name" = "android-wrapped-clang" ]; then
		name=gcc
		compiler=$CC
	else
		name=g++
		compiler=$CXX
	fi
	if [ "\$1" = "--version" ]; then
		echo "${MCHS_HOST_PLATFORM/arm/armv7a}-\${name} (GCC) 4.9 20140827 (prerelease)"
		echo "Copyright (C) 2014 Free Software Foundation, Inc."
		echo "This is free software; see the source for copying conditions.  There is NO"
		echo "warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."
		exit 0
	fi
	exec \$compiler "\${@/-fno-var-tracking-assignments/}"
	EOF
	chmod +x $MCHS_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	ln -sfr $MCHS_PKG_SRCDIR/wrappers-bin/android-wrapped-clang \
		$MCHS_PKG_SRCDIR/wrappers-bin/android-wrapped-clang++
	CC=$MCHS_PKG_SRCDIR/wrappers-bin/android-wrapped-clang
	CXX=$MCHS_PKG_SRCDIR/wrappers-bin/android-wrapped-clang++

	cat <<- EOF > $MCHS_STANDALONE_TOOLCHAIN/devkit.info
	DEVKIT_NAME="Android"
	DEVKIT_TOOLCHAIN_PATH="\$DEVKIT_ROOT"
	DEVKIT_SYSROOT="\$DEVKIT_ROOT/sysroot"
	EOF

	# OpenJDK uses same makefile for host and target builds, so we can't
	# easily patch usage of librt and libpthread. Using linker scripts
	# instead.
	echo 'INPUT(-lc)' > $MCHS_PREFIX/lib/librt.so
	echo 'INPUT(-lc)' > $MCHS_PREFIX/lib/libpthread.so
}

mchs_step_configure() {
	local jdk_ldflags="-L${MCHS_PREFIX}/lib -Wl,-rpath=$MCHS_PREFIX/opt/openjdk/lib -Wl,--enable-new-dtags"
	bash ./configure \
		--openjdk-target=$MCHS_HOST_PLATFORM \
		--with-extra-cflags="$CFLAGS $CPPFLAGS -DLE_STANDALONE -DANDROID -D__MCHS__=1" \
		--with-extra-cxxflags="$CXXFLAGS $CPPFLAGS -DLE_STANDALONE -DANDROID -D__MCHS__=1" \
		--with-extra-ldflags="${jdk_ldflags} -landroid-shmem -landroid-spawn" \
		--disable-precompiled-headers \
		--disable-warnings-as-errors \
		--enable-option-checking=fatal \
		--with-toolchain-type=gcc \
		--with-jvm-variants=server \
		--with-devkit="$MCHS_STANDALONE_TOOLCHAIN" \
		--with-debug-level=release \
		--with-cups-include="$MCHS_PREFIX/include" \
		--with-fontconfig-include="$MCHS_PREFIX/include" \
		--with-freetype-include="$MCHS_PREFIX/include/freetype2" \
		--with-freetype-lib="$MCHS_PREFIX/lib" \
		--with-giflib=system \
		--with-libjpeg=system \
		--with-libpng=system \
		--with-zlib=system \
		--x-includes="$MCHS_PREFIX/include/X11" \
		--x-libraries="$MCHS_PREFIX/lib" \
		--with-x="$MCHS_PREFIX/include/X11" \
		AR="$AR" \
		NM="$NM" \
		OBJCOPY="$OBJCOPY" \
		OBJDUMP="$OBJDUMP" \
		STRIP="$STRIP"
}

mchs_step_make() {
	cd build/linux-${MCHS_ARCH/i686/x86}-server-release
	make JOBS=1 images

	# Delete created library stubs.
	rm $MCHS_PREFIX/lib/librt.so $MCHS_PREFIX/lib/libpthread.so
}

mchs_step_make_install() {
	rm -rf $MCHS_PREFIX/opt/openjdk
	mkdir -p $MCHS_PREFIX/opt/openjdk
	cp -r build/linux-${MCHS_ARCH/i686/x86}-server-release/images/jdk/* \
		$MCHS_PREFIX/opt/openjdk/
	find $MCHS_PREFIX/opt/openjdk -name "*.debuginfo" -delete

	# OpenJDK is not installed into /prefix/bin.
	local i
	for i in $MCHS_PREFIX/opt/openjdk/bin/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		ln -sfr "$i" "$MCHS_PREFIX/bin/$(basename "$i")"
	done

	# Link manpages to location accessible by "man".
	mkdir -p $MCHS_PREFIX/share/man/man1
	for i in $MCHS_PREFIX/opt/openjdk/man/man1/*; do
		if [ ! -f "$i" ]; then
			continue
		fi
		gzip "$i"
		ln -sfr "${i}.gz" "$MCHS_PREFIX/share/man/man1/$(basename "$i").gz"
	done

	# Dependent projects may need JAVA_HOME.
	mkdir -p $MCHS_PREFIX/etc/profile.d
	echo "export JAVA_HOME=$MCHS_PREFIX/opt/openjdk" > \
		$MCHS_PREFIX/etc/profile.d/java.sh

	# Symlink external dependencies.
	local l
	for l in libandroid-shmem.so libandroid-spawn.so libfreetype.so \
		libiconv.so libz.so.1 libXext.so libX11.so libXrender.so \
		libXrender.so.1 libXrender.so.1.3.0 libXtst.so libXtst.so.6 \
		libXtst.so.6.1.0 libXi.so libxcb.so libXau.so libXdmcp.so \
		libfreetype.so libfontconfig.so; do
		ln -sfr $MCHS_PREFIX/lib/$l \
			$MCHS_PREFIX/opt/openjdk/lib/$l
	done
}

mchs_step_configure_meson() {
	mchs_setup_meson
	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $MCHS_MESON \
		$MCHS_PKG_SRCDIR \
		$MCHS_PKG_BUILDDIR \
		--cross-file $MCHS_MESON_CROSSFILE \
		--prefix $MCHS_PREFIX \
		--libdir lib \
		--buildtype minsize \
		--strip \
		$MCHS_PKG_EXTRA_CONFIGURE_ARGS
}

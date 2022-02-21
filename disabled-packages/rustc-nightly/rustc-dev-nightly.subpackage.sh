MCHS_SUBPKG_DESCRIPTION="developer compiler libs"
INCLUDED=$(sed 's/^...../opt\/rust-nightly\//' $MCHS_PKG_BUILDDIR/install/rustc-dev-nightly-$CARGO_TARGET_NAME/rustc-dev/manifest.in | grep -v '\.so$' )
MCHS_SUBPKG_INCLUDE="$INCLUDED"

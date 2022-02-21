MCHS_SUBPKG_DESCRIPTION="developer compiler libs"
INCLUDED=$(sed 's/^.....//' $MCHS_PKG_BUILDDIR/rustc-dev-$MCHS_PKG_VERSION-$CARGO_TARGET_NAME/rustc-dev/manifest.in | grep -v '\.so$' )
MCHS_SUBPKG_INCLUDE="$INCLUDED"

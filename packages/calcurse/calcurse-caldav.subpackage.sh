MCHS_SUBPKG_INCLUDE="bin/calcurse-caldav"
MCHS_SUBPKG_DESCRIPTION="Sync calcurse with remote caldav calendar"
MCHS_SUBPKG_DEPENDS="python"
MCHS_SUBPKG_REPLACES="calcurse (<< 4.7.1-1)"
MCHS_SUBPKG_BREAKS="calcurse (<< 4.7.1-1)"

mchs_step_create_subpkg_debscripts() {
	echo "#!$MCHS_PREFIX/bin/sh" > postinst
	echo "pip3 install httplib2" >> postinst
}

MCHS_PKG_HOMEPAGE=https://launchpad.net/intltool
MCHS_PKG_DESCRIPTION="The internationalization tool collection"
MCHS_PKG_MAINTAINER="@suhan-paradkar"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_VERSION=0.51.0
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://launchpad.net/intltool/trunk/$MCHS_PKG_VERSION/+download/intltool-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd
MCHS_PKG_DEPENDS="perl"
MCHS_PKG_PLATFORM_INDEPENDENT=true

mchs_step_create_debscripts()  {
	cat <<- POSTINST_EOF > ./postinst
	#!$MCHS_PREFIX/bin/bash
	set -e

	echo "Sideloading Perl XML::Parser..."
	cpan install XML::Parser

	exit 0
	POSTINST_EOF
}

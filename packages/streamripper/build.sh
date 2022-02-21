MCHS_PKG_HOMEPAGE=http://streamripper.sourceforge.net/
MCHS_PKG_DESCRIPTION="Records and splits streaming mp3 into tracks"
MCHS_PKG_LICENSE="GPL-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=1.64.6
MCHS_PKG_REVISION=1
MCHS_PKG_SRCURL=https://downloads.sourceforge.net/sourceforge/streamripper/streamripper-$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=c1d75f2e9c7b38fd4695be66eff4533395248132f3cc61f375196403c4d8de42
MCHS_PKG_DEPENDS="glib, libmad, libvorbis"
MCHS_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_pthread_pthread_create=yes"

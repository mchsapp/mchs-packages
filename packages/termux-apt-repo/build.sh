MCHS_PKG_HOMEPAGE=https://github.com/mchs/mchs-apt-repo
MCHS_PKG_DESCRIPTION="Script to create McHs apt repositories"
MCHS_PKG_LICENSE="Apache-2.0"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=0.4
MCHS_PKG_SRCURL=https://github.com/mchs/mchs-apt-repo/archive/v${MCHS_PKG_VERSION}.tar.gz
MCHS_PKG_SHA256=54ea18d06d234d18ab8f7b264c4bd045651eb7908fa3850974b6560c7fb34af3
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_PLATFORM_INDEPENDENT=true
# binutils for ar:
MCHS_PKG_DEPENDS="binutils, python, tar"

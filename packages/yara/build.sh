MCHS_PKG_HOMEPAGE=https://github.com/VirusTotal/yara
MCHS_PKG_DESCRIPTION="Tool aimed at helping malware researchers to identify and classify malware samples"
MCHS_PKG_LICENSE="BSD 3-Clause"
MCHS_PKG_MAINTAINER="@mchs"
MCHS_PKG_VERSION=4.1.3
MCHS_PKG_REVISION=2
MCHS_PKG_SRCURL=https://github.com/VirusTotal/yara/archive/v$MCHS_PKG_VERSION.tar.gz
MCHS_PKG_SHA256=3610ddd0c3645b8b9cfa7cfbafc0146f2df751ad8d6cd261a638bfff81efbc32
MCHS_PKG_DEPENDS="file, openssl"
MCHS_PKG_BREAKS="yara-dev"
MCHS_PKG_REPLACES="yara-dev"

mchs_step_pre_configure() {
	./bootstrap.sh
}

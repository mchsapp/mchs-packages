MCHS_PKG_HOMEPAGE=https://rtmpdump.mplayerhq.hu/
MCHS_PKG_DESCRIPTION="Small dumper for media content streamed over the RTMP protocol"
MCHS_PKG_LICENSE="LGPL-2.1"
MCHS_PKG_MAINTAINER="@mchs"
# NOTE: Special handling of unofficial support for openssl 1.1 from
# https://gitlab.com/JudgeZarbi/RTMPDump-OpenSSL-1.1
MCHS_PKG_VERSION=2.4
MCHS_PKG_REVISION=4
MCHS_PKG_SRCURL=https://gitlab.com/JudgeZarbi/RTMPDump-OpenSSL-1.1/-/archive/019592918b0f961104eaf71b56c1db0fa26ed497/RTMPDump-OpenSSL-1.1-019592918b0f961104eaf71b56c1db0fa26ed497.tar.bz2
MCHS_PKG_SHA256=42978d5b1cfe9fe4e01305f81c183935056a6c1ad46b9cd2e582f9147196fa87
MCHS_PKG_BUILD_IN_SRC=true
MCHS_PKG_DEPENDS="openssl, zlib"
MCHS_PKG_BREAKS="rtmpdump-dev"
MCHS_PKG_REPLACES="rtmpdump-dev"

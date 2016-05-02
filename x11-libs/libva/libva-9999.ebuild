# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libva/libva-9999.ebuild,v 1.0 2011/06/01 12:25:00 alexb38 Exp $

EAPI="3"
inherit git-2 autotools

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="http://cgit.freedesktop.org/libva/"
EGIT_REPO_URI="git://anongit.freedesktop.org/git/libva"

LICENSE="MIT"
SLOT="0"
IUSE="opengl static-libs"

VIDEO_CARDS="dummy nvidia intel" # fglrx
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

RDEPEND=">=x11-libs/libdrm-2.4
	video_cards_intel? ( >=x11-libs/libdrm-2.4.25 )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXfixes
	opengl? ( virtual/opengl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
PDEPEND="video_cards_nvidia? ( x11-libs/vdpau-video )"
	#video_cards_fglrx? ( x11-libs/xvba-video )

src_unpack() {
	git_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}"/libva-9999-no-tests.patch
	eautoreconf
}

src_configure() {
	econf \
	$(use_enable video_cards_dummy dummy-driver) \
	$(use_enable video_cards_intel i965-driver) \
	$(use_enable opengl glx) \
	$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	use static-libs || find "${D}" -name '*.la' -delete
}

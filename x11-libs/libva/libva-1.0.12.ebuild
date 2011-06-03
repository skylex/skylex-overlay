# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libva/libva-1.0.12.ebuild,v 1.0 2011/06/01 12:25:00 alexb38 Exp $

EAPI="3"
inherit autotools

DESCRIPTION="Video Acceleration (VA) API for Linux"
HOMEPAGE="http://cgit.freedesktop.org/libva/"
SRC_URI="http://cgit.freedesktop.org/${PN}/snapshot/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opengl static-libs"

S="${WORKDIR}/${P}"

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

src_prepare() {
	epatch "${FILESDIR}"/libva-dont-install-tests.patch
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

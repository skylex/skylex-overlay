# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libspotify/libspotify-0.0.8.ebuild,v 0.1 2011/05/29 00:36:00 alexb38 Exp $

EAPI="2"

DESCRIPTION="The libspotify C API package allows third party developers to write applications that utilize the Spotify music streaming service."
HOMEPAGE="http://developer.spotify.com/en/libspotify/overview/"
SRC_URI="x86? ( http://developer.spotify.com/download/${PN}/${P}-linux6-i686.tar.gz )
        amd64? ( http://developer.spotify.com/download/${PN}/${P}-linux6-x86_64.tar.gz )"

LICENSE="Spotify"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

if use x86; then
 S="${WORKDIR}/${P}-linux6-i686"
elif use amd64; then
 S="${WORKDIR}/${P}-linux6-x86_64"
fi

src_prepare() {
	sed -i "s/byte/byte2000/g" "${S}/include/libspotify/api.h"
}

src_compile() {
	return
}

src_install() {
	emake prefix="${D}" install || die "Install failed"
	dodoc README ChangeLog || die
}

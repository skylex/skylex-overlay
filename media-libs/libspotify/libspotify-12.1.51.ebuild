# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libspotify/libspotify-12.1.51.ebuild,v 0.1 2016/05/02 17:46:00 alexb38 Exp $

EAPI=3

DESCRIPTION="The libspotify C API package allows third-party developers to write applications that utilize the Spotify music streaming service."
HOMEPAGE="https://developer.spotify.com/technologies/libspotify/"
SRC_URI="x86? ( https://developer.spotify.com/download/${PN}/${P}-Linux-i686-release.tar.gz )
	amd64? ( https://developer.spotify.com/download/${PN}/${P}-Linux-x86_64-release.tar.gz )"

LICENSE="LibSpotify"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_compile() {
	# nothing to compile
	return
}

src_install() {
	if use x86; then
		cd "${P}-Linux-x86-release"
	elif use amd64; then
		cd "${P}-Linux-x86_64-release"
	else
		ewarn "Arch not supported, something went wrong"
		die 1
	fi

	sed -i 's#PKG_PREFIX:$(prefix)#PKG_PREFIX:$(real_prefix)#;s/ldconfig.*//' Makefile
	emake prefix="${D}/${DESTTREE}" real_prefix="${DESTTREE}" install

	dodoc ChangeLog LICENSE licenses.xhtml README

	# install man
	doman share/man3/*
}

: "${lbu:=/opt/LiveBootUtils}"
. "$lbu/scripts/common.func"

: "${dist:=$(lsb_release -cs)}"
: "${dist_arch:=$(dpkg --print-architecture)}"

: "${wine_pkg:=winehq-stable}"
: "${i386_pkgs:=libgl1-mesa-dri:i386 libtxc-dxtn-s2tc:i386 libxslt1.1:i386}"

: "${deb_repo:=https://dl.winehq.org/wine-builds/debian/}"
: "${repo_key_url:=https://dl.winehq.org/wine-builds/winehq.key}"
: "${rec_ignore:=libsane.*}"

installed_ver() {
  grep "^Version: " "$DESTDIR/var/lib/dpkg/info/${wine_pkg}.control" | cut -f2 -d" "
}

latest_ver() {
  curl -s "${deb_repo%/}/dists/${dist}/main/binary-${dist_arch}/Packages" | grep -e ^Package: -e ^Version: | grep -A1 -xF "Package: $wine_pkg" | grep ^Version | sort -V | tail -1 | cut -f2 -d" "
}

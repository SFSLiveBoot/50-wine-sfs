#!/bin/sh

set -eu

test -n "${USRMERGE+set}" || test ! -L /lib || USRMERGE=1

mv_rec() {
    local src="$1" dst="$2" f
    test -e "$src" -o -L "$src" || return
    if test -d "$dst";then
      for f in "$src"/*;do
        mv_rec "$f" "$dst/${f##*/}"
      done
      rmdir "$src"
    else
      mv "$src" "$dst"
    fi
}

test -z "${USRMERGE:+set}" || {
  for n in lib bin sbin lib32 lib64 libx32;do
    test ! -L "$DESTDIR/$n" || continue
    test -d "$DESTDIR/$n" || continue
    mv_rec "$DESTDIR/$n" "$DESTDIR/usr/$n"
    ln -s "usr/$n" "$DESTDIR/$n"
  done
}

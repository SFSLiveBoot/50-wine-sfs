#!/bin/sh

set -e
. "$(dirname "$0")/.common.sh"

test -z "$backport_pkgs" ||
  build_i386=1 /opt/bin/backport-deb.sh $backport_pkgs

#!/bin/bash
# check glibc symbol versions on all libs and report anything > GLIBC 2.7

[ "${OSTYPE#linux}" = "$OSTYPE" ] && { echo "This script is for Linux"; exit 1; }

check() {
	echo $1
	(cd bin/$1
	for f in *.so luajit-bin; do
		s="$(objdump -T $f | grep GLIBC_ | grep -v 'GLIBC_2\.[0-7][\ \.]')"
		[ "$s" ] && printf "%-20s %s\n" "$f" "$s"
	done
	)
}

check linux32
[ "$(uname -m)" = "x86_64" ] && check linux64

#!/bin/bash -ex

./autogen.sh
./configure --prefix=/ --docdir=/ --with-latexdir=/
make all
file=$(sed -n 's/AC_INIT(\[\(.*\)\], \[\(.*\)\], .*/\1/p' configure.ac)
version=$(sed -n 's/AC_INIT(\[\(.*\)\], \[\(.*\)\], .*/\2/p' configure.ac)
DESTDIR=$(pwd)/${file} make install
tar czf ${file}-${version}-ctan.tar.gz ${file}
DESTDIR=$(pwd)/${file} make uninstall maintainer-clean
for d in $(sed -n 's/SUBDIRS *= *//p' makefile.am); do
    rmdir ${file}/${d}
done
rmdir ${file}
set +x
echo "====================================================================="
echo "File is ready for CTAN upload:"
echo "${file}-${version}-ctan.tar.gz"
echo "====================================================================="

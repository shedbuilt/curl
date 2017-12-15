#!/bin/bash
./configure --prefix=/usr                           \
            --disable-static                        \
            --enable-threaded-resolver              \
            --with-ca-path=/etc/ssl/certs
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} install
rm -rf docs/examples/.deps
find docs \( -name Makefile\* \
          -o -name \*.1       \
          -o -name \*.3 \)    \
          -exec rm {} \;
install -v -d -m755 ${SHED_FAKEROOT}/usr/share/doc/curl-7.55.1
cp -v -R docs/* ${SHED_FAKEROOT}/usr/share/doc/curl-7.55.1

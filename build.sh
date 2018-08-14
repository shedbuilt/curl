#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}
# Configure
./configure --prefix=/usr                           \
            --disable-static                        \
            --enable-threaded-resolver              \
            --with-ca-path=/etc/ssl/certs &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install &&
rm -rf docs/examples/.deps || exit 1
# Install Documentation
if [ -n "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    find docs \( -name Makefile\* \
              -o -name \*.1       \
              -o -name \*.3 \)    \
              -exec rm {} \; &&
    install -vdm755 "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}" &&
    cp -v -R docs/* "${SHED_FAKE_ROOT}${SHED_PKG_DOCS_INSTALL_DIR}"
fi

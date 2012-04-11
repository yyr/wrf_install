#!/bin/bash
. $appsdir/LIBPNG.env
cd $WRF_BASE/src/${DIR}

echo $(pwd)
./configure --prefix=$LIBPNG_ROOT | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

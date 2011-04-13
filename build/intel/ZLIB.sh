#!/bin/bash
. $WRF_ROOT/ZLIB.env
cd $WRF_ROOT/src/
rm -r ${DIR}
tar zxf ${APP}.${EXT}
cd ${DIR}
rm CMakeCache.txt
cmake -DCMAKE_INSTALL_PREFIX:path=/opt/wrf/bin/intel/zlib-1.2.5 . | tee ${APP}.${COMP}.config
make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee $SZIP.${COMP}.install

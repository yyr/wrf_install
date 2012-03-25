#!/bin/bash
. $appsdir/HDF5.env             # find out dependencies
cd $WRF_BASE/src/${DIR}
echo $(pwd)

for dep in ${DEP[@]}; do        # soruce dep envs
    source $appsdir/$dep.env
done

./configure \
    --prefix=$HDF5_ROOT \
    --exec-prefix=$HDF5_ROOT \
    --enable-fortran \
    --with-zlib=$ZLIB_ROOT \
    --with-szlib=$SZIP_ROOT \
    --with-pic | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

#!/bin/bash
. $appsdir/HDF4.env             # find out dependencies
cd $WRF_BASE/src/${DIR}

for dep in ${DEP[@]}; do        # soruce dep envs
    source $appsdir/$dep.env
done
. $appsdir/HDF4.env             # retain app name and other details

echo $(pwd)

./configure \
    --prefix=$HDF4_ROOT \
    --exec-prefix=$HDF4_ROOT \
    --includedir=$HDF4_ROOT/include/hdf \
    --enable-fortran \
    --with-zlib=$ZLIB_ROOT \
    --with-szlib=$SZIP_ROOT \
    --with-jpeg=$JPEG_ROOT \
    --disable-netcdf
    --with-pic | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make all 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

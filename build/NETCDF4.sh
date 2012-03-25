#!/bin/bash
source $appsdir/NETCDF4.env
cd $WRF_BASE/src/${DIR}
echo $(pwd)

for dep in ${DEP[@]}; do # soruce dep envs
    source $appsdir/$dep.env
done
source $appsdir/NETCDF4.env              # retain app name and other details

# export CPPFLAGS="$CPPFLAGS -I${HDF5_ROOT}/include \
#   -I${ZLIB_ROOT}/include \
#   -I${SZIP_ROOT}/include"
# export LDFLAGS="$LDFLAGS -L${HDF5_ROOT}/lib \
#    -L${ZLIB_ROOT}/lib \
#    -L${SZIP_ROOT}/lib"

./configure \
    --prefix=$NETCDF4_ROOT \
    --enable-fortran \
    --enable-udunits \
    --with-zlib=$ZLIB_ROOT \
    --with-szlib=$SZIP_ROOT \
    --with-hdf5=$HDF5_ROOT \
    --with-pic \
    --with-libcf \
    --disable-dap | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

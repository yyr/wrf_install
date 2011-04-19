#!/bin/bash
. $WRF_BASE/ZLIB.env
. $WRF_BASE/SZIP.env
. $WRF_BASE/HDF5.env
. $WRF_BASE/NETCDF4.env
cd $WRF_BASE/src/
cd ${DIR}
./configure \
--prefix=$NETCDF4_ROOT \
--enable-fortran \
--with-zlib=$ZLIB_ROOT \
--with-szlib=$SZIP_ROOT \
--with-hdf5=$HDF5_ROOT \
--with-pic \
--disable-dap | tee ${APP}.${COMP}.config
make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

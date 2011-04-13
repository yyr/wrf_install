#!/bin/bash
. /opt/wrf/SETTINGS.env
. $WRF_PATH/INTEL.env
. $WRF_PATH/ZLIB.env
ZLIB_PATH=$WRF_PATH/bin/$COMP/$APP
. $WRF_PATH/SZIP.env
SZIP_PATH=$WRF_PATH/bin/$COMP/$APP
. $WRF_PATH/HDF5.env
cd $WRF_PATH/src/
rm -r ${DIR}
tar zxf ${APP}.${EXT}
cd ${DIR}
. $INTEL_COMPILER_TOPDIR/bin/intel64/iccvars_intel64.sh
. $INTEL_COMPILER_TOPDIR/bin/intel64/ifortvars_intel64.sh
#export CC=gcc
#export FC=gfortran
#export CXX=''
export CC=icc 
export CXX=icpc 
export F77=ifort 
export CFLAGS='-O3 -xP -ip' 
export CXXFLAGS='-O3 -xP -ip' 
export FFLAGS='-O3 -xP -ip' 
./configure \
--prefix=$WRF_PATH/bin/${COMP}/${APP} \
--enable-fortran \
--with-zlib=$ZLIB_PATH \
--with-szlib=$SZIP_PATH \
--with-pic | tee ${APP}.${COMP}.config
make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee $SZIP.${COMP}.install

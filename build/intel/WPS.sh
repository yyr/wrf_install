##!/bin/bash
COMP=gcc
. $INSTALL_PATH/JASPER.env
JASPER_PATH=$INSTALL_PATH/bin/$COMP/$APP
. $INSTALL_PATH/ZLIB.env
ZLIB_PATH=$INSTALL_PATH/bin/$COMP/$APP
. $INSTALL_PATH/SZIP.env
SZIP_PATH=$INSTALL_PATH/bin/$COMP/$APP
. $INSTALL_PATH/HDF5.env
HDF5_PATH=$INSTALL_PATH/bin/$COMP/$APP
. $INSTALL_PATH/NETCDF4.env
NETCDF4_PATH=$INSTALL_PATH/bin/$COMP/$APP
. $INSTALL_PATH/WPS.env
cd $INSTALL_PATH/src/
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
#./configure \
#--prefix=$INSTALL_PATH/bin/${COMP}/${APP} \
#--enable-fortran \
#--with-zlib=$ZLIB_PATH \
#--with-szlib=$SZIP_PATH \
#--with-hdf5=$HDF5_PATH \
#--with-pic | tee ${APP}.${COMP}.config
#make clean 2>&1 | tee ${APP}.${COMP}.clean
#make 2>&1 | tee ${APP}.${COMP}.make
#make check 2>&1 | tee ${APP}.${COMP}.check
#make install 2>&1 | tee $SZIP.${COMP}.install
export NETCDF=${NETCDF4_PATH}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export WRF_DA_CORE=0
export JASPERLIB=${JASPER_PATH}/lib
export JASPERINC=${JASPER_PATH}/include
##!/bin/bash
COMP=intel
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
. $INSTALL_PATH/WRF.env
cd $INSTALL_PATH/src/
rm -r ${DIR}
tar zxf ${APP}.${EXT}
wget http://www.mmm.ucar.edu/wrf/src/fix/configure_fix.tar
tar xf configure_fix.tar
chmod +x configure

cd ${DIR}
. $INTEL_COMPILER_TOPDIR/bin/intel64/iccvars_intel64.sh
. $INTEL_COMPILER_TOPDIR/bin/intel64/ifortvars_intel64.sh
export CC=icc 
export CXX=icpc 
export F77=ifort 
export CFLAGS='-O3 -xP -ip' 
export CXXFLAGS='-O3 -xP -ip' 
export FFLAGS='-O3 -xP -ip' 
export NETCDF=${NETCDF4_PATH}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export WRF_DA_CORE=0
export JASPERLIB=${JASPER_PATH}/lib
export JASPERINC=${JASPER_PATH}/include

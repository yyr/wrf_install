#!/bin/bash
INSTALL_PATH=/opt/wrf
mkdir -p $INSTALL_PATH/src

#JASPER
APP=jasper-1.900.1
JASPER_PATH=$INSTALL_PATH/$APP
rm -rf $JASPER_PATH
cd $INSTALL_PATH/src
rm -rf ${APP}*
wget -c http://www.ece.uvic.ca/~mdadams/jasper/software/${APP}.zip
unzip ${APP}.zip ; cd ${APP}


# ZLIB
APP=zlib-1.2.5
ZLIB_PATH=$INSTALL_PATH/$APP
rm -rf $ZLIB_PATH
cd $INSTALL_PATH/src
rm -rf ${APP}*
wget -c http://zlib.net/${APP}.tar.gz
tar zxf ${APP}.tar.gz ; cd ${APP}
CC=gcc FC=gfortran CXX='' ./configure \
--prefix=$ZLIB_PATH | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install

# HDF5
APP=hdf5-1.8.6
HDF5_PATH=$INSTALL_PATH/$APP
rm -rf $HDF5_PATH
cd $INSTALL_PATH/src
rm -rf ${APP}*
wget -c http://www.hdfgroup.org/ftp/HDF5/${APP}/src/${APP}.tar.gz
tar xzf ${APP}.tar.gz ; cd ${APP}
CC=gcc FC=gfortran CXX='' ./configure \
--prefix=$HDF5_PATH \
--enable-fortran \
--with-zlib=$ZLIB_PATH \
--with-pic 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make install 2>&1 | tee $APP.install 

# NetCDF4
APP=netcdf-4.1.1
NETCDF4_PATH=$INSTALL_PATH/$APP
rm -rf $NETCDF4_PATH
cd $INSTALL_PATH/src
rm -rf ${APP}*
wget -c ftp://ftp.unidata.ucar.edu/pub/netcdf/${APP}.tar.gz
tar xzf ${APP}.tar.gz ; cd ${APP}
CC=gcc FC=gfortran F77=gfortran CXX='' ./configure \
--prefix=$NETCDF4_PATH \
--enable-fortran \
--enable-static \
--enable-shared\
--enable-f77 \
--disable-cxx \
--enable-netcdf4 \
--with-hdf5=$HDF5_PATH \
--with-zlib=$ZLIB_PATH \
--with-pic \
--disable-dap 2>&1 | tee $APP.config
make 2>&1 | tee $APP.make
make check 2>&1 | tee $APP.check
make install 2>&1 | tee $APP.install

# WRF
APP=WRFV3.2.1
WRF_PATH=$INSTALL_PATH/$APP
rm -rf $WRF_PATH
cd $INSTALL_PATH/src
rm -rf ${APP}*
wget -c http://www.mmm.ucar.edu/wrf/src/${APP}.TAR.gz
tar xzf ${APP}.TAR.gz ; cd WRFV3
./configure # choose 15
export NETCDF=/opt/wrf/netcdf-4.1.1
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export WRF_DA_CORE=0
./compile em_real 2>&1 | tee $APP.compile

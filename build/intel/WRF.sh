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

##!/bin/bash
. $SCRIPTS_DIR/JASPER.env
. $SCRIPTS_DIR/ZLIB.env
. $SCRIPTS_DIR/SZIP.env
. $SCRIPTS_DIR/HDF5.env
. $SCRIPTS_DIR/NETCDF4.env
. $SCRIPTS_DIR/NCARG.env

cd $NCARG_ROOT
if [ $COMP == "gcc" ]
then
    echo Installing for GCC
    tar zxf $WRF_BASE/src/cache/ncl_ncarg-6.0.0.Linux_Debian_x86_64_nodap_gcc445.tar.gz
fi

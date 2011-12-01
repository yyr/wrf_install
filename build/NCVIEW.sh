#!/bin/bash
#
# Copyright (C) Yagnesh Raghava Yakkala. http://yagnesh.org
#    File: NCVIEW.sh
# Created: Thursday, December  1 2011
# License: GPL v3 or later.  <http://www.gnu.org/licenses/gpl.html>
#

# Description:

. $SCRIPTS_DIR/ZLIB.env
. $SCRIPTS_DIR/SZIP.env
. $SCRIPTS_DIR/HDF5.env
. $SCRIPTS_DIR/NETCDF4.env
. $SCRIPTS_DIR/NEVIEW.env
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


# NCVIEW.sh ends here

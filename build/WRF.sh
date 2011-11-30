##!/bin/bash
. $SCRIPTS_DIR/WRF.env
cd $WRF_BASE/src

#tar zxf cache/${APP}.${EXT}
mv ${DIR} $WRF_ROOT
cd $WRF_ROOT

# ./configure < $SCRIPTS_DIR/build/configure.wrf.${COMP}.select
./configure < $SCRIPTS_DIR/build/configure.wrf.${COMP}.select

$SCRIPTS_DIR/build/configure.wrf.hdf5.sh
./compile em_real &> compile.log

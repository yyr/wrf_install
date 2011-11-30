##!/bin/bash
. $SCRIPTS_DIR/WPS.env
cd $WRF_BASE/src
tar zxf cache/${APP}.${EXT}
mv ${DIR} $WPS_ROOT
cd $WPS_ROOT
./configure < $SCRIPTS_DIR/build/configure.wps.${COMP}.select
$SCRIPTS_DIR/build/configure.wps.hdf5.sh
./compile &> compile.log

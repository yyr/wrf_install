##!/bin/bash
. $WRF_BASE/WPS.env
cd $WRF_BASE/src
tar zxf cache/${APP}.${EXT}
mv ${DIR} $WPS_ROOT
cd $WPS_ROOT
./configure < $WRF_BASE/build/configure.wps.${COMP}.select
$WRF_BASE/build/configure.wps.hdf5.sh
./compile &> compile.log

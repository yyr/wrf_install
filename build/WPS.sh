##!/bin/bash
. $SCRIPTS_DIR/WPS.env

# check folder is already present
if [ ! -d $WRF_BASE/$COMP/${DIR} ]; then
    cd $WRF_BASE/src
    tar zxf cache/${APP}.${EXT}
    mv ${DIR} $WPS_ROOT
fi

cd $WPS_ROOT

./clean -a # clean first
./configure  < $SCRIPTS_DIR/build/configure.wps.${COMP}.select
$SCRIPTS_DIR/build/configure.wps.hdf5.sh
$SCRIPTS_DIR/build/configure.wps.jasper.sh

# read dummy                      # manual inspection

./compile  2>&1 | tee log.${COMP}.compile

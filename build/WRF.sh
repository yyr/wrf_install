##!/bin/bash
. $SCRIPTS_DIR/WRF.env
cd $WRF_BASE/src

#tar zxf cache/${APP}.${EXT}
mv ${DIR} $WRF_ROOT
cd $WRF_ROOT

./clean -a         # clean first
./configure # < $SCRIPTS_DIR/build/configure.wrf.${COMP}.select

# read dummy                            # manual inspection
#$SCRIPTS_DIR/build/configure.wrf.hdf5.sh
./compile em_real  2>&1 | tee log.${COMP}.compile

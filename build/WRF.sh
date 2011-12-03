##!/bin/bash
. $SCRIPTS_DIR/WRF.env
cd $WRF_BASE/src

#tar zxf cache/${APP}.${EXT}
mv ${DIR} $WRF_ROOT
cd $WRF_ROOT

./clean -a         # clean first
./configure  < $SCRIPTS_DIR/build/configure.wrf.${COMP}.select

## auto tweak resulted configure.wrf (common issues followed by system specific)
$SCRIPTS_DIR/build/configure.wrf.hdf5.sh
#$SCRIPTS_DIR/build/configure.wrf.sgi.intel.sh # sgi mpi instead of mpich2

# read dummy                            # manual inspection

./compile em_real  2>&1 | tee log.${COMP}.compile

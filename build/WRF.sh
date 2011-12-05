##!/bin/bash
. $SCRIPTS_DIR/WRF.env

# check folder is already present
if [ ! -d $WRF_BASE/$COMP/${DIR} ]; then
    cd $WRF_BASE/src
    tar zxf cache/${APP}.${EXT}
    mv ${DIR} $WRF_ROOT
fi

cd $WRF_ROOT

./clean -a         # clean first
./configure  < $SCRIPTS_DIR/build/configure.wrf.${COMP}.select

## auto tweak resulted configure.wrf (common issues followed by system specific)
$SCRIPTS_DIR/build/configure.wrf.hdf5.sh

### machine specific tweaks (machine is set in bashrc)
$SCRIPTS_DIR/build/configure.wrf.${machine}.${COMP}.sh

# read dummy                            # manual inspection

./compile em_real  2>&1 | tee log.${COMP}.compile

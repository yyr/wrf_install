##!/bin/bash
. $appsdir/WRF.env             # find out dependencies

# check folder is already present
if [ ! -d $WRF_BASE/$COMP/${DIR} ]; then
    cd $WRF_BASE/src
    tar zxf ${APP}.${EXT}
    mv ${DIR} $WRF_ROOT
fi
cd $WRF_ROOT

for dep in ${DEP[@]}; do        # soruce dep envs
    source $appsdir/$dep.env
done
. $appsdir/WRF.env              # retain app name and other details

export NETCDF=${NETCDF4_ROOT}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export WRF_DA_CORE=0
export JASPERLIB=${JASPER_ROOT}/lib
export JASPERINC=${JASPER_ROOT}/include

./clean -a         # clean first
# ----------- run configure ---------------------------
## *IMPORTANT*: To automate the configuring, put number in
## "configure.wrf.${COMP}.select" your preffered selection
./configure
#./configure  < $SCRIPTS_DIR/build/configure.wrf.${COMP}.select

# ----------- tweak generated "configure.wrf" file -----------------
## common problems of configure.wrf should be fixed in the following script
$SCRIPTS_DIR/build/fix.configure.wrf.sh

# ----------- tweak generated "configure.wrf" file (compiler specific)------------
# for eg if you want to change configure.wrf file put some code in your
# check fix.configure.wrf.intel.sh
$SCRIPTS_DIR/${machine}/fix.configure.wrf.${COMP}.sh

#read dummy                            # manual inspection
./compile em_real  2>&1 | tee log.${COMP}.compile

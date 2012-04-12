##!/bin/bash

################### *IMPORTANT* ######################
# for em core
export WRF_EM_CORE=1
# export WRF_NMM_CORE=1 #  you want to build nmm core uncomment this line
######################################################

. $appsdir/WPS.env             # find out dependencies

# check folder is already present
if [ ! -d $WRF_BASE/$COMP/${DIR} ]; then
    cd $WRF_BASE/src
    tar zxf ${APP}.${EXT}
    mv ${DIR} $WPS_ROOT
fi
cd $WPS_ROOT

for dep in ${DEP[@]}; do        # soruce dep envs
    source $appsdir/$dep.env
done

. $appsdir/WPS.env              # retain app name and other details

export NETCDF=${NETCDF4_ROOT}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_DA_CORE=0
export JASPERLIB=${JASPER_ROOT}/lib
export JASPERINC=${JASPER_ROOT}/include

./clean -a # clean first

# ----------- run configure ---------------------------
## *IMPORTANT*: To automate the configuring, put
## "configure.wps.${COMP}.select" your preffered selection
./configure
#./configure  < $SCRIPTS_DIR/build/configure.wps.${COMP}.select

# ----------- tweak generated "configure.wps" file -----------------
## common problems of configure.wps should be fixed in the following script
$SCRIPTS_DIR/build/fix.configure.wps.sh

# ----------- tweak generated "configure.wps" file (compiler specific)------------
# for eg if you want to change configure.wps file put some code in your
# check fix.configure.wrf.intel.sh
$SCRIPTS_DIR/${machine}/fix.configure.wps.${COMP}.sh


# read dummy                      # manual inspection
./compile  2>&1 | tee log.${COMP}.compile

source ${SCRIPTS_DIR}/lib/fun.bash

#----------*IMPORTANT*--------------------------------------------------
export WRF_EM_CORE=1            # for em core
# export WRF_NMM_CORE=1         #  for nmm core
#-----------------------------------------------------------------------

# check folder is already present
if [ ! -d $WRF_BASE/$COMP/${DIR} ]; then
    cd $WRF_BASE/src
    tar zxf ${APP}.${EXT}
    mv ${DIR} $WPS_ROOT
fi
cd $WPS_ROOT

export WRF_DIR=$WRF_ROOT

export NETCDF=${NETCDF4_ROOT}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_DA_CORE=0
export JASPERLIB=${JASPER_ROOT}/lib
export JASPERINC=${JASPER_ROOT}/include

export LD_LIBRARY_PATH=${WRF_BASE}/$dep_root/lib:$LD_LIBRARY_PATH
export LIBINCLUDE="${WRF_BASE}/$dep_root/lib:${WRF_BASE}/$dep_root/include":$LIBINCLUDE

echo NETCDF=$NETCDF
echo WRFIO_NCD_LARGE_FILE_SUPPORT=$WRFIO_NCD_LARGE_FILE_SUPPORT
echo WRF_DA_CORE=$WRF_DA_CORE
echo JASPERLIB=$JASPERLIB
echo JASPERINC=$JASPERINC
echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH
echo LIBINCLUDE=$LIBINCLUDE

./clean -a
# ----------- run configure ---------------------------
# check configure selection file is available
if [ -f "$SCRIPTS_DIR/${machine}/configure.wps.${COMP}.select" ]; then
    ./configure  < $SCRIPTS_DIR/${machine}/configure.wps.${COMP}.select
else
    ./configure
    blue_echo "You can automate the selection of configuration option by editing/creating
\"$SCRIPTS_DIR/${machine}/configure.wps.${COMP}.select\" \n\n\n"

fi

red_echo " **IMPORTANT**
Moving to building WPS now. You can still change configure script
 $(pwd)/configure.wps for any final changes.

 Press ENTER to continue."

[[ $- == *i* ]] && read dummy


# ----------- tweak generated "configure.wps" file -----------------
## common problems of configure.wps should be fixed in the following script
# $SCRIPTS_DIR/build/fix.configure.wps.sh

# ----------- tweak generated "configure.wps" file (compiler specific)------------
# for eg if you want to change configure.wps file put some code in your
# check fix.configure.wps.intel.sh
# [ -f $SCRIPTS_DIR/${machine}/fix.configure.wps.${COMP}.sh ] &&
#     $SCRIPTS_DIR/${machine}/fix.configure.wps.${COMP}.sh

# read dummy                      # manual inspection
command_runner \
    ./compile  log.${COMP}.compile


# make symlinks to run folder is available. this is part of my workflow. see
# my folder structure at https://github.com/yyr/wrf-autorun#readme
[ -d ../../run/bin/ ] || mkdir -p ../../run/bin/
find . -iname '*.exe' -type f | xargs -t -I {} cp {} {}.$COMP
find $(pwd) -iname '*.exe.'${COMP} -type f | xargs -t -I {}  ln -sf {} ../../run/bin/

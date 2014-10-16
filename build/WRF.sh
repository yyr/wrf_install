source ${SCRIPTS_DIR}/lib/fun.bash

#----------*IMPORTANT*--------------------------------------------------
export WRF_EM_CORE=1        # for em core
# export WRF_NMM_CORE=1     #  for nmm core
#-----------------------------------------------------------------------

# check folder is already present
if [ ! -d $WRF_BASE/$COMP/${DIR} ]; then
    cd $WRF_BASE/src
    tar zxf ${APP}.${EXT}
    mv ${DIR} $WRF_ROOT
fi

cd $WRF_ROOT

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

./clean -a         # clean first

# ----------- run configure ---------------------------
# check configure selection file is available for automation.
if [ -f "$SCRIPTS_DIR/${machine}/configure.wrf.${COMP}.select" ]; then
    ./configure  < $SCRIPTS_DIR/${machine}/configure.wrf.${COMP}.select
else
    ./configure
    echo " **IMPORTANT**
You can automate the selection of configuration option by editing/creating
\"$SCRIPTS_DIR/${machine}/configure.wrf.${COMP}.select\" press ENTER to
continue to configure"
    read dummy
fi

# ----------- tweak generated "configure.wrf" file -----------------
## common problems of configure.wrf should be fixed in the following script
$SCRIPTS_DIR/build/fix.configure.wrf.sh

# ----------- tweak generated "configure.wrf" file (compiler specific)------------
# for eg if you want to change configure.wrf file put some code in your
# check fix.configure.wrf.intel.sh
[ -f $SCRIPTS_DIR/${machine}/fix.configure.wrf.${COMP}.sh ] &&
    $SCRIPTS_DIR/${machine}/fix.configure.wrf.${COMP}.sh

./compile em_real  2>&1 | tee log.${COMP}.compile


# make symlinks to run folder is available. this is part of my workflow. see
# my folder structure at https://github.com/yyr/wrf-autorun#readme
[ -d ../../run/bin/ ] || mkdir -p ../../run/bin/
find . -iname '*.exe' -type f | xargs -t -I {} cp {} {}.$COMP
find . -iname '*.exe.'${COMP} -type f | xargs -t -I {}  cp {} ../../run/bin/

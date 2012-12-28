################### *IMPORTANT* ######################
export WRF_EM_CORE=1 # for em core
# export WRF_NMM_CORE=1 #  for nmm core
######################################################

# check folder is already present
if [ ! -d $WRF_BASE/$COMP/${DIR} ]; then
    cd $WRF_BASE/src
    tar zxf ${APP}.${EXT}
    mv ${DIR} $WPS_ROOT
fi
cd $WPS_ROOT

export NETCDF=${NETCDF4_ROOT}
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_DA_CORE=0
export JASPERLIB=${JASPER_ROOT}/lib
export JASPERINC=${JASPER_ROOT}/include

./clean -a # clean first

# ----------- run configure ---------------------------
# check configure selection file is available
if [ -f "$SCRIPTS_DIR/${machine}/configure.wps.${COMP}.select" ]; then
    # selection is available
    ./configure  < $SCRIPTS_DIR/${machine}/configure.wps.${COMP}.select

    else

    echo "
**IMPORTANT**
you can automate the selection of configuration option by editing/creating
\"$SCRIPTS_DIR/${machine}/configure.wps.${COMP}.select\"
    press ENTER to continue to configure
"
    read dummy
    ./configure

fi

# ----------- tweak generated "configure.wps" file -----------------
## common problems of configure.wps should be fixed in the following script
$SCRIPTS_DIR/build/fix.configure.wps.sh

# ----------- tweak generated "configure.wps" file (compiler specific)------------
# for eg if you want to change configure.wps file put some code in your
# check fix.configure.wps.intel.sh
$SCRIPTS_DIR/${machine}/fix.configure.wps.${COMP}.sh


# read dummy                      # manual inspection
./compile  2>&1 | tee log.${COMP}.compile

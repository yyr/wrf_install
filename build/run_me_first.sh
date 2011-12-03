# location of automation scripts
export WRF_BASE=~/wrf
export SCRIPTS_DIR=~/git/wrf_install
compiler=INTEL
#compiler=GCC

# SYSTEM specific
export machine=sgi                # sgi altix
#export machine=ubuntu             # ubuntu 64


# ------------------------------------------
#
echo '*****************************************************************'
echo compiler=$compiler
echo machine=$machine
echo WRF_BASE=$WRF_BASE
echo SCRIPTS_DIR=$SCRIPTS_DIR
echo '*****************************************************************'
echo
# set envs for the COMPILER
. $SCRIPTS_DIR/${compiler}.env

# Local Variables:
# mode: sh
# End:
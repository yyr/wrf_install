#!/bin/bash
COMP=gcc
. $INSTALL_PATH/ZLIB.env
cd $INSTALL_PATH/src/
rm -r ${DIR}
tar zxf ${APP}.${EXT}
cd ${DIR}
. $INTEL_COMPILER_TOPDIR/bin/intel64/iccvars_intel64.sh
. $INTEL_COMPILER_TOPDIR/bin/intel64/ifortvars_intel64.sh
export CC=gcc
export FC=gfortran
export CXX=''
#export CC=icc 
#export CXX=icpc 
#export F77=ifort 
#export CFLAGS='-O3 -xP -ip' 
#export CXXFLAGS='-O3 -xP -ip' 
#export FFLAGS='-O3 -xP -ip' 
./configure --prefix=$INSTALL_PATH/bin/${COMP}/${APP} | tee ${APP}.${COMP}.config
make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee $SZIP.${COMP}.install

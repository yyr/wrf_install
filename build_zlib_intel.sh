#!/bin/sh
# Assumes wrf.env is sourced
cd $INSTALL_PATH/src/$ZLIB
#Setting environment variables for the Intel(R) C++ Compiler Professional Edition for Linux
. $INTEL_COMPILER_TOPDIR/bin/intel64/iccvars_intel64.sh
#If you want to install ZLIB  in the special directory then you should specify an installation
#prefix other than `/usr/local' using `--prefix'.
./configure --prefix=$INSTALL_PATH/intel/$ZLIB CC=icc CXX=icc
make
make install

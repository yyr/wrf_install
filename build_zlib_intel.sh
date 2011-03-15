#!/bin/sh
source wrf.env
#Setting environment variables for the Intel(R) C++ Compiler Professional Edition for Linux
. $INTEL_COMPILER_TOPDIR/bin/intel64/iccvars_intel64.sh
#If you want to install ZLIB  in the special directory then you should specify an installation
#prefix other than `/usr/local' using `--prefix'.
./configure --prefix=$ZLIB_PATH/intel CC=icc CXX=icc
make
make install

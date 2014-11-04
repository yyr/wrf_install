source ${SCRIPTS_DIR}/lib/fun.bash

export NETCDF4_ROOT
export NETCDF_INC
export NETCDF_LIB

command_runner \
    ./autogen.sh

command_runner \
    ./configure \
    --prefix=$NCO_ROOT \
    --includedir=$NETCDF4_ROOT/include \
    --libdir=$NETCDF4_ROOT/lib \
    --enable-fortran \
    --enable-netcdf4 \
    --enable-udunits2 \
    --enable-mpi \
    --disable-dap-netcdf  ${APP}.${COMP}.config

command_runner \
    make clean   ${APP}.${COMP}.clean
command_runner \
    make   ${APP}.${COMP}.make
# command_runner \
# make check   ${APP}.${COMP}.check
command_runner \
    make install   ${APP}.${COMP}.install

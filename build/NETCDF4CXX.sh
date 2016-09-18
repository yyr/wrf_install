source ${SCRIPTS_DIR}/lib/fun.bash

export CPPFLAGS="-I${HDF5_ROOT}/include -I${ZLIB_ROOT}/include -I${NETCDF4_ROOT}/include" LDFLAGS="-L${HDF5_ROOT}/lib -L${ZLIB_ROOT}/lib -L${NETCDF4_ROOT}/lib" LD_LIBRARY_PATH="${HDF5_ROOT}/lib ${ZLIB_ROOT}/lib ${NETCDF4_ROOT}/lib"

command_runner \
    ./configure \
    --prefix=$NETCDF4_ROOT \
    --enable-fortran \
    --enable-udunits \
    --with-zlib=$ZLIB_ROOT \
    --with-szlib=$SZIP_ROOT \
    --with-hdf5=$HDF5_ROOT \
    --with-pic \
    --with-libcf \
    --enable-shared \
    --disable-dap  ${APP}.${COMP}.config

command_runner \
    make clean   ${APP}.${COMP}.clean

command_runner \
    make   ${APP}.${COMP}.make

# command_runner \
# make check   ${APP}.${COMP}.check

command_runner \
    make install   ${APP}.${COMP}.install

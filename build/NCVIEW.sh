source ${SCRIPTS_DIR}/lib/fun.bash

command_runner \
    ./configure \
    --prefix=$NCVIEW_ROOT \
    --enable-fortran \
    --with-hdf5=$HDF5_ROOT \
    --with-nc-config=$NETCDF4_ROOT/bin/nc-config \
    --with-x \
    --with-udunits2_incdir=$UDUNITS2_ROOT/include \
    --with-udunits2_libdir=$UDUNITS2_ROOT/lib \
    ${APP}.${COMP}.config

command_runner \
    make clean   ${APP}.${COMP}.clean

command_runner \
    make   ${APP}.${COMP}.make

# command_runner \
# make check   ${APP}.${COMP}.check

command_runner \
    make install   ${APP}.${COMP}.install

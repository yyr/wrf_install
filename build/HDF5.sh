source ${SCRIPTS_DIR}/lib/fun.bash

command_runner \
    ./configure \
    --prefix=$HDF5_ROOT \
    --exec-prefix=$HDF5_ROOT \
    --enable-fortran \
    --with-zlib=$ZLIB_ROOT \
    --with-szlib=$SZIP_ROOT \
    --with-jpeg=$JPEG_ROOT \
    --with-pic  ${APP}.${COMP}.config

command_runner \
    make clean   ${APP}.${COMP}.clean
command_runner \
    make   ${APP}.${COMP}.make
# command_runner \
# make check   ${APP}.${COMP}.check
command_runner \
    make install   ${APP}.${COMP}.install

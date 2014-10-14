./configure \
    --prefix=$HDF4_ROOT \
    --exec-prefix=$HDF4_ROOT \
    --includedir=$HDF4_ROOT/include/hdf \
    --enable-fortran \
    --with-zlib=$ZLIB_ROOT \
    --with-jpeg=$JPEG_ROOT \
    --disable-netcdf
    --with-pic | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make all 2>&1 | tee ${APP}.${COMP}.make
# make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

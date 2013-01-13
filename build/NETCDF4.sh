export CFLAGS="-I${HDF5_ROOT}/include" LDFLAGS="-L${HDF5_ROOT}/lib $CPPFLAGS"

./configure \
    --prefix=$NETCDF4_ROOT \
    --enable-fortran \
    --enable-udunits \
    --with-zlib=$ZLIB_ROOT \
    --with-szlib=$SZIP_ROOT \
    --with-hdf5=$HDF5_ROOT \
    --with-pic \
    --with-libcf \
    --disable-dap | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

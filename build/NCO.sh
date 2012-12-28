export NETCDF4_ROOT
export NETCDF_INC
export NETCDF_LIB

./configure \
    --prefix=$NCO_ROOT \
    --enable-fortran \
    --enable-netcdf4 \
    --enable-udunits2 \
    --enable-mpi \
    --disable-dap-netcdf | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

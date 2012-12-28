./configure \
    --prefix=$GDAL_ROOT \
    --with-jpeg=$JPEG_ROOT \
    --with-png=$LIBPNG_ROOT \
    --with-jasper=$JASPER_ROOT \
    --with-netcdf=$NETCDF4_ROOT \
    --with-pic | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

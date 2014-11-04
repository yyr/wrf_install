export CFLAGS="$CFLAGS -DUSE_JPEG2000 -DUSE_PNG"

./configure --prefix=$G2LIB_ROOT \
    --with-jasper \
    | tee ${APP}.${COMP}.config
make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
# make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

./configure \
    --prefix=$UDUNITS2_ROOT \
    --exec-prefix=$UDUNITS2_ROOT \
    --with-pic | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install

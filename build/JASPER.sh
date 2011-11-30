#!/bin/bash
. $SCRIPTS_DIR/JASPER.env
cd $WRF_BASE/src/
cd ${DIR}
./configure --prefix=$JASPER_ROOT | tee ${APP}.${COMP}.config
make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install
ln -s $JASPER_ROOT/include $JASPER_ROOT/inc

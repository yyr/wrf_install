##!/bin/bash
. $WRF_BASE/WRF.env
cd $WRF_ROOT
rm -r ${DIR}
tar zxf ${APP}.${EXT}
wget http://www.mmm.ucar.edu/wrf/src/fix/configure_fix.tar
tar xf configure_fix.tar
chmod +x configure
cd ${DIR}

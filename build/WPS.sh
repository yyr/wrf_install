##!/bin/bash
. $WRF_BASE/WPS.env
cd $WRF_BASE/src
tar zxf cache/${APP}.${EXT}
mv ${DIR} $WRF_ROOT
cd $WRF_ROOT

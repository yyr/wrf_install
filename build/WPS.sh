##!/bin/bash
. $WRF_BASE/WPS.env
cd $WRF_BASE/src
tar zxf cache/${APP}.${EXT}
mv ${DIR} $WPS_ROOT
cd $WPS_ROOT

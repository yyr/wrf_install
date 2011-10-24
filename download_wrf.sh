#!/bin/bash
packages="HDF5 JASPER NETCDF4 SZIP ZLIB JPEG WPS WRF GRADS"

INSTALL_PATH=~/wrf/
# Setup source directory
mkdir -p $INSTALL_PATH/src      # make

# copy all env file to install path
cp *.env $INSTALL_PATH/

CLEAN_DOWN=$INSTALL_PATH/src/wrf_clean_downloads.sh
echo '#!/bin/bash' > $CLEAN_DOWN
chmod +x $CLEAN_DOWN
CLEAN_SRC=$INSTALL_PATH/src/wrf_clean_source.sh
echo '#!/bin/bash' > $CLEAN_SRC
chmod +x $CLEAN_SRC

for package in ${packages}
do
    echo Downloading... ${package}
    . $INSTALL_PATH/${package}.env
    echo rm ${APP}.${EXT} >> $CLEAN_DOWN
    wget -c ${URL} -P $INSTALL_PATH/src
    echo rm -rf ${DIR} >> $CLEAN_SRC
done

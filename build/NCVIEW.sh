#!/bin/bash
#
#    File: NCVIEW.sh
# Created: Thursday, December  1 2011

. $appsdir/NCVIEW.env
cd $WRF_BASE/src/${DIR}

for dep in ${DEP[@]}; do        # soruce dep envs
    source $appsdir/$dep.env
done

./configure \
    --prefix=$NCVIEW_ROOT \
    --enable-fortran \
    --with-hdf5=$HDF5_ROOT \
    --with-nc-config=$NETCDF4_ROOT/bin/nc-config \
    --with-x \
    --with-udunits2_incdir=$UDUNITS2_ROOT/include \
    --with-udunits2_libdir=$UDUNITS2_ROOT/lib \
     | tee ${APP}.${COMP}.config

make clean 2>&1 | tee ${APP}.${COMP}.clean
make 2>&1 | tee ${APP}.${COMP}.make
make check 2>&1 | tee ${APP}.${COMP}.check
make install 2>&1 | tee ${APP}.${COMP}.install


# NCVIEW.sh ends here

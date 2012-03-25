##!/bin/bash
. $appsdir/NCARG.env
cd $WRF_BASE/src/${DIR}

for dep in ${DEP[@]}; do        # soruce dep envs
    source $appsdir/$dep.env
done

cd $NCARG_ROOT
if [ $COMP == "gcc" ]
then
    echo Installing for GCC
    tar zxf $WRF_BASE/src/cache/ncl_ncarg-6.0.0.Linux_Debian_x86_64_nodap_gcc445.tar.gz
fi

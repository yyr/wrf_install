#!/bin/bash

function download_package()
{
    pack=$1
    echo Downloading... ${pack}
    echo
    . $SCRIPTS_DIR/${pack}.env
    wget -c ${URL} -P $WRF_BASE/src

    if [ $? -ne 0 ]; then
        echo "FAILED TO DOWNLOAD.. $pack ;("
            return 64
    else
        echo
        echo "Finished Downloading... $pack :)"
    fi

#    touch  $WRF_BASE/src/${APP}.${EXT} # for test

    # update generated scripts
    for x in $util_scr; do
        clean_line $pack $x
    done

    echo rm ${APP}.${EXT} \# $pack >> $CLEAN_DOWN
    echo rm -rf ${DIR} \# $pack >> $CLEAN_SRC
    case ${EXT} in
        *".gz"|*"tgz" )
            echo tar xzvf ${APP}.${EXT} \# $pack >> $EXTRACT_SRC ;;
        *"zip" )
            echo unzip ${APP}.${EXT} \# $pack >> $EXTRACT_SRC ;;
        * )
            echo echo "dont know how to extract this one:" ${APP}.${EXT} >> $EXTRACT_SRC ;;
    esac

}

function shebang ()
{
    file=$1
    if [ ! -f $file ]; then
        echo '#!/bin/bash' > $file
        chmod +x $file
        echo '#' >> $file       # just an extra comment line
    fi
}

function clean_line ()
{
    perl -i -ne "print unless m!$1!" $2
}

###########################################################################
# CODE STARTS FORM HERE

all_packages="
SZIP
ZLIB
JPEG
JASPER
HDF5
MPICH
NETCDF4
UDUNITS2
WPS
WRF
NCO
VAPOR
NCVIEW
WGRIB2
GRADS
" # env files should be present in the SCRIPTS_DIR

# check needed environment variables are present or not
env_error=24
if [ -z $WRF_BASE ]; then
    echo WRF_BASE variable is empty
    echo please set that to know where to download files
    exit $env_error
elif [ -z $SCRIPTS_DIR ]; then
    echo SCRIPTS_DIR variable is empty
    echo please set that to know where the env files located
    exit $env_error
fi

mkdir -p $WRF_BASE/src      # Setup source directory

# prepare utilitly scripts
CLEAN_DOWN=$WRF_BASE/src/wrf_clean_downloads.sh
CLEAN_SRC=$WRF_BASE/src/wrf_clean_source.sh
EXTRACT_SRC=$WRF_BASE/src/wrf_extract_source.sh

util_scr="$CLEAN_SRC $CLEAN_DOWN $EXTRACT_SRC"
for f in $util_scr ; do
    shebang $f
done

#
counter=0
echo no of args: $#
while [ $counter -le $# ]; do
    case $1 in
        all|ALL)
            packages=$all_packages
            for package in ${packages}
            do
                download_package $package
            done
            exit 0
            ;;
        hdf*|HDF*)
            download_package HDF5
            ;;
        netcdf*|NETCDF*)
            download_package NETCDF4
            ;;
        mpich|MPICH)
            download_package MPICH
            ;;
        grads|GRADS )
            download_package GRADS
            ;;
        *)
            download_package $1
            ;;
    esac

    shift
    let counter=counter+1
done

exit 0

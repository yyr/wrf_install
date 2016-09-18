#!/usr/bin/env bash

THIS_FILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $THIS_FILE_DIR/lib/fun.bash

# Check for Environmental varables.
sourceme_sourced

# change list.
app_list=(
    ZLIB
    SZIP
    JPEG
    # LIBPNG
    JASPER
    UDUNITS2
    MPICH
    HDF5
    NETCDF4
    NETCDFF4
    NETCDF4CXX
    # NCVIEW
    WRF
    WPS)

#
function usage()
{
    cat <<EOF
USAGE:
       $0 -options <all|appname>

Where 'appname' is one of the following.
---------------------------------------
EOF
    for app in ${app_list[@]}; do
        echo $app
    done
    cat <<EOF
---------------------------------------

IMPORTANT:
   The order of building apps may need be altered in your case since
   this package doesn't resolve dependencies (yet). So change app_list
   variable in this file to control order of building or call the above
   options one by one manually.

NOTE:
   This script is just a wrapper for indivial builing scripts which are
   located in "build" directory. So how please read them and change them
   freely according to your needs.

EOF
    exit 4

}

function build_app()
{
    export LANG=C
    blue_echo "Building \"$1\" .... "
    . $appsdir/${1}.env

    if [ -d $WRF_BASE/src/${DIR} ]; then
        cd $WRF_BASE/src/${DIR}
    else
        red_echo "WARNING: Seems $1 hasn't been downloaded yet."
        blue_echo "Trying to initiate download"
        $SCRIPTS_DIR/download_app.sh ${1}
        if [ $? -ne 0 ]; then
            red_echo Failed to download: ${1}.
            exit 2
        fi
        cd $WRF_BASE/src/${DIR}
    fi

    for dep in ${DEP[@]}; do        # soruce dep envs
        source $appsdir/$dep.env
    done
    . $appsdir/${1}.env

    blue_echo "Entering $(pwd) to build ${1}"

    . ${SCRIPTS_DIR}/build/${1}.sh

    if [ $? -ne 0 ]; then
        red_echo Failed building ${1}.
        exit
    else
        green_echo "Successfully built ${1} \n\n"
    fi
}

if [ $# -lt 1 ]
then
    echo "${#} arguments."
    usage $0
fi

counter=0
nofargs=$#
while [ $counter -lt $nofargs ]; do
    case $1 in
        all|ALL)
            for app in ${app_list[@]};
            do
                build_app ${app}
            done
            ;;

        *)
            app="${1%.[^.]*}" # strip out ".sh" if available
            build_app $(echo $1 | tr '[:lower:]' '[:upper:]')
            ;;

    esac
    shift
    let counter=counter+1
done

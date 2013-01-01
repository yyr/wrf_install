# change list.
app_list=(ZLIB
    SZIP
    JPEG
    JASPER
    UDUNITS2
    MPICH
    HDF5
    NETCDF4
    NCVIEW
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
    echo "Building \"$1\" .... "
    . $appsdir/${1}.env

    if [ -d $WRF_BASE/src/${DIR} ]; then
        cd $WRF_BASE/src/${DIR}
    else
        echo "warning: no directory named $WRF_BASE/src/${DIR}"
    fi

    for dep in ${DEP[@]}; do        # soruce dep envs
        source $appsdir/$dep.env
    done
    . $appsdir/${1}.env

    echo $(pwd)

    . ${SCRIPTS_DIR}/build/${1}.sh

    if [ $? -ne 0 ]; then
        echo Failed building ${1}.
        exit
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

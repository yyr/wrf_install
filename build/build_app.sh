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
The order of building apps may be altered in your case since this
package doesn't resolve dependencies (yet). So change this app_list variable
for you need.

EOF
    exit 4

}

function build_app()
{
    echo "Building \"$1\" "
    ${SCRIPTS_DIR}/build/${1}.sh
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
while [ $counter -lt $# ]; do
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
    let counter=counter+1
done

# for app in ${apps[@]}; do
#     build_app ${app}
# done

# find . -iname '*.exe' -type f | parallel cp {} {}.$COMP
# find . -iname '*.exe.'${COMP} -type f | parallel -m  cp {} ~/bin/

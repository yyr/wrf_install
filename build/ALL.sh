# change list.
apps=(ZLIB
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
function build_app()
{
    echo "Building \"$1\" "
    ${SCRIPTS_DIR}/build/${1}.sh
    if [ $? -ne 0 ]; then
        echo Failed building ${1}.
        exit
    fi
}

for app in ${apps[@]}; do
    build_app ${app}
done

# find . -iname '*.exe' -type f | parallel cp {} {}.$COMP
# find . -iname '*.exe.'${COMP} -type f | parallel -m  cp {} ~/bin/

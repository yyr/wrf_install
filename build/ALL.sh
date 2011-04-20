./ZLIB.sh
./SZIP.sh
./JPEG.sh
./JASPER.sh
./HDF5.sh
./NETCDF4.sh
./MPICH.sh
./NCARG.sh # note installs binary for GCC only
./WRF.sh
./WPS.sh

find . -iname '*.exe' -type f | parallel cp {} {}.$COMP
find . -iname '*.exe.'${COMP} -type f | parallel -m  cp {} ~/bin/

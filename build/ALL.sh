# the following are independents
./ZLIB.sh
./SZIP.sh
./JPEG.sh
./JASPER.sh
./UDUNITS2.sh
./MPICH.sh


# the following are dependents on other packages
./HDF5.sh
./NETCDF4.sh
./NCVIEW.sh

#./NCARG.sh # note installs binary for GCC only

./WRF.sh
./WPS.sh

# find . -iname '*.exe' -type f | parallel cp {} {}.$COMP
# find . -iname '*.exe.'${COMP} -type f | parallel -m  cp {} ~/bin/

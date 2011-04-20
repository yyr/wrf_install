FILE=configure.wps
sed -i 's/-lnetcdf/-lnetcdf  -lhdf5_hl -lhdf5/g' $FILE

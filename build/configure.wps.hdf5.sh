FILE=configure.wps
cp $FILE $FILE.tmp

sed 's/-lnetcdf/-lnetcdf  -lhdf5_hl -lhdf5 -lz -lm/g' $FILE
#awk 'NR==1,/-lnetcdf/' $FILE.tmp ' /' #> $FILE
#awk '/^ LIB_EXTERNAL/{getline;print $0 " -lhdf5_hl -lhdf5 -lz -lm"}' $FILE.tmp #>> $FILE
#awk '/^ LIB_EXTERNAL/,EOF' $FILE.tmp | tail -n+3 #>> $FILE

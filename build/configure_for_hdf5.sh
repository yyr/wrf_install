FILE=configure.wrf
cp $FILE $FILE.tmp
awk 'NR==1,/^ LIB_EXTERNAL/' $FILE.tmp > $FILE
awk '/^ LIB_EXTERNAL/{getline;print $0 " -lhdf5_hl -lhdf5 -lz -lm"}' $FILE.tmp >> $FILE
awk '/^ LIB_EXTERNAL/,EOF' $FILE.tmp | tail -n+3 >> $FILE

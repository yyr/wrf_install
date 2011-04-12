FILE=configure.wrf
awk 'NR==1,/^ LIB_EXTERNAL/' $FILE
awk '/^ LIB_EXTERNAL/{getline;print $0 " -lhdf5_hl -lhdf5 -lz -lm"}' $FILE
awk '/^ LIB_EXTERNAL/,EOF' $FILE | tail -n+3

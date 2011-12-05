FILE=configure.wps
sed -i 's/-lnetcdff/-lnetcdff  -lhdf5_hl -lhdf5 /g' $FILE

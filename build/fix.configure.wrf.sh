FILE=configure.wrf
cp $FILE $FILE.tmp
perl -i -pe "s!(^[ \t]*-L.*)!\$1 -lhdf5_hl -lhdf5 -lz -lm!" configure.wrf

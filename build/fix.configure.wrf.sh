FILE=configure.wrf
perl -i -pe "s!(^[ \t]*-L.*)!\$1 -L${WRF_BASE}/${dep_root}/lib -lhdf5_hl -lhdf5 -lz -lm!" $FILE

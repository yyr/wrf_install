FILE=configure.wps

# hdf5
perl -i -pe "s!-lnetcdff!-lnetcdff -L${WRF_BASE}/${dep_root}/lib -lhdf5_hl -lhdf5 !g" $FILE

# configure.wps doesn't contain compression libs and compression include
# COMPRESSION_LIBS	= -L$(JASPERLIB)  -ljasper -lpng -lz
# COMPRESSION_INC		= -I$(JASPERINC) \
#                        -I$(JASPERINC)/jasper

perl -i -pe "s!(^COMPRESSION_LIBS.*)!\$1 -L\\$\(JASPERLIB\)  -ljasper -lpng -lz!" $FILE
perl -i -pe "s!(^COMPRESSION_INC.*)!\$1 -I\\$\(JASPERINC\) -I\\$\(JASPERINC\)/jasper!" $FILE

FILE=configure.wps

# hdf5 should be added
sed -i 's/-lnetcdff/-lnetcdff  -lhdf5_hl -lhdf5 /g' $FILE


# configure.wps doesn't contain compression libs and compression include
# COMPRESSION_LIBS	= -L$(JASPERLIB)  -ljasper -lpng -lz
# COMPRESSION_INC		= -I$(JASPERINC) \
#                        -I$(JASPERINC)/jasper

perl -i -pe "s!(^COMPRESSION_LIBS.*)!\$1 -L\\$\(JASPERLIB\)  -ljasper -lpng -lz!" configure.wps
perl -i -pe "s!(^COMPRESSION_INC.*)!\$1 -I\\$\(JASPERINC\) -I\\$\(JASPERINC\)/jasper!" configure.wps

export LD_LIBRARY_PATH=$WRF_BASE/$dep_root/lib:$WRF_BASE/$COMP/lib

./Configure -v

cd config
make -f Makefile.ini
./ymake -config `pwd`

cd ..
read dummy

make Everything | tee make.log

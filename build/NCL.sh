cd config

make -f Makefile.ini
./ymake -config `pwd`

make Everything |& tee make.log

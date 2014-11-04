source ${SCRIPTS_DIR}/lib/fun.bash

command_runner \
    ./configure --prefix=$ZLIB_ROOT ${APP}.${COMP}.config

rm CMakeCache.txt

command_runner \
    cmake -DCMAKE_INSTALL_PREFIX:path=$ZLIB_ROOT .  ${APP}.${COMP}.config
command_runner \
    make clean  ${APP}.${COMP}.clean

command_runner \
    make   ${APP}.${COMP}.make

# command_runner \
#     make check  ${APP}.${COMP}.check

command_runner \
    make install ${APP}.${COMP}.install

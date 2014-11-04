source ${SCRIPTS_DIR}/lib/fun.bash

command_runner \
    ./configure \
    --prefix=$MPICH_ROOT  ${APP}.${COMP}.config

command_runner \
    make clean   ${APP}.${COMP}.clean

command_runner \
    make   ${APP}.${COMP}.make

# command_runner \
# make check   ${APP}.${COMP}.check

command_runner \
    make install  ${APP}.${COMP}.install

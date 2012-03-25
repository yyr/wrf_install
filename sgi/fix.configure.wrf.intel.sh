# sgi mpi instead of mpich2 ----------------------------
perl -i  -pe "s!^DM_FC.*!DM_FC           =       \\$\(SFC\) -lmpi !" configure.wrf
perl -i  -pe "s!^DM_CC.*!DM_CC           =       \\$\(SCC\) -lmpi -DMPI2_SUPPORT!" configure.wrf
perl -i -pe "s!(^FCFLAGS.*)!\$1 -DARCH_INTEL!" configure.wrf
# ------------------------------------------------------

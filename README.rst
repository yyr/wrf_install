Website: https://github.com/yyr/wrf_install

Introduction
============

Building WRF model is tedious. `wrf_install` is a collection of shell
scripts(to be precise bash shell) that let you automate the downloading and
building processes. `wrf_install` is first written by Rick Morgans, so first
thanks to Rick.


How to use?
===========

*First suggestion is try to read and understand the scripts.*,

. DANGER::
  **Go slow for the first time**

That said, here is very sketchy walk through:

Start with sourcing the SOURCEME file. By default, the build will take place
in "~/wrf" directory. Edit SOURCEME file if you want to change the location of
the installation(`WRF_BASE` variable). Set the compiler Option as well and
source that file.


Lets begin by building one dependency first. As mentioned open the SOURCEME
file with your editor, look for customization options.

Customize if you feel necessary:

-  `WRF_BASE` variable. i.e., Directory in which
   downloads/installation should take place. By default it is "~/wrf".

-  Which compilers you want to use. Again by default it is GNU gcc. if
   you have intel instead of gcc compilers. change them accordingly
   (There are comments in that file,it must be easy).


Okay now lets build `zilb` now.

.. code:: bash

   source SOURCEME # this is where you start
   ./download_app.sh ZLIB # download zlib and decompress it
   ./build_app.sh ZLIB


That's it. If everything has gone well as it supposed to be, you have just
downloaded and built & installed `zlib` successfully . See in the
$`WRF_BASE`/$compiler directory.

I strongly **suggest** you to install the components one by one for the
first time around. So its easy for you to see what is going on and
understand how `wrf_install` work.

The following list of components you can install right now.

-  zlib
-  szip
-  jpeg
-  jasper
-  hdf5
-  udunits2
-  netcdf4
-  ncview
-  mpich
-  wrf
-  wps


**Note**: The above order is important. Don't ignore previous errors and go
ahead with next component unless of course you know what you are doing.


Little details on How it works?
------------------------------

`wrf_install` is meant to bring consistency in setting up environment
variables and compiler options. When SOURCEME file is sourced, it will set
`WRF_BASE` variable and compiler options. The sourcing also gives you feedback
what are the compiler options has been set.

Each app has env file which contains few properties(eg., *url* from where that
app can be downloaded) of that app. for eg., zlib has a property file called
``apps/ZLIB.env`` and a build file called ``build/ZLIB.sh``.

Same way, each app has a associated `APP.env` file and a `APP.sh` file in apps
and build directories respectively.  `APP.sh` in build directory which takes
care of building and installation process while learning about app's
properties from `APP.env` file.. luckily most of the apps that need for WRF
just use GNU autotools. So just autoconf, configure and make. So almost no
manual interventions are needed.

Finally building WRF/WPS is tricky because these won't use make directly. So
some compiler options and path need to be changed for the machines you are
building on. For this also I have used perl one liners. This is where you need
to really understand WRF.sh and WPS.sh files. I believe as someone who is
going to use WRF soon, you will be able to easily understand those two
scripts.


How to customize then?
======================

Compiler options
----------------

As it is said in the previous section when you source the file it
invokes to get compiler setting. for gcc you need to customize file.

Configure options
-----------------

Build directory contains individual build scripts. customize them
accordingly.

WRF & WPS
---------

Selection of different build options for wrf/wps configure script is
automated by feeding to the stdin. so customize them to your need, they
also live in the directory. by default serial built is configured. Also
reading the comments in the and can be helpful.


Compilers tested by `wrf_install`
====================================

For now *gcc* and *intel*. *xl* and *pgi* will be supported in the later
versions of `wrf_install`.

+------------+-----------+---------+--------------------------+
| Compiler   | system    | state   | remarks                  |
+============+===========+=========+==========================+
| gcc        | linux     | ✔       | may need minor changes   |
+------------+-----------+---------+--------------------------+
| intel      | linux     | ✔       | may need minor changes   |
+------------+-----------+---------+--------------------------+
| pgi        | linux     | ✖       |                          |
+------------+-----------+---------+--------------------------+
| xl         | Ibm aix   | ✖       |                          |
+------------+-----------+---------+--------------------------+


After first successful installation, go full scale.
--------------------------------------------------
As usual first source the SOURCEME file.

.. code:: bash

    source SOURCEME               # it also spits some useful information, read it
    ./download_app.sh all

(This assumes you have figured out by now, how to automate WRF.sh, WPS.sh.)


Good luck.

===
FAQ
===

SOURCEME problems
-----------------

Source command not found.?
~~~~~~~~~~~~~~~~~~~~~~~~~
Change your shell to bash.

Model Run
---------

error loading so libnetcdff.so.5
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Error message looks like this ./wrf.exe: error while loading shared
  libraries: libnetcdff.so.5: cannot open shared object file: No such file
  or directory


  Set/add path of netcdf in linker directory path export

  .. code:: bash

     export LD_LIBRARY_PATH=/path/to/netcdf/lib:$LD_LIBRARY_PATH


Contributing
============

Any patches/reports/suggestions are most welcome. Drop `me
<mailto:hi◎yagnesh.org>`__ a mail (replace unicode character) or preferably
report on github `issues <https://github.com/yyr/wrf_install/issues>`__ page.


TODO
====

Check dev.org file.


License
=======
GPL 3 (or later); see COPYING file.

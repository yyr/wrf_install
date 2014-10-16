Website: https://github.com/yyr/wrf_install

Introduction
============

Building WRF model is tedious. `wrf_install` is a collection of
shell scripts(to be precise bash shell) to automate the downloading and
building process. `wrf_install` is first started by Rick Morgans
so thanks Rick.

How to use?
===========

Quick read
----------

Start with sourcing the SOURCEME file. By default building process takes
place in "~/wrf" directory. Edit that file if you want to change the
location of the installation(`WRF_BASE` variable). Set the
compiler Option as well and source that file.

.. code:: bash

    source SOURCEME               # it also spits some useful information, read it
    ./download_app.sh all

So now all the needed apps are downloaded and extracted. Check
"~/wrf/src" folder.

Start building by running script.

.. code:: bash

    ./build_app.sh # read what it says.

Little walk through
-------------------

To test how it works.. lets try to install one component.

Open the file with your editor.

Customize:

-  `WRF_BASE` variable. i.e., Directory in which
   downloads/installation should take place. By default it is "~/wrf".
-  Which compilers you want to use. Again by default it is GNU gcc. if
   you have intel instead of gcc compilers. change them accordingly
   (There are comments in that file,it must be easy).

Okay now lets go to the action part. Lets download and build .

.. code:: bash

    source SOURCEME # this is where you start
    ./download_app.sh ZLIB # download zlib and decompress it
    ./build_app.sh ZLIB

That's it.. If everything goes well you have just downloaded and built &
installed . See in the $`WRF_BASE`/$compiler directory.

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

-  How it works?

`wrf_install` is meant to bring consistency in setting up
environment variables. When file is sourced, it will set
`WRF_BASE` variable and compiler options. The sourcing also gives
you feedback how to change these compiler options.

Each app has env file which contains few properties(eg., *url* from
where that app can be downloaded) of that app. for eg., zlib app has a
file called in the directory.

In the same way each app has a file named in build directory which takes
care of installation process while learning about its' properties from
env file and its dependencies' env files. luckily all apps of WRF depend
upon are built by GNU utilities autoconf, configure # and make. So
almost no manual interventions are needed.

Finally building WRF/WPS is tricky because these won't use make
directly. So some compiler options and path need to change and may need
to change file depend on the machine you are working on. For this also
we have oneline perl scripts. For example see the gcc folder there is
file.

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

wrf & wps
---------

Selection of different build options for wrf/wps configure script is
automated by feeding to the stdin. so customize them to your need, they
also live in the directory. by default serial built is configured. Also
reading the comments in the and can be helpful.

Compilers supported by `wrf_install`
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

FAQ
===
See doc folder

License
=======
GPL 3 (or later); see COPYING file.


Contributing
============

Any patches/reports/suggestions are most welcome. Drop `me
<mailto:hi◎yagnesh.org>`__ a mail (replace unicode character) or preferably
report on github `issues <https://github.com/yyr/wrf_install/issues>`__ page.

TODOs
=====

Check dev.org file

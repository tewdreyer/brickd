Brick Daemon
============

This repository contains the source code of the Brick Daemon.

Compiling the Source
--------------------

The following libraries are required:

* libusb-1.0
* libudev (Linux only)

On Debian based Linux distributions try::

 sudo apt-get install libusb-1.0-0-dev libudev-dev

For Windows a suitable pre-compiled libusb binary is part of this repository.
For Mac OS X a suitable libusb version can be obtained via MacPorts or Homebrew.

Linux
^^^^^

A Makefile is provided to compile the source code using GCC::

 cd src/brickd
 make

The ``brickd`` binary is created in ``src/brickd``.

Windows
^^^^^^^

A batch file ``build_exe.bat`` is provided to compile the source code using
the Visual Studio (MSVC) or Windows Driver Kit (WDK) compiler. Open a MSVC or
WDK command prompt::

 cd src\brickd
 build_exe.bat

The ``brickd.exe`` binary is created in ``src\brickd\dist``.

There is also a Makefile to compile the source code using MinGW::

 cd src\brickd
 mingw32-make

The ``brickd.exe`` binary is created in ``src\brickd\dist``.

Mac OS X
^^^^^^^^

A Makefile is provided to compile the source code using GCC::

 cd src/brickd
 make

The ``brickd`` binary is created in ``src/brickd``.

Building Packages
-----------------

The Python script ``src/brickd/build_pkg.py`` can build a Debian package for
Linux, a NSIS based ``setup.exe`` for Windows and a Disk Image for Mac OS X.
Run::

 python build_pkg.py

On Linux this has to be executed as ``root`` and on Windows this has to be
executed from a MSVC or WDK command prompt because it invokes the platform
specific commands to compile the source code.

The installer/package is created in ``src/brickd``.

Commandline Options
-------------------

Common:

**--help**: Show help

**--version**: Show version number

**--check-config**: Check config file for errors

**--debug**: Set all log levels to debug

Windows only:

**--install**: Register as a service and start it

**--uninstall**: Stop service and unregister it

**--console**: Force start as console application

**--log-to-file**: Write log messages to file

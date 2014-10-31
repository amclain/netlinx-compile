# NetLinx Compile

netlinx-compile

A wrapper utility for the AMX NetLinx compiler.

[![Gem Version](https://badge.fury.io/rb/netlinx-compile.png)](http://badge.fury.io/rb/netlinx-compile)

This library provides an executable, `netlinx-compile`, that wraps the `nlrc.exe`
NetLinx compiler provided by AMX. It is designed for easier command line access,
as well as for integration with third-party tools with source code build support,
like text editors and IDE's. Also provided in this library is a Ruby API for
invoking the NetLinx compiler.


## Upgrade Notice

AMX has broken NetLinx compilier functionality between NLRC.exe v1.0
(distributed with NetLinx Studio v3.x) and NLRC.exe v2.1 (distributed with
NetLinx Studio 4). NLRC.exe v2.x was distributed with NetLinx Studio 4 versions
less than 4.1.1204, and has major problems. It is recommended to *avoid*
NLRC.exe v2.x. NLRC.exe v3.x started being distributed in NetLinx Studio
v4.1.1204 and appears to have fixed the problems when compiling include and Duet
files. Due to the major changes in the NetLinx compiler, it may be necessary
to use version 1.x of netlinx-compile when working with projects created with
NetLinx Studio v3.x or earlier.

* Version 1.x of netlinx-compile targets NLRC.exe v1.x.
* NLRC.exe v2.x is considered broken and is unsupported by netlinx-compile.
* Version 3.x of netlinx-compile targets NLRC.exe v3.x.

[AMX NetLinx Compiler Bug List](https://github.com/amclain/netlinx-compile/labels/amx%20bug%20-%20can't%20fix)


## Documentation

[https://sourceforge.net/p/netlinx-compile/wiki/Home/](https://sourceforge.net/p/netlinx-compile/wiki/Home/)

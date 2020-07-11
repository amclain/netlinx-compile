# NetLinx Compile

netlinx-compile

A wrapper utility for the AMX NetLinx compiler.

[![Gem Version](https://badge.fury.io/rb/netlinx-compile.png)](http://badge.fury.io/rb/netlinx-compile)
[![API Documentation](https://img.shields.io/badge/docs-api-blue.svg)](http://www.rubydoc.info/gems/netlinx-compile)
[![Apache 2.0 License](https://img.shields.io/badge/license-Apache%202.0-yellowgreen.svg)](http://www.apache.org/licenses/LICENSE-2.0)

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
v4.1.1204 and appears to have [fixed the problems when compiling include and
Duet files](https://github.com/amclain/netlinx-compile/issues/1). Due to the
major changes in the NetLinx compiler, it may be necessary to use version 1.x of
netlinx-compile when working with projects created with NetLinx Studio v3.x or
earlier.

* Version 1.x of netlinx-compile targets NLRC.exe v1.x.
* NLRC.exe v2.x is considered broken and is unsupported by netlinx-compile.
* Version 3.x of netlinx-compile targets NLRC.exe v3.x.

[AMX NetLinx Compiler Bug List](https://github.com/amclain/netlinx-compile/labels/amx%20bug%20-%20can't%20fix)


## Installation

netlinx-compile is available as a Ruby gem.

1. Install [Ruby](http://www.ruby-lang.org/en/downloads/) 2.0 or higher
(For Windows use [RubyInstaller](http://rubyinstaller.org/downloads/) and make
sure ruby/bin is in your [system path](http://www.computerhope.com/issues/ch000549.htm).)
2. Open the [command line](http://www.addictivetips.com/windows-tips/windows-7-elevated-command-prompt-in-context-menu/) and type:

``` text
    gem install netlinx-compile
    gem install netlinx-workspace (optional: for NetLinx Studio workspace support)
```

*NOTE: The NetLinx compiler executable provided by AMX, nlrc.exe, must be
installed on your computer for this utility to work. It is included in the
NetLinx Studio installation by default.*

**If you receive the following error when running gem install:**
`Unable to download data from https://rubygems.org/ - SSL_connect returned=1`

Follow this guide:
[Workaround RubyGems' SSL errors on Ruby for Windows (RubyInstaller)](https://gist.github.com/luislavena/f064211759ee0f806c88)


## Issues, Bugs, Feature Requests

Any bugs and feature requests should be reported on the GitHub issue tracker:

https://github.com/amclain/netlinx-compile/issues


**Pull requests are preferred via GitHub.**

## Use

**Sublime Text Editor**

NetLinx Compile can be integrated into [Sublime Text](http://www.sublimetext.com/3)
with the [Sublime Text AMX NetLinx Plugin](https://github.com/amclain/sublime-netlinx). This allows NetLinx source code and workspaces to be compiled with the editor's built-in build commands.


**Command Line**

NetLinx Compile provides friendlier command line access than the traditional
NetLinx compiler provided by AMX. For starters, files can now be entered by
relative path (`my_file.axs`) as well as absolute path (`c:\path\to\my_file.axs`).
A more advanced feature, workspace compiling, can invoke the NetLinx compiler on
a workspace file, as well as intelligently seek out a workspace for a given
source code file.


Compile a source code file.

    netlinx-compile -s my_source_code.axs
    
Compile a workspace (with [NetLinx Workspace](https://github.com/amclain/netlinx-workspace)
installed).

    netlinx-compile -s my_workspace.apw

Find the workspace that contains my_source_code.axs and compile it.

    netlinx-compile -w -s my_source_code.axs

Print all of the option flags and their descriptions.

    netlinx-compile -h


**Ruby Developer API**

A Ruby API is provided for developers looking to integrate the NetLinx Compile
library into thier own tools.
[NetLinx Compile Developer Documentation](http://rubydoc.info/gems/netlinx-compile/frames)

NetLinx Compile supports the ability to invoke the compiler on third-party
files, like when creating new types of workspaces. To add NetLinx Compile
support to your Ruby gem, create a handler for your file extension under the
namespace NetLinx::Compile::Extension, place the .rb file under
lib/netlinx/compile/extension in your gem, and add a dependency or development
dependency in your gemspec to the netlinx-compile gem. NetLinx Compile will now
automatically use your gem to compile the file extension it specifies. This is
implemented in NetLinx::Compile::Extension::AXS, as well as in the
[NetLinx Workspace](https://github.com/amclain/netlinx-workspace) gem.

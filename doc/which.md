# which command line tool



## Description

*which* is a command line tool (*scriptlet*) that locates the **executable** file that would have been called by exploring the directories in the *%PATH%*. This functionality is OS-dependent, usually due to the native file system used.

### Details

Depending of the OS, the files are marked as executables either with:

* appending a **known file extension(s)** to its name (like Microsoft's does in MS-DOS/Windows with *.com* *.exe* *.bat* ).
* associating an **execution file attribute/permission/metadata** at the file (done in UNIX-variants like Linux/Android/BSD/others with the *eXecution attribute*).

The equivalents in different OS are:
1. ***which* for GNU/Unix variants**: the executables are marked by an execution permission/attribute, so you the tool need only to look for the file named, exactly as specified, in any of the parts of the *%PATH%*. *which* returns the fully qualified pathnames to the files (or links) which would be executed in the current environment, had it been given as commands. It does search the current directory and then other *%PATH%* directories for an executable file matching the name of the argument. It does NOT canonicalize path names (resolving soft symlinks).
2. ***where.exe* for Microsoft Windows**: It is Win32 equivalent, available from Windows 2003 Server and its succesors. 2000/XP does not have it available by default but can be installed from the Windows 2003 Resource Kit. Availability and working status on previous Windows NT versiones (NT 3.1, NT 4.0) is unknown. Windows 95/98/Me does not have it, probably unneeded due a mixture of hardcoded limitations still present from DOS and the *COMMAND.COM* command line interpreter, and the lack of a *cmd.exe* port for the OS.
3. ***TRUENAME* for MS-DOS**: *TRUENAME* is a hidden command.com native command. It does not find the file passed, only translates virtual paths (due to *subst* / *join*) into real ones. So if you call **C:\USER>TRUEPATH FC**, it will return **C:\USER\FC.EXE** because you can execute it from the current directory due to it being in the PATH, instead of the expected answer of **C:\DOS\FC.EXE**. In other words, it will not locate it but it will show if it is available in the path without executing it.

In other worlds: do not mix-up Unix' [whereis](http://man7.org/linux/man-pages/man1/whereis.1.html) with [which](https://manpages.debian.org/stretch/debianutils/which.1.en.html) or where.exe, which work differently.

### Purpose

To create a highly simplified equivalent to unix which that does not require installing an executable or  using a win-bash script.



## User manual

which.cmd accepts the following parameters:

> which [-a] [-v] \<progName\>+

### Flags

* **-a -all /a /all** are all equivalent flags that enable finding all possible file matches instead of merely stopping at the first when possible.

* **-v -verbose /v /verbose** are all equivalent flags that force the indented output mode that is activated when more that one file to be searched for are specified.

* **progName** are names of executable files that could be called and you are trying to locate in the collection of directories *%PATH%*.
* ***%DEBUG%*** is a system variable, that when defined as an non empty value, will force which to print debug text in execution.

### Examples of use

***\> which***

> **Usage:          which [-a] [-v] <progName>+**<br/>

***\> which ipconfig***

> **C:\Windows\System32\ipconfig.exe**<br/>

***\> which -v ipconfig***

> **ipconfig**<br/>
>     &nbsp;&nbsp;&nbsp;&nbsp;**Windows\System32\ipconfig.exe**<br/>

***\> which ipconfig ifconfig***

> **ipconfig**<br/>
>     &nbsp;&nbsp;&nbsp;&nbsp;**C:\Windows\System32\ipconfig.exe**<br/>
> **ifconfig**<br/>

***\> which ipconfig notepad***

> **ipconfig**<br/>
>     &nbsp;&nbsp;&nbsp;&nbsp;**C:\Windows\System32\ipconfig.exe**<br/>
> **notepad**<br/>
>     &nbsp;&nbsp;&nbsp;&nbsp;**C:\Windows\System32\notepad.exe**<br/>

***\> which -a ipconfig notepad***

> **ipconfig**<br/>
>     &nbsp;&nbsp;&nbsp;&nbsp;**C:\Windows\System32\ipconfig.exe**<br/>
> **notepad**<br/>
>     &nbsp;&nbsp;&nbsp;&nbsp;**C:\Windows\System32\notepad.exe**<br/>
>     &nbsp;&nbsp;&nbsp;&nbsp;**C:\Windows\notepad.exe**<br/>

***\> set DEBUG=ON***
***\> which cmd***
***\> set DEBUG=***

> *DEBUG: FindMode = first, VERBOSE = no*<br/>
> *DEBUG: ArgumentsLoop:Begin*<br/>
> *DEBUG:  PathsLoop:Begin*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.COM*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.EXE*<br/>
> **C:\Windows\System32\cmd.exe**<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.BAT*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.CMD*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.VBS*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.VBE*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.JS*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.JSE*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.WSF*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.WSH*<br/>
> *DEBUG:  Testing for file C:\Windows\system32\cmd.MSC*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.COM*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.EXE*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.BAT*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.CMD*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.VBS*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.VBE*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.JS*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.JSE*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.WSF*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.WSH*<br/>
> *DEBUG:  Testing for file C:\Windows\cmd.MSC*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.COM*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.EXE*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.BAT*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.CMD*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.VBS*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.VBE*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.JS*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.JSE*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.WSF*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.WSH*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\Wbem\cmd.MSC*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.COM*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.EXE*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.BAT*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.CMD*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.VBS*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.VBE*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.JS*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.JSE*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.WSF*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.WSH*<br/>
> *DEBUG:  Testing for file C:\Windows\System32\WindowsPowerShell\v1.0\cmd.MSC*<br/>
> *DEBUG:  PathsLoop:End*<br/>

### Compatibility

It has been tested with Windows 7/8/10 x86 and x64 bit. It should work with Windows XP/2003 too. 
It **MAY** work with Windows 2000, if cmd.exe has been updated. Please confirm.


## Documentation and references

1. [which equivalents](https://stackoverflow.com/questions/304319/is-there-an-equivalent-of-which-on-the-windows-command-line).
2. [which tool](https://en.wikipedia.org/wiki/Which_%28Unix%29)
3. [which man page](https://manpages.debian.org/stretch/debianutils/which.1.en.html)
4. [GNU which for Win32](http://gnuwin32.sourceforge.net/packages/which.htm)
5. [How does %PATH% works on DOS\Windows](https://stackoverflow.com/questions/1653472/whats-the-relative-order-with-which-windows-search-for-executable-files-in-path)
6. [TRUENAME undocumented command for MS-DOS](https://en.wikipedia.org/wiki/List_of_DOS_commands#TRUENAME)
